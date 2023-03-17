//
//  SWConvertRectViewController.m
//  GrassIosSamples
//
//  Created by grassswwang on 2023/3/17.
//  Copyright © 2023 Tencent. All rights reserved.
//

#import "SWConvertRectViewController.h"

@interface SWConvertRectViewController ()

@property (strong, nonatomic) UIView *redView;
@property (strong, nonatomic) UIView *yellowView;
@property (strong, nonatomic) UIView *whiteView;

@end

@implementation SWConvertRectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.redView];
    [self.redView addSubview:self.yellowView];
    [self.redView addSubview:self.whiteView];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    /***
     
     摘要
     
     将矩形从接收器的坐标系转换为另一个视图的矩形。
     宣言
     
     - （CGRect）convertRect：（CGRect）rect toView：（UIView *）view;
     参数
     
     矩形
     在接收器的本地坐标系（边界）中指定的矩形。
     视图
     作为转换操作目标的视图。 如果view为nil，则此方法将转换为窗口基坐标。 否则，视图和接收器都必须属于同一个UIWindow对象。
     */
    
    NSLog(@"redview.frame : %@",NSStringFromCGRect(self.redView.frame));
    NSLog(@"yellowview.frame : %@",NSStringFromCGRect(self.yellowView.frame));
    NSLog(@"whiteview.frame : %@",NSStringFromCGRect(self.whiteView.frame));
    
    /*** 错误示例❎
     CGRect rect1 = [self.whiteview convertRect:self.whiteview.frame toView:self.yellowview];
     NSLog(@"rect1 : %@",NSStringFromCGRect(rect1));
     CGRect rect2 =  [self.yellowview convertRect:rect1 toView:self.yellowview.superview];
     NSLog(@"rect2 : %@",NSStringFromCGRect(rect2));
     */
    
    /**正确示例✅
     CGRect rect1 =  [self.redview convertRect:self.whiteview.frame toView:self.yellowview];
     
     NSLog(@"rect1 : %@",NSStringFromCGRect(rect1));
     
     CGRect rect2 =  [self.yellowview convertRect:rect1 toView:self.yellowview.superview];
     
     NSLog(@"rect2 : %@",NSStringFromCGRect(rect2));
     */
    
    CGRect rect1 =  [self.redView convertRect:self.yellowView.frame toView:self.view];
    
    NSLog(@"红色视图上的黄色视图相对控制器视图的位置(我个人猜测: == 150,150,50,50 )  真实数据: == %@",NSStringFromCGRect(rect1));
    
    CGRect rect2 =  [self.redView convertRect:self.whiteView.frame toView:self.view];
    
    NSLog(@"红色视图上的白色视图相对控制器视图的位置(我个人猜测: == 220,220,50,50 )  真实数据: == %@",NSStringFromCGRect(rect2));
    
//    这两行代码，均可划分为三部分，即：源、目标、被操作的对象。fromView后面接的参数是:源，toView后面接的参数是:目标，convertRect后面接的参数永远是:被操作的对象。作用是：计算源上的被操作的对象相对于目标的frame。举个栗子：
//
//    [viewB convertRect:viewC.frame toView:viewA];
//    该例子中显然viewA是目标，viewC是被操作的对象，那么剩下的viewB自然而然就是源了。作用就是计算viewB上的viewC相对于viewA的frame。
//
//    [viewC convertRect:viewB.frame fromView:viewA];
//    该例子viewA是源，viewB是被操作的对象，那么viewC就是目标。作用就是计算viewA上的viewB相对于viewC的frame。
}

- (UIView *)redView {
    if (!_redView) {
        _redView = [[UIView alloc] init];
        _redView.frame = CGRectMake(100, 100, 200, 200);
        _redView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.3];
    }
    return _redView;
}

- (UIView *)yellowView {
    if (!_yellowView) {
        _yellowView = [[UIView alloc] init];
        _yellowView.frame = CGRectMake(50, 50, 50, 50);
        _yellowView.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.6];
    }
    return _yellowView;
}

- (UIView *)whiteView {
    if (!_whiteView) {
        _whiteView = [[UIView alloc] init];
        _whiteView.frame = CGRectMake(120, 120, 50, 50);
        _whiteView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    }
    return _whiteView;
}

@end
