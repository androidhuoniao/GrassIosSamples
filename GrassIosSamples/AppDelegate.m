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
