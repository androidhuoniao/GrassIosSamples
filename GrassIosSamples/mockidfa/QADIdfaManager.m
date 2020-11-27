//
//  QADIdfaManager.m
//  GrassIosSamples
//
//  Created by grassswwang(王圣伟) on 2020/11/23.
//

#import "QADIdfaManager.h"
#import "QADAdConfigManager.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/ASIdentifierManager.h>

@implementation QADIdfaManager
+ (void)tryRequestIDFAAccess{
    #if DEBUG
    [QADIdfaManager logIDFACondations];
    #endif
   
    BOOL isAfaterIOS14 = @available(iOS 14,*);
    if (!isAfaterIOS14) {
        return;
    }
    BOOL enableRequestAccess = [[QADAdConfigManager sharedInstance] enableIDFAAccessRequest];
    if (!enableRequestAccess) {
        return;
    }
    BOOL notDetermined = ATTrackingManager.trackingAuthorizationStatus == ATTrackingManagerAuthorizationStatusNotDetermined;
    if (!notDetermined) {
        return;
    }
    BOOL shouldIDFARequestAccessSkipAppAlert = [[QADAdConfigManager sharedInstance] shouldIDFARequestAccessSkipAppAlert];
    BOOL isAlertShowing = [QADIdfaManager checkCurrentSIAlertViewShow];
    if (shouldIDFARequestAccessSkipAppAlert && isAlertShowing) {
        return;
    }else{
        [QADIdfaManager requestIDFAAccess];
    }
    
}

+ (void) logIDFACondations{
    BOOL isAfaterIOS14 = @available(iOS 14,*);
    BOOL enableRequestAccess = [[QADAdConfigManager sharedInstance] enableIDFAAccessRequest];
    BOOL notDetermined = ATTrackingManager.trackingAuthorizationStatus == ATTrackingManagerAuthorizationStatusNotDetermined;
    BOOL shouldIDFARequestAccessSkipAppAlert = [[QADAdConfigManager sharedInstance] shouldIDFARequestAccessSkipAppAlert];
    BOOL isAlertShowing = [QADIdfaManager checkCurrentSIAlertViewShow];
    BOOL enable = @available(iOS 14,*) && enableRequestAccess && notDetermined;
    NSLog(@"%s enable:%i, \n isAfaterIOS14:%i, \n enableRequestAccess:%i, \n shouldIDFARequestAccessSkipAppAlert:%i, \n notDetermined:%i, \n isAlertShowing:%i, \n currentTrackingSttaus:%li",
          __func__,enable, isAfaterIOS14, enableRequestAccess,shouldIDFARequestAccessSkipAppAlert,notDetermined,isAlertShowing,ATTrackingManager.trackingAuthorizationStatus);
}

+ (void)requestIDFAAccess{
    NSLog(@"grass_startup_requestIDFAAccessReal-----1");
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                switch (status) {
                    case ATTrackingManagerAuthorizationStatusDenied:
                        NSLog(@"grass_startup_requestIDFAAccessReal-用户拒绝");
                        break;
                    case ATTrackingManagerAuthorizationStatusAuthorized: {
                        NSString *idfa = [ASIdentifierManager.sharedManager advertisingIdentifier].UUIDString;
                        NSLog(@"grass_startup_requestIDFAAccessReal-用户允许 and IDFA: %@",idfa);
                    }
                        break;
                    case ATTrackingManagerAuthorizationStatusNotDetermined:
                        NSLog(@"grass_startup_requestIDFAAccessReal-用户未做选择或未弹窗");
                        break;
                    default:
                        break;
                }
            }];
    }
    NSLog(@"grass_startup_requestIDFAAccessReal-----2");
    NSLog(@"requestIDFAAccessReal---id");
}

//检查当前是否存在自定义弹窗
+ (BOOL)checkCurrentSIAlertViewShow {
    return NO;
}
@end
