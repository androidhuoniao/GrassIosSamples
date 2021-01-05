//
//  SWUITextViewViewController.m
//  GrassIosSamples
//
//  Created by grassswwang(王圣伟) on 2021/1/5.
//

#import "SWUITextViewViewController.h"
@interface SWUITextViewViewController ()
@property(nonatomic,strong)UITextView *textview;
@end

@implementation SWUITextViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self useUITextView];
}

- (void)useUITextView{
    CGFloat font = 18;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"请遵守以下协议《支付宝协议》《微信协议》《建行协议》《招行协议》《中国银行协议》《上海银行协议》"];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"zhifubao://"
                             range:[[attributedString string] rangeOfString:@"《支付宝协议》"]];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"weixin://"
                             range:[[attributedString string] rangeOfString:@"《微信协议》"]];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"jianhang://"
                             range:[[attributedString string] rangeOfString:@"《建行协议》"]];
    
    
    UIImage *image = [UIImage imageNamed:@"lable_icon"];
    CGSize size = CGSizeMake(font + 2, font + 2);
    UIGraphicsBeginImageContextWithOptions(size, false, 0);
    [image drawInRect:CGRectMake(0, 2, size.width, size.height)];
    UIImage *resizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = resizeImage;
    NSMutableAttributedString *imageString = [NSMutableAttributedString attributedStringWithAttachment:textAttachment];
    [imageString addAttribute:NSLinkAttributeName
                        value:@"checkbox://"
                        range:NSMakeRange(0, imageString.length)];
    
    [attributedString insertAttributedString:imageString atIndex:0];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(0, attributedString.length)];
    self.textview.attributedText = attributedString;
    self.textview.linkTextAttributes = @{NSForegroundColorAttributeName: [UIColor blueColor],
                                         NSUnderlineColorAttributeName: [UIColor clearColor],
                                         NSBackgroundColorAttributeName: [UIColor whiteColor],
                                         NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid)
                                         
    };
    [self.view addSubview:self.textview];
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    if ([[URL scheme] isEqualToString:@"jianhang"]) {
        NSLog(@"建行支付---------------");
        return NO;
    } else if ([[URL scheme] isEqualToString:@"zhifubao"]) {
        NSLog(@"支付宝支付---------------");
        return NO;
    } else if ([[URL scheme] isEqualToString:@"weixin"]) {
       NSLog(@"微信支付---------------");
        return NO;
    } else if ([[URL scheme] isEqualToString:@"checkbox"]) {
        NSLog(@"TextAttachment click---------------");
        return NO;
    }
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    NSLog(@"TextAttachment click---------------");
    return YES;
}


- (UITextView *)textview{
    if (!_textview) {
        _textview = [[UITextView alloc] init];
        _textview.delegate = self;
        _textview.editable = NO;        //必须禁止输入，否则点击将弹出输入键盘
        _textview.frame = CGRectMake(0,400, self.view.bounds.size.width,400);
        _textview.scrollEnabled = NO;
        _textview.backgroundColor = UIColor.whiteColor;
    }
    return _textview;
}
@end
