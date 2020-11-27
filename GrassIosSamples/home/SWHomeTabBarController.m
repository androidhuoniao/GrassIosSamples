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

@interface SWHomeTabBarController ()

@end

@implementation SWHomeTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewControllers = @[[self createIOSTabController],[self createOCTabController]];
    self.selectedIndex = 0;
}

-(UINavigationController *) createIOSTabController{
    SampleListViewController *controller = [[SampleListViewController alloc] init];
    controller.title = @"IOS 示例";
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    navController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"IOS" image:nil tag:0];
    return navController;
}

-(UINavigationController *) createOCTabController{
    SWPureOCViewController *controller = [[SWPureOCViewController alloc] init];
    controller.title = @"OC 示例";
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    navController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"OC" image:nil tag:0];
    return navController;
}

@end
