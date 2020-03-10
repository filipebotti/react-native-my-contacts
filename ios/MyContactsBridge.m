#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(ContactManager, NSObject)

RCT_EXTERN_METHOD(helloWorld: (RCTResponseSenderBlock)callback);
RCT_EXTERN_METHOD(
  getContacts: (RCTPromiseResolveBlock)resolve
  rejecter: (RCTPromiseRejectBlock)reject
);
@end
