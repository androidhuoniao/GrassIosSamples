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
    self.uilabel.attributedText = [self getAttributeString];
    [self testsizeThatFits];
    [self testBoundingRectSize];
    [self logAttributedStringMethods];
    
}

- (void)testsizeThatFits{
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 2;
    label.font = [UIFont systemFontOfSize:20];
    label.attributedText = [self getAttributeString];
    CGSize size = [label sizeThatFits:CGSizeMake(self.view.bounds.size.width, 100)];
    NSLog(@"testsizeThatFits size:%@",NSStringFromCGSize(size));
}

/**
 这种方式计算出来的大小是整个文本的大小，虽然设置了constraintSize，但是仅仅是个参考，例如下面的代码，最终的返回值为
 {387.21999999999997, 144.16015625}，高度比100大得多，并且不受行数限制
 options必需写为options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading，否则计算的高度不准确
 */
- (void)testBoundingRectSize{
    NSAttributedString *attributeStr =  [self getAttributeString];
    CGRect rect = [attributeStr boundingRectWithSize:CGSizeMake(self.view.bounds.size.width, 100)
                                             options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                             context:nil];
    NSLog(@"testsizeThatFits rect:%@",NSStringFromCGSize(rect.size));
}

- (NSAttributedString *) getAttributeString{
    
    NSString *text =@"点击解锁超级方法点击解锁";
    NSLog(@"text.length:%li",text.length);
    NSMutableAttributedString *vipStr = [[NSMutableAttributedString alloc]initWithString:text];
    UIImage *vipImage = [UIImage imageNamed:@"vscode_icon"];
    NSTextAttachment *vipImageAttachment = [[NSTextAttachment alloc]init];
    vipImageAttachment.image = vipImage;
    vipImageAttachment.bounds = CGRectMake(0, 0, 20, 20);
    // NSTextAttachment组成的NSAttributedString占据一个字符
    NSAttributedString *vipImageAttrStr = [NSAttributedString attributedStringWithAttachment:vipImageAttachment];
    [vipStr insertAttributedString:vipImageAttrStr atIndex:0];
    NSLog(@"vipImageAttrStr.length:%li",vipImageAttrStr.length);
    
    //设置空格文本
    [vipStr insertAttributedString:[[NSAttributedString alloc] initWithString:@" "] atIndex:1];
    //设置间距
    [vipStr addAttribute:NSKernAttributeName value:@(6) range:NSMakeRange(1,1)];
    //设置字体和设置字体的范围
    [vipStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0f] range:NSMakeRange(0, vipStr.length)];
    return vipStr;
}

- (void)logAttributedStringMethods{
    NSAttributedString *attrString = [self getAttributeString];
    NSLog(@"attrString:%@ length:%li",attrString,attrString.length);
    NSLog(@"attrString.string:%@",attrString.string);
    
    BOOL containsAttachments = [attrString containsAttachmentsInRange:NSMakeRange(0, attrString.length)];
    NSLog(@"containsAttachments:%d",containsAttachments);
    NSAttributedString *subAttrString = [attrString attributedSubstringFromRange:NSMakeRange(0, attrString.length)];
    NSLog(@"subAttrString:%@ length:%li",subAttrString,subAttrString.length);
    NSAttributedString *copyAttrString = attrString.copy;
    NSLog(@"copyAttrString:%@ length:%li",copyAttrString,copyAttrString.length);
    
}

- (UILabel *)uilabel{
    if (!_uilabel) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor orangeColor];
        label.numberOfLines = 2;
        label.frame = CGRectMake(0, 100, self.view.bounds.size.width,100);
        _uilabel = label;
    }
    return _uilabel;
}

@end
