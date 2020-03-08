//
//  MyContacts.m
//  
//
//  Created by Filipe Botti on 08/03/20.
//

#import "MyContacts.h"
#import <React/RCTLog.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@implementation MyContacts

RCT_EXPORT_MODULE();
RCT_EXPORT_METHOD(getContacts)
{
    return [[ABAddressBook sharedAddressBook ] me];
}
@end
