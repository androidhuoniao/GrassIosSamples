//
//  SWNSAttributeStringViewController.m
//  GrassIosSamples
//
//  Created by 王圣伟 on 2021/1/3.
//

#import "SWNSAttributeStringViewController.h"
#import "UILabel+attributeTextAction.h"
#import "SWNSAttributeStringFactory.h"
#import "QADTailWithIconTextView.h"

@interface SWNSAttributeStringViewController ()
@property(nonatomic,strong) UILabel *uiLabel;
@property(nonatomic,strong) UILabel *testLabel;
@property (nonatomic, strong) QADTailWithIconTextView *subTitleTextView;
@property(nonatomic,assign) NSRange adRange;
@end

@implementation SWNSAttributeStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.uiLabel];
    NSAttributedString *attributeString = [self getAttributeString];
    self.uiLabel.attributedText = attributeString;
    [self.uiLabel addAttributeActionWithRange:[NSArray arrayWithObjects:[NSValue valueWithRange:self.adRange], nil] tapTargetAction:^(NSString *string, NSRange range, NSInteger index) {
        NSLog(@"点击字符串:%@ 范围在%@，第%ld个",string,NSStringFromRange(range),index+1);
    }];
    
    [self testsizeThatFits];
    [self testBoundingRectSize];
    [self logAttributedStringMethods];
    [self loadTestLabel];
    self.subTitleTextView.text = @"我是中国人\r\n打打架看见了打算金坷垃就开了江科大龙卷风卡拉胶看了";
    self.subTitleTextView.longText = @"我是中国人\r\n打打架看见了打算金坷垃就开了江科大龙卷风卡拉胶看了";
    [self.view addSubview:self.subTitleTextView];
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

- (NSAttributedString *)getAttributeString{
    NSString *endAdStr = @"广告";
    NSString *text =[@"点击解锁超级方法点击解锁" stringByAppendingString:endAdStr];
    NSLog(@"text.length:%li",text.length);
    NSMutableAttributedString *vipStr = [[NSMutableAttributedString alloc]initWithString:text];
    NSRange adRanage = [vipStr.string rangeOfString:endAdStr];
    self.adRange = adRanage;
    UIImage *vipImage = [UIImage imageNamed:@"vscode_icon"];
    NSTextAttachment *vipImageAttachment = [[NSTextAttachment alloc]init];
    vipImageAttachment.image = vipImage;
    vipImageAttachment.bounds = CGRectMake(0, 0, 20, 20);
    // NSTextAttachment组成的NSAttributedString占据一个字符
    NSAttributedString *vipImageAttrStr = [NSAttributedString attributedStringWithAttachment:vipImageAttachment];
    [vipStr insertAttributedString:vipImageAttrStr atIndex:0];
    NSLog(@"vipImageAttrStr.length:%li",vipImageAttrStr.length);
    
    NSTextAttachment *endImageAttachment = [[NSTextAttachment alloc]init];
    endImageAttachment.image = vipImage;
    endImageAttachment.bounds = CGRectMake(0, 0, 20, 20);
    // NSTextAttachment组成的NSAttributedString占据一个字符
    NSAttributedString *endImageAttrStr = [NSAttributedString attributedStringWithAttachment:endImageAttachment];
    //    [vipStr insertAttributedString:endImageAttrStr atIndex:adRanage.location];
    
    
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

#pragma mark - 测试字符串中有换行符\r或者\r\n是否会影响文本中图标的位置

- (void)loadTestLabel {
    [self.view addSubview:self.testLabel];
    NSString *floatSubTitle = @"中国人民工作大军阀了阿打发大立科技打卡了打死了加法进度款垃圾啊冷冻机房\r\n";
    SWNSAttributeStringFactory *factory = [SWNSAttributeStringFactory createFactoryWithLabelText:@"" floatSubTitle:floatSubTitle];
    self.testLabel.attributedText = [factory truncatedText];
}

- (NSRange)getTitleTextViewTruncatedRangeWithNormalPosterView:(UITextView *)titleTextView {
   
    CGSize maxSize = CGSizeMake(self.view.bounds.size.width, 44);
    

    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:titleTextView.attributedText];
    
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:maxSize];
    textContainer.lineFragmentPadding = titleTextView.textContainer.lineFragmentPadding;
    textContainer.maximumNumberOfLines = titleTextView.textContainer.maximumNumberOfLines;
    textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
    // 防止计算不准确，多减5以获取到截断位置
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(maxSize.width - QADInteractiveImmersiveTitleTextViewAdIconWidth - 5,
                                                                     maxSize.height - QADInteractiveImmersiveTitleTextViewAdIconHeight,
                                                                     QADInteractiveImmersiveTitleTextViewAdIconWidth,
                                                                     QADInteractiveImmersiveTitleTextViewAdIconHeight)];
    // 排除广告标的路径
    textContainer.exclusionPaths = @[path];
    [layoutManager addTextContainer:textContainer];
    // 获取是否有截断的字符
    NSInteger glyphIndex = [layoutManager glyphIndexForCharacterAtIndex:textStorage.length - 1];
    NSRange truncatedRange = [layoutManager truncatedGlyphRangeInLineFragmentForGlyphAtIndex:glyphIndex];
    return truncatedRange;
}

#pragma mark - getter

- (UILabel *)uiLabel{
    if (!_uiLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor orangeColor];
        label.numberOfLines = 2;
        label.frame = CGRectMake(0, 100, self.view.bounds.size.width,100);
        _uiLabel = label;
    }
    return _uiLabel;
}

- (UILabel *)testLabel {
    if (!_testLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor orangeColor];
        label.numberOfLines = 2;
        label.frame = CGRectMake(0, 250, self.view.bounds.size.width, 100);
        _testLabel = label;
    }
    return _testLabel;
}

- (UITextView *)subTitleTextView {
    if (!_subTitleTextView) {
        _subTitleTextView = [[QADTailWithIconTextView alloc] initWithFrame:CGRectZero];
        _subTitleTextView.backgroundColor = UIColor.clearColor;
        _subTitleTextView.userInteractionEnabled = YES;
        _subTitleTextView.textAlignment = NSTextAlignmentCenter;
        _subTitleTextView.editable = NO;
        _subTitleTextView.showsVerticalScrollIndicator = NO;
        _subTitleTextView.showsHorizontalScrollIndicator = NO;
        _subTitleTextView.scrollEnabled = NO;
        _subTitleTextView.linkTextAttributes = @{};
//        _subTitleTextView.delegate = self;
        _subTitleTextView.textContainer.maximumNumberOfLines = 2.0;
        _subTitleTextView.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
        _subTitleTextView.textContainer.lineFragmentPadding = 0;
        _subTitleTextView.textContainerInset = UIEdgeInsetsZero;
        _subTitleTextView.textAlignment = NSTextAlignmentCenter;
        _subTitleTextView.frame = CGRectMake(0, 370, self.view.bounds.size.width, 100);
        _subTitleTextView.backgroundColor = [UIColor orangeColor];
    }
    return _subTitleTextView;
}

@end
