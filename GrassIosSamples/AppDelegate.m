//
//  AppDelegate.m
//  GrassIosSamples
//
//  Created by grass on 2020/11/10.
//

#import "AppDelegate.h"
#import "MainNavViewController.h"
#import "SampleListViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSLog(@"AppDelegate.didFinishLaunchingWithOptions");
    SampleListViewController *navRootVC = [SampleListViewController new];
    navRootVC.title = @"示例列表";
    UINavigationController *mainNavVC = [[UINavigationController alloc] initWithRootViewController:navRootVC];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = mainNavVC;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
