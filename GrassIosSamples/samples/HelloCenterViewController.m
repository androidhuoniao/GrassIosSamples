//
//  HelloCenterViewController.m
//  GrassIosSamples
//
//  Created by 王圣伟 on 2021/5/23.
//

#import "HelloCenterViewController.h"

@interface HelloCenterViewController ()

@end

@implementation HelloCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *orangeView = [[UIView alloc] init];
    orangeView.backgroundColor = [UIColor orangeColor];
    CGRect orangeFrame = CGRectZero;
    orangeFrame.size = CGSizeMake(200.f, 200.f);
    orangeView.frame = orangeFrame;
    [self.view addSubview:orangeView];
    orangeView.center = self.view.center;
    
    UIView *greenView = [[UIView alloc] init];
    greenView.backgroundColor = [UIColor greenColor];
    greenView.frame = CGRectMake(0, 0, 100, 100);
    [orangeView addSubview:greenView];

//    orangeView.frame = CGRectIntegral(orangeView.frame);
//    greenView.center = orangeView.center; // 这种实现方式不ok
    greenView.center = [orangeView convertPoint:orangeView.center fromView:orangeView.superview]; // ok
//    greenView.center = CGPointMake(CGRectGetMidX(orangeView.bounds), CGRectGetMidY(orangeView.bounds)); // ok
    
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = [UIColor blueColor];
    blueView.layer.anchorPoint = CGPointMake(0, 0);
    CGRect blueFrame = CGRectZero;
    blueFrame.size = CGSizeMake(150.f, 150.f);
    blueView.frame = blueFrame;
    blueView.center = self.view.center;
    [self.view addSubview:blueView];
    
    NSLog(@"orangeView center = %@",NSStringFromCGPoint(orangeView.center));
    NSLog(@"blueView center = %@",NSStringFromCGPoint(blueView.center));
    NSLog(@"orangeView bounds = %@",NSStringFromCGRect(orangeView.bounds));
    NSLog(@"blueView bounds = %@",NSStringFromCGRect(blueView.bounds));
}


@end
