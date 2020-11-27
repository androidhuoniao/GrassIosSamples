//
//  SWHomeTabBarController.m
//  GrassIosSamples
//
//  Created by grassswwang(王圣伟) on 2020/11/27.
//

#import "SWHomeTabBarController.h"
#import "SWPureOCViewController.h"
#import "SampleListViewController.h"
#import <UIKit/UIKit.h>
#import "SWNavigationController.h"
#import "SWTVSampleListViewController.h"

@interface SWHomeTabBarController ()

@end

@implementation SWHomeTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewControllers = @[[self createIOSTabController],[self createOCTabController],[self createTvTabController]];
    self.selectedIndex = 0;
}

-(UINavigationController *) createIOSTabController{
    SampleListViewController *controller = [[SampleListViewController alloc] init];
    controller.title = @"IOS 示例";
    UINavigationController *navController = [[SWNavigationController alloc] initWithRootViewController:controller];
    navController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"IOS" image:nil tag:0];
    return navController;
}

-(UINavigationController *) createOCTabController{
    SWPureOCViewController *controller = [[SWPureOCViewController alloc] init];
    controller.title = @"OC 示例";
    UINavigationController *navController = [[SWNavigationController alloc] initWithRootViewController:controller];
    navController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"OC" image:nil tag:0];
    return navController;
}

-(UINavigationController *) createTvTabController{
    SWTVSampleListViewController *controller = [[SWTVSampleListViewController alloc] init];
    controller.title = @"视频示例";
    UINavigationController *navController = [[SWNavigationController alloc] initWithRootViewController:controller];
    navController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"视频" image:nil tag:0];
    return navController;
}

@end
