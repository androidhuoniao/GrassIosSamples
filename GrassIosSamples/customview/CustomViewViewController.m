//
//  CustomViewViewController.m
//  GrassIosSamples
//  自定义view
//  Created by grassswwang(王圣伟) on 2020/11/11.
//

#import "CustomViewViewController.h"
#import "CustomView.h"

@interface CustomViewViewController ()

@end

@implementation CustomViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect viewFrame = self.view.frame;
    CGRect frame = CGRectMake(0,0,viewFrame.size.width,300);
    CustomView *customView = [[CustomView alloc] initWithFrame:frame];
    customView.backgroundColor = UIColor.redColor;
    [self.view addSubview:customView];
}

@end
