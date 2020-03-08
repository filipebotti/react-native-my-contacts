//
//  MyContacts.m
//  
//
//  Created by Filipe Botti on 08/03/20.
//

#import "MyContacts.h"
#import <React/RCTLog.h>

@implementation MyContacts

RCT_EXPORT_MODULE();
RCT_EXPORT_METHOD(getContacts)
{
    RCTLogInfo(@"Hello Contacts");
}
@end
