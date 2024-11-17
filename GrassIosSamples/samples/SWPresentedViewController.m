//
//  SWPresentedViewController.m
//  GrassIosSamples
//
//  Created by grassswwang on 2024/11/17.
//

#import <Masonry/Masonry.h>
#import "SWPresentedViewController.h"

@interface SWPresentedViewController ()
@property (nonatomic, strong) UIButton *backBtn;
@end

@implementation SWPresentedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.backBtn];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.backBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@(50));
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(150);
    }];
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] init];
        [_backBtn setTitle:@"返回上一页" forState:UIControlStateNormal];
        _backBtn.backgroundColor = UIColor.blueColor;
        // 为按钮添加点击事件
        [_backBtn addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

// 定义按钮点击事件的方法
- (void)backButtonClicked:(UIButton *)sender {
    NSLog(@"按钮被点击了");
//    [self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
