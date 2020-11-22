//
//  QLAppLaunchTaskList.m
//  GrassIosSamples
//
//  Created by grass on 2020/11/22.
//

#import "QLAppLaunchTaskList.h"
#import "QLAppLaunchTaskList_MainSync1.h"
#import "QLAppLaunchTaskList_Mainsync2.h"

@implementation QLAppLaunchTaskList

+ (QLAppLaunchTaskList *)appLaunchTaskListWithType:(TaskPropertyType)type{
    static QLAppLaunchTaskList *appLaunchTaskList[9] = {0};
    switch (type)
    {
        case MAIN_SYNC1:
        {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                appLaunchTaskList[0] = [[QLAppLaunchTaskList_MainSync1 alloc] init];
            });
            return appLaunchTaskList[0];
        }
            break;

        case MAIN_SYNC2:
        {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                appLaunchTaskList[1] = [[QLAppLaunchTaskList_Mainsync2 alloc] init];
            });
            return appLaunchTaskList[1];
        }
            break;

    }
    return nil;
}
@end
