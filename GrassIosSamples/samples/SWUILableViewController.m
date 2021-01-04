//
//  SWUILableViewController.m
//  GrassIosSamples
//
//  Created by grassswwang(王圣伟) on 2020/12/28.
//

#import "SWUILableViewController.h"
#import <UIKit/UIKit.h>

@interface SWUILableViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UITextView *textview;
@end

@implementation SWUILableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRichText2];
    [self useUITextView];
}

-(void) addHtmlUILable{
    
    NSString *htmlString = @"<html><body><img src=\"lable_icon\" /> Some html string \n <font size=\"13\" color=\"red\">This is some text!</font> </body></html>";
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    UILabel *myLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    myLabel.frame = CGRectMake(50,30, 350,80);
    myLabel.backgroundColor = UIColor.whiteColor;
    myLabel.attributedText = attrStr;
    [self.view addSubview:myLabel];
}


-(void) addRichText2{
    NSString *title = @"上边这样的顺序执行下来是先小图标在文本内容如上图一样，如果你图标想放在后面，就无需多拼接一次，直接用目标文本去拼接图标就可以";
    NSInteger fontsize = 20;
    /*备注：上边这样的顺序执行下来是先小图标在文本内容如上图一样，如果你图标想放在后面，就无需多拼接一次，直接用目标文本去拼接图标就可以，[completeText appendAttributedString:attachmentString];*/
    UILabel *myLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    myLabel.frame = CGRectMake(5,50, 350,100);
    myLabel.backgroundColor = UIColor.whiteColor;
    myLabel.numberOfLines = 2;
    myLabel.font = [UIFont fontWithName:@"" size:fontsize];
    [self.view addSubview:myLabel];
    
    UIFont *font=[UIFont systemFontOfSize:fontsize];
    myLabel.font=font;
    
    //利用NSTextAttachment文UILabel添加图片，并调整位置实现居中对齐
    NSTextAttachment *attach=[[NSTextAttachment alloc] init];
    attach.bounds=CGRectMake(2, -4, 20, 20);
    NSString *imageName = @"lable_icon";
    attach.image = [UIImage imageNamed:imageName];
    
    NSMutableAttributedString *htmlString=[[NSMutableAttributedString alloc] init];
    NSAttributedString *imagePart=[NSAttributedString attributedStringWithAttachment:attach];
    [htmlString appendAttributedString:imagePart];
    
    NSDictionary *tagDict = @{ NSForegroundColorAttributeName: [UIColor redColor] };
    NSAttributedString *tagPart = [[NSAttributedString alloc] initWithString:@"限时特惠 " attributes:tagDict];
    [htmlString appendAttributedString:tagPart];
    
    NSAttributedString *titlePart = [[NSAttributedString alloc] initWithString:title];
    [htmlString appendAttributedString:titlePart];
    myLabel.attributedText=htmlString;
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
                                         NSUnderlineColorAttributeName: [UIColor lightGrayColor],
                                         NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid)};
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
