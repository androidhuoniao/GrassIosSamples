//
//  AppDelegate.m
//  GrassIosSamples
//
//  Created by grass on 2020/11/10.
//

#import "AppDelegate.h"
#import "SWNavigationController.h"
#import "SampleListViewController.h"
#import "SWHomeTabBarController.h"
#import "MYURLProtocol.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions{
    NSLog(@"%s is working",__func__);
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"%s is working",__func__);
    SWHomeTabBarController *navRootVC = [SWHomeTabBarController new];
    navRootVC.title = @"示例列表";
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = navRootVC;
    [self.window makeKeyAndVisible];
   
    #if DEBUG
    NSLog(@"debug is working");
    # else
    NSLog(@"release is working");
    #endif
    [NSURLProtocol registerClass:[MYURLProtocol class]];
//    //实现拦截功能
//    Class cls = NSClassFromString(@"WKBrowsingContextController");
//    SEL sel = NSSelectorFromString(@"registerSchemeForCustomProtocol:");
//    if ([(id)cls respondsToSelector:sel]) {
//    #pragma clang diagnostic push
//    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//        [(id)cls performSelector:sel withObject:@"myapp"];
//    #pragma clang diagnostic pop
//    }
    return YES;
}
    
- (void)applicationDidBecomeActive:(UIApplication *)application{
    NSLog(@"%s is working",__func__);
}

- (void)applicationWillResignActive:(UIApplication *)application{
    NSLog(@"%s is working",__func__);
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    NSLog(@"%s is working",__func__);
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
    
    NSLog(@"%s is working",__func__);
}

- (void)applicationWillTerminate:(UIApplication *)application{
    NSLog(@"%s is working",__func__);
}

@end
