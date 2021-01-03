//
//  SWNSAttributeStringViewController.m
//  GrassIosSamples
//
//  Created by 王圣伟 on 2021/1/3.
//

#import "SWNSAttributeStringViewController.h"

@interface SWNSAttributeStringViewController ()
@property(nonatomic,strong) UILabel *uilabel;
@end

@implementation SWNSAttributeStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.uilabel];
    [self setAttributeString];
}

- (void) setAttributeString{
    NSMutableAttributedString *vipStr = [[NSMutableAttributedString alloc]initWithString:@"点击解锁【超级方法"];
    UIImage *vipImage = [UIImage imageNamed:@"vscode_icon"];
    NSTextAttachment *vipImageAttachment = [[NSTextAttachment alloc]init];
    vipImageAttachment.image = vipImage;
    vipImageAttachment.bounds = CGRectMake(0, 0, 20, 20);
    
    NSAttributedString *vipImageAttrStr = [NSAttributedString attributedStringWithAttachment:vipImageAttachment];
    [vipStr insertAttributedString:vipImageAttrStr atIndex:0];
    
    //设置空格文本
    [vipStr insertAttributedString:[[NSAttributedString alloc] initWithString:@" "] atIndex:1];
    //设置间距
    [vipStr addAttribute:NSKernAttributeName value:@(6) range:NSMakeRange(1,1)];
    //设置字体和设置字体的范围
    [vipStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0f] range:NSMakeRange(0, vipStr.length)];
    self.uilabel.attributedText = vipStr;
}

- (UILabel *)uilabel{
    if (!_uilabel) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor orangeColor];
        label.frame = CGRectMake(0, 100, self.view.bounds.size.width,100);
        _uilabel = label;
    }
    return _uilabel;
}
@end
