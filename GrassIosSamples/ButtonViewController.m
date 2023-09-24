//
//  ButtonViewController.m
//  GrassIosSamples
//
//  Created by grass on 2020/11/10.
//

#import "ButtonViewController.h"

@interface ButtonViewController ()
@property(nonatomic,strong) UIButton *button;
@property (nonatomic, strong) UIButton *horReplayButton;
@property (nonatomic, strong) UIButton *replayButton;
@end

@implementation ButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[self button]];
    [self.view addSubview:self.horReplayButton];
    [self.view addSubview:self.replayButton];
    self.button.center = CGPointMake(self.view.center.x, self.button.center.y);
    
    self.horReplayButton.frame = CGRectMake(self.button.frame.origin.x,
                                            CGRectGetMaxY(self.button.frame) + 30,
                                            self.horReplayButton.frame.size.width,
                                            self.horReplayButton.frame.size.height);
    [self layoutHorReplaylButton];
    NSLog(@"button_contentEdgeInsets:%@", NSStringFromUIEdgeInsets(self.replayButton.contentEdgeInsets));
    NSLog(@"button_imageEdgeInsets:%@", NSStringFromUIEdgeInsets(self.replayButton.imageEdgeInsets));
    NSLog(@"button_titleEdgeInsets:%@", NSStringFromUIEdgeInsets(self.replayButton.titleEdgeInsets));
    NSLog(@"button_image.frame:%@", NSStringFromCGRect(self.replayButton.imageView.frame));
    NSLog(@"button_title.frame:%@", NSStringFromCGRect(self.replayButton.titleLabel.frame));
}

- (void)layoutHorReplaylButton {
    self.replayButton.titleLabel.backgroundColor = UIColor.redColor;
    self.replayButton.imageView.backgroundColor = UIColor.greenColor;
    self.replayButton.center = self.view.center;
}

- (void)layoutReplaylButton {
    self.replayButton.titleLabel.backgroundColor = UIColor.redColor;
    self.replayButton.imageView.backgroundColor = UIColor.greenColor;
    CGFloat space = 6.f;
    CGFloat titleWidth = 30;
    CGFloat replayButtonWidth = self.replayButton.frame.size.width;
    NSString *replayButtonTitle = [self.replayButton titleForState:UIControlStateNormal];
    UIImage *replayButtonImage = [self.replayButton imageForState:UIControlStateNormal];
    CGFloat imageHeight = replayButtonImage.size.height;
    CGFloat imageWidth = replayButtonImage.size.width;
    CGFloat titleHeight = [replayButtonTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}].height;
    CGFloat imageLeft = titleWidth * 0.5;
    imageLeft = (replayButtonWidth - imageWidth) * 0.5;
    [self.replayButton setImageEdgeInsets:UIEdgeInsetsMake(-(imageHeight * 0.5 + space * 0.5),
                                                           imageLeft,
                                                           imageHeight * 0.5 + space * 0.5,
                                                           -imageLeft)];
    [self.replayButton setTitleEdgeInsets:UIEdgeInsetsMake(titleHeight * 0.5 + space * 0.5,
                                                           -imageWidth * 0.5,
                                                           -(titleHeight * 0.5 + space * 0.5),
                                                           imageWidth*0.5)];
    self.replayButton.bounds = CGRectMake(0, 0, replayButtonWidth, 60);
    self.replayButton.center = self.view.center;
}

- (void)layoutReplaylButton2 {
    CGFloat replayButtonWidth = self.replayButton.frame.size.width;
    //设置水平和竖直的对齐方式
    self.replayButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.replayButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    CGRect imageRect = self.replayButton.imageView.frame;
    CGRect titleRect = self.replayButton.titleLabel.frame;
    CGRect buttonRect = self.replayButton.frame; //图中?1的值
    CGFloat image_l = (buttonRect.size.width - imageRect.size.width) / 2; //确定image的位置
    self.replayButton.imageEdgeInsets = UIEdgeInsetsMake(20, image_l, -20, -image_l); //图中?2的值
    CGFloat title_l = imageRect.size.width - (buttonRect.size.width - titleRect.size.width) / 2; //图中?3的值
    CGFloat title_t = imageRect.size.height + 40; //title的位置可以确定了
    self.replayButton.titleEdgeInsets = UIEdgeInsetsMake(title_t, -title_l, -title_t, title_l); //图中?4的值
    CGFloat button_b = titleRect.size.height + 60; //计算图中?5的值
    CGFloat max_w = MAX(titleRect.size.width, imageRect.size.width);
    CGFloat button_l = -(buttonRect.size.width-(max_w + 20 * 2)) / 2; //button要调整的大小确定了
    self.replayButton.contentEdgeInsets = UIEdgeInsetsMake(0, button_l, button_b, button_l);
    self.replayButton.bounds = CGRectMake(0, 0, replayButtonWidth, 60);
    self.replayButton.center = self.view.center;
}

-(void)onClickAction:(UIButton *) button{
    NSLog(@"onClickAction is working");
}

- (UIButton *)button{
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(50, 100, 250, 50);
        _button.backgroundColor = UIColor.redColor;
        [_button setTitle:@"1111" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(onClickAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _button;
}

- (UIButton *)replayButton{
    if (!_replayButton) {
        _replayButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_replayButton setTitle:@"重播" forState:UIControlStateNormal];
        _replayButton.bounds = CGRectMake(0, 0, 90, 28);
        UIImage *image = [UIImage imageNamed:@"player_end_btn_icon_replay"];
        [_replayButton setImage:image forState:UIControlStateNormal];
        _replayButton.backgroundColor = UIColor.grayColor;
    }
    return _replayButton;
}

- (UIButton *)horReplayButton {
    if (!_horReplayButton) {
        _horReplayButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_horReplayButton setTitle:@"重播" forState:UIControlStateNormal];
        _horReplayButton.bounds = CGRectMake(0, 0, 90, 28);
        UIImage *image = [UIImage imageNamed:@"player_end_btn_icon_replay"];
        [_horReplayButton setImage:image forState:UIControlStateNormal];
        _horReplayButton.backgroundColor = UIColor.grayColor;
        _horReplayButton.titleLabel.backgroundColor = UIColor.redColor;
        _horReplayButton.imageView.backgroundColor = UIColor.greenColor;
    }
    return _horReplayButton;
}

@end
