//
//  HelloFrameAndBoundsViewController.m
//  GrassIosSamples
//
//  Created by 王圣伟 on 2021/5/22.
//

#import "HelloFrameAndBoundsViewController.h"

@interface HelloFrameAndBoundsViewController ()
@property (nonatomic, strong) UILabel *myLabel;
@property (nonatomic, strong) UIButton *changeBoundsOriginBtn;
@property (nonatomic, strong) UIButton *changeBoundsSizeBtn;
@property (nonatomic, strong) UIView *containerView;

@end

@implementation HelloFrameAndBoundsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.containerView];
    [self.view addSubview:self.myLabel];
    [self.view addSubview:self.changeBoundsOriginBtn];
    [self.view addSubview:self.changeBoundsSizeBtn];
    
    UIGestureRecognizer *clickBoundsBtnListener = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeContainerBoundsOrigin)];
    [self.changeBoundsOriginBtn addGestureRecognizer:clickBoundsBtnListener];
    
    UIGestureRecognizer *clickBoundsSizeBtnListener = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeBoundsSize)];
    [self.changeBoundsSizeBtn addGestureRecognizer:clickBoundsSizeBtnListener];
    
    self.containerView.frame = CGRectMake(100, 100, 300, 400);
//    self.containerView.bounds = CGRectMake(50, 50, 300, 400);
    self.myLabel.frame = CGRectMake(0, 0, 130, 130);
    NSLog(@"containerView.center:%@",NSStringFromCGPoint(self.containerView.center));
    NSLog(@"myLabel.center:%@",NSStringFromCGPoint(self.myLabel.center));
    self.myLabel.center = self.containerView.center;
    
}

- (void)viewWillLayoutSubviews {
    
}

- (void)changeBoundsOrigin {
    NSLog(@"%s is working",__func__);
    CGFloat offset = 50;
    CGPoint origin = self.myLabel.bounds.origin;
    CGPoint newOrigin = CGPointMake(origin.x + offset, origin.y + offset);
    CGRect newBounds = CGRectZero;
    newBounds.origin = newOrigin;
    newBounds.size = self.myLabel.bounds.size;
    self.myLabel.bounds = newBounds;
    self.myLabel.text = NSStringFromCGRect(self.myLabel.bounds);
}

- (void)changeBoundsSize {
    NSLog(@"%s is working",__func__);
    CGFloat offset = 20;
    CGRect newBounds = CGRectZero;
    CGSize oldSize = self.myLabel.bounds.size;
    newBounds.origin = self.myLabel.bounds.origin;
    newBounds.size = CGSizeMake(oldSize.width + offset, oldSize.height + offset);
    self.myLabel.bounds = newBounds;
    self.myLabel.text = NSStringFromCGRect(self.myLabel.bounds);
}

- (void)changeContainerBoundsOrigin {
    NSLog(@"%s is working",__func__);
    CGFloat offset = 50;
    CGPoint origin = self.containerView.bounds.origin;
    CGPoint newOrigin = CGPointMake(origin.x + offset, origin.y + offset);
    CGRect newBounds = CGRectZero;
    newBounds.origin = newOrigin;
    newBounds.size = self.containerView.bounds.size;
    self.containerView.bounds = newBounds;
    self.myLabel.text = NSStringFromCGRect(self.containerView.bounds);
}

- (UILabel *)myLabel {
    if (!_myLabel) {
        _myLabel = [[UILabel alloc] init];
        _myLabel.backgroundColor = UIColor.blueColor;
        _myLabel.frame = CGRectMake(100, 200, 130, 130);
    }
    return _myLabel;
}

- (UIButton *)changeBoundsOriginBtn {
    if (!_changeBoundsOriginBtn) {
        _changeBoundsOriginBtn = [[UIButton alloc] init];
        _changeBoundsOriginBtn.backgroundColor = UIColor.redColor;
        [_changeBoundsOriginBtn setTitle:@"change bounds origin" forState:UIControlStateNormal];
        _changeBoundsOriginBtn.frame = CGRectMake(0, 600, self.view.frame.size.width, 50);
    }
    return _changeBoundsOriginBtn;
}

- (UIButton *)changeBoundsSizeBtn {
    if (!_changeBoundsSizeBtn) {
        _changeBoundsSizeBtn = [[UIButton alloc] init];
        _changeBoundsSizeBtn.backgroundColor = UIColor.redColor;
        [_changeBoundsSizeBtn setTitle:@"change bounds size " forState:UIControlStateNormal];
        _changeBoundsSizeBtn.frame = CGRectMake(0, 700, self.view.frame.size.width, 50);
    }
    return _changeBoundsSizeBtn;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor orangeColor];
       
    }
    return _containerView;
}


@end
