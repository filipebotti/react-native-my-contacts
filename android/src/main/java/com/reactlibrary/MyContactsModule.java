package com.reactlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.PromiseImpl;
import com.facebook.react.bridge.Callback;
import com.facebook.react.modules.permissions.PermissionsModule;

import android.support.v4.app.ActivityCompat;
import android.support.v7.app.AppCompatActivity;

import android.provider.ContactsContract;
import android.database.Cursor;
import android.content.ContentResolver;

public class MyContactsModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;

    public MyContactsModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "ContactManager";
    }

    @ReactMethod
    public void getContacts(final Promise promise) {        
        final PermissionsModule perms = getReactApplicationContext().getNativeModule(PermissionsModule.class);

        final Callback onPermissionGranted = new Callback() {
            @Override
            public void invoke(Object... args) {
                String result = (String) args[0];
                if (result == "granted") {
                    promise.resolve(readContacts());
                } else {
                    promise.reject("UNAUTHORIZED");
                }
            }
        };

        final Callback onPermissionDenied = new Callback() {
            @Override
            public void invoke(Object... args) {
                promise.reject("UNAUTHORIZED");
            }
        };

        Callback onPermissionCheckFailed = new Callback() {
            @Override
            public void invoke(Object... args) {
                promise.reject("FAILED");
            }
        };

        Callback onPermissionChecked = new Callback() {
            @Override
            public void invoke(Object... args) {
                boolean hasPermission = (boolean) args[0];

                if (!hasPermission) {
                    perms.requestPermission(android.Manifest.permission.READ_CONTACTS, new PromiseImpl(onPermissionGranted, onPermissionDenied));
                } else {
                    promise.resolve(readContacts());
                }
            }
        };

        perms.checkPermission(android.Manifest.permission.READ_CONTACTS, new PromiseImpl(onPermissionChecked, onPermissionCheckFailed));

    }


    public WritableArray readContacts() {
        ContentResolver cr = this.reactContext.getApplicationContext().getContentResolver();
        Cursor cur = cr.query(ContactsContract.Contacts.CONTENT_URI,
                null, null, null, null);
        WritableArray contacts = Arguments.createArray();
        
        
        if ((cur != null ? cur.getCount() : 0) > 0) {
            while (cur != null && cur.moveToNext()) {
                WritableMap contact = Arguments.createMap();

                String id = cur.getString(
                        cur.getColumnIndex(ContactsContract.Contacts._ID));
                String name = cur.getString(cur.getColumnIndex(
                        ContactsContract.Contacts.DISPLAY_NAME));

                if (cur.getInt(cur.getColumnIndex(
                        ContactsContract.Contacts.HAS_PHONE_NUMBER)) > 0) {
                    Cursor pCur = cr.query(
                            ContactsContract.CommonDataKinds.Phone.CONTENT_URI,
                            null,
                            ContactsContract.CommonDataKinds.Phone.CONTACT_ID + " = ?",
                            new String[]{id}, null);
                    
                    WritableArray phones = Arguments.createArray();                    
                    while (pCur.moveToNext()) {
                        String phoneNo = pCur.getString(pCur.getColumnIndex(
                                ContactsContract.CommonDataKinds.Phone.NUMBER));
                        WritableMap phone = Arguments.createMap();  
                        phone.putString("value", phoneNo);
                        phones.pushMap(phone);
                    }
                    pCur.close();
                    contact.putString("name", name);
                    contact.putArray("phones", phones);
                    contacts.pushMap(contact);
                }
            }
        }
        if(cur!=null){
            cur.close();
        }

        return contacts;
    }
}
