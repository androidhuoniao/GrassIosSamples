//
//  SWPresentViewController.m
//  GrassIosSamples
//
//  Created by grassswwang on 2024/11/17.
//

#import <Masonry/Masonry.h>
#import "SWPresentedViewController.h"
#import "SWPresentViewController.h"

//typedef NS_ENUM(NSInteger, UIModalPresentationStyle) {
//    UIModalPresentationFullScreen = 0,
//    UIModalPresentationPageSheet API_AVAILABLE(ios(3.2)) API_UNAVAILABLE(tvos),
//    UIModalPresentationFormSheet API_AVAILABLE(ios(3.2)) API_UNAVAILABLE(tvos),
//    UIModalPresentationCurrentContext API_AVAILABLE(ios(3.2)),
//    UIModalPresentationCustom API_AVAILABLE(ios(7.0)),
//    UIModalPresentationOverFullScreen API_AVAILABLE(ios(8.0)),
//    UIModalPresentationOverCurrentContext API_AVAILABLE(ios(8.0)),
//    UIModalPresentationPopover API_AVAILABLE(ios(8.0)) API_UNAVAILABLE(tvos),
//    UIModalPresentationBlurOverFullScreen API_AVAILABLE(tvos(11.0)) API_UNAVAILABLE(ios) API_UNAVAILABLE(watchos),
//    UIModalPresentationNone API_AVAILABLE(ios(7.0)) = -1,
//    UIModalPresentationAutomatic API_AVAILABLE(ios(13.0)) API_UNAVAILABLE(watchos) = -2,
//} API_UNAVAILABLE(watchos);

@interface SWPresentViewController ()

@property (nonatomic, strong) UIButton *defaultBtn;
@property (nonatomic, strong) UIButton *fullScreenBtn;
@property (nonatomic, strong) UIButton *pageSheetBtn;
@property (nonatomic, strong) UIButton *formSheetBtn;
@end

@implementation SWPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.defaultBtn];
    [self.view addSubview:self.fullScreenBtn];
    [self.view addSubview:self.pageSheetBtn];
    [self.view addSubview:self.formSheetBtn];
    
    [self.defaultBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@(50));
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(150);
    }];
    [self.fullScreenBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@(50));
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(self.defaultBtn.mas_bottom).mas_offset(30);
    }];
    [self.pageSheetBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@(50));
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(self.fullScreenBtn.mas_bottom).mas_offset(30);
    }];
    [self.formSheetBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@(50));
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(self.pageSheetBtn.mas_bottom).mas_offset(30);
    }];
}

- (UIButton *)defaultBtn {
    if (!_defaultBtn) {
        _defaultBtn = [[UIButton alloc] init];
        [_defaultBtn setTitle:@"default" forState:UIControlStateNormal];
        _defaultBtn.backgroundColor = UIColor.grayColor;
        [_defaultBtn addTarget:self action:@selector(defaultButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _defaultBtn;
}

- (UIButton *)fullScreenBtn {
    if (!_fullScreenBtn) {
        _fullScreenBtn = [[UIButton alloc] init];
        [_fullScreenBtn setTitle:@"fullScreen" forState:UIControlStateNormal];
        _fullScreenBtn.backgroundColor = UIColor.grayColor;
        [_fullScreenBtn addTarget:self action:@selector(fullScreenButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullScreenBtn;
}

- (UIButton *)pageSheetBtn {
    if (!_pageSheetBtn) {
        _pageSheetBtn = [[UIButton alloc] init];
        [_pageSheetBtn setTitle:@"_pageSheet" forState:UIControlStateNormal];
        _pageSheetBtn.backgroundColor = UIColor.grayColor;
        [_pageSheetBtn addTarget:self action:@selector(pageSheetButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pageSheetBtn;
}

- (UIButton *)formSheetBtn {
    if (!_formSheetBtn) {
        _formSheetBtn = [[UIButton alloc] init];
        [_formSheetBtn setTitle:@"formSheet" forState:UIControlStateNormal];
        _formSheetBtn.backgroundColor = UIColor.grayColor;
        // 为按钮添加点击事件
        [_formSheetBtn addTarget:self action:@selector(formSheetButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _formSheetBtn;
}

// 定义按钮点击事件的方法
- (void)defaultButtonClicked:(UIButton *)sender {
    UIViewController *vc = [[SWPresentedViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    NSLog(@"按钮被点击了 modalPresentationStyle:%ld ", nav.modalPresentationStyle);
    [self presentViewController:nav animated:YES completion:nil];
}

// 定义按钮点击事件的方法
- (void)fullScreenButtonClicked:(UIButton *)sender {
    NSLog(@"按钮被点击了");
    UIViewController *vc = [[SWPresentedViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:YES completion:nil];
}

// 定义按钮点击事件的方法
- (void)pageSheetButtonClicked:(UIButton *)sender {
    NSLog(@"按钮被点击了");
    UIViewController *vc = [[SWPresentedViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationPageSheet;
    [self presentViewController:nav animated:YES completion:nil];
}

// 定义按钮点击事件的方法
- (void)formSheetButtonClicked:(UIButton *)sender {
    NSLog(@"按钮被点击了");
    UIViewController *vc = [[SWPresentedViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:nav animated:YES completion:nil];
}

@end
