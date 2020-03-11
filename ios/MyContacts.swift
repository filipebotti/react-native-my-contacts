//
//  MyContacts.swift
//  MyContacts
//
//  Created by Filipe Botti on 08/03/20.
//  Copyright © 2020 Facebook. All rights reserved.
//
import Contacts;

@objc(ContactManager)
class ContactManager: NSObject {

    @objc
    func getContacts(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
        let store = CNContactStore()
        let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)

        
        if authorizationStatus == .notDetermined {
        
            store.requestAccess(for: .contacts) { [weak self] didAuthorize,
            error in
                if didAuthorize {
                    let contacts: [CNContact] = self!.retrieveContacts(from: store)
                    let data = self!.parseContactsToDict(contacts)
                    resolve(data)
                } else {
                    reject("UNAUTHORIZED", "User unauthorized your access", error)
                }
            }
        } else if authorizationStatus == .authorized {
            let contacts: [CNContact] = retrieveContacts(from: store)
            let data = parseContactsToDict(contacts)
            resolve(data)
        } else if authorizationStatus == .denied {
            store.requestAccess(for: .contacts) { [weak self] didAuthorize,
            error in
                if didAuthorize {
                    let contacts: [CNContact] = self!.retrieveContacts(from: store)
                    let data = self!.parseContactsToDict(contacts)
                    resolve(data)
                } else {
                    reject("UNAUTHORIZED", "User unauthorized your access", error)
                }
            }
        } else {
            reject("FAILED", "Failed when tried to retrieve contacts", NSError(domain: "CONTACT", code: 200, userInfo: nil))
        }
        
    }
    
    @objc
    func parseContactsToDict(_ contacts: [CNContact]) -> [[String: Any]] {
        var response : [[String: Any]] = []
        
        for contact in contacts {
            var dict: [String: Any] = ["name": contact.givenName]
            var phones : [[String : Any]] = []
            
            for phone in contact.phoneNumbers {
                phones.append([
                    "label": CNLabeledValue<NSString>.localizedString(forLabel: phone.label!).capitalized,
                    "value": phone.value.stringValue,
                ])
            }
            
            dict["phones"] = phones
            response.append(dict)            
        }
        return response
    }

    @objc
    func retrieveContacts(from store: CNContactStore) -> [CNContact]{
    let containerId = store.defaultContainerIdentifier()
    let predicate = CNContact.predicateForContactsInContainer(withIdentifier: containerId)
    // 4
    let keysToFetch = [CNContactGivenNameKey as CNKeyDescriptor,
                       CNContactPhoneNumbersKey as CNKeyDescriptor]

    let contacts = try! store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch)

    // 5
    return contacts
  }
}
