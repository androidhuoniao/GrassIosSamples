
#import "QADTailWithIconTextView.h"

@interface QADTailWithIconTextView ()
/// 获取点击的touch
@property (nonatomic, strong) UITouch *clickTouch;
/// 用户自定义颜色
@property (nonatomic, strong) UIColor *customTextColor;

@end

@implementation QADTailWithIconTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textColor = [UIColor.whiteColor colorWithAlphaComponent:0.8]; // 设置默认颜色为白色
        self.font = [UIFont fontWithName:@"Arial" size:13.0]; // 设置默认字体为13
        self.imageIcon = [UIImage imageNamed:@"qad_interactive_immersive_adicon"];
    }
    return self;
}

- (instancetype)initWithText:(NSString *)text {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.longText = text;
        self.textColor = [UIColor.whiteColor colorWithAlphaComponent:0.8]; // 设置默认颜色为白色
        self.font = [UIFont fontWithName:@"Arial" size:13.0]; // 设置默认字体为13
        self.imageIcon = [UIImage imageNamed:@"qad_interactive_immersive_adicon"];
    }
    return self;
}

- (void)setTextColor:(UIColor *)textColor {
    [super setTextColor:textColor];
    self.customTextColor = textColor;
}

- (UIColor *)backupTextColor {
    return self.customTextColor != nil ? self.customTextColor : [UIColor.whiteColor colorWithAlphaComponent:0.8];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.attributedText = [self truncatedText];
}

- (NSAttributedString *)truncatedText {
    NSRange truncatedRange = [self truncatedRange];
    if (truncatedRange.location != NSNotFound) {
        // 计算是否有截断，有截断进行文字截断
        NSMutableAttributedString *truncatedAttString = [self truncatedAttString];
        // 防止容器计算失误，将截断字符往前截断...号和图片的字符
        NSRange subRange = [self titleTextAttString].length >= truncatedRange.location ?
                           NSMakeRange(0, truncatedRange.location ):
                           NSMakeRange(0, [self titleTextAttString].length );
        
        NSAttributedString *subAttStr = [[self titleTextAttString] attributedSubstringFromRange:subRange];
        NSMutableAttributedString *mutAttString = subAttStr.mutableCopy;
        [mutAttString appendAttributedString:truncatedAttString];
        return mutAttString;
    }
    
    // 无截断赋值文案
    return [self adAttributedText];
}

- (NSMutableAttributedString *)adAttributedText {
    NSMutableAttributedString *mutAttString = [[NSMutableAttributedString alloc] init];
    [mutAttString appendAttributedString:[self titleTextAttString]];
    [mutAttString appendAttributedString:[self adIconImageAttString]];
    return mutAttString;
}

- (NSMutableAttributedString *)titleTextAttString {
    // 广告文案
    NSMutableAttributedString *mutAttString = [[NSMutableAttributedString alloc] init];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.lineSpacing = 2;
    UIColor *textColor = self.textColor != nil ? self.textColor : [self backupTextColor];
    // 添加文字
    if (self.longText.length) {
        [mutAttString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:self.longText
                                                                                    attributes:@{
            NSForegroundColorAttributeName: textColor,
            NSFontAttributeName: self.font,
            NSLinkAttributeName: gQADQADTailWithIconTextViewAdTextKey,
            NSParagraphStyleAttributeName: paragraphStyle,
        }]];
    }
    return mutAttString;
}

- (NSMutableAttributedString *)adIconImageAttString {
    // 带有广告图标的附件对象
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.lineSpacing = 2;
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = self.imageIcon;
    attachment.bounds = CGRectMake(0, -3, QADTailWithIconTextViewAdIconWidth, QADTailWithIconTextViewAdIconHeight);
    
    // 插入广告图标图片
    NSMutableAttributedString *arrowImageAttString = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    [arrowImageAttString addAttributes:@{
        NSFontAttributeName: self.font,
        NSLinkAttributeName: gQADQADTailWithIconTextViewAdIconKey,
        NSParagraphStyleAttributeName: paragraphStyle,
    }
                                 range:NSMakeRange(0, arrowImageAttString.length)];
    
    
    NSMutableAttributedString *mutAttString = [[NSMutableAttributedString alloc] init];
    // 添加空格文字
    [mutAttString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" "
                                                                                attributes:@{
        NSFontAttributeName:self.font,
        NSLinkAttributeName:gQADQADTailWithIconTextViewAdTextKey,
        NSParagraphStyleAttributeName:paragraphStyle,
    }]];
    [mutAttString appendAttributedString:arrowImageAttString];
    return mutAttString;
}

- (NSMutableAttributedString *)truncatedAttString {
    NSMutableAttributedString *mutAttString = [[NSMutableAttributedString alloc] init];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.lineSpacing = 2;
    UIColor *textColor = self.textColor != nil ? self.textColor : [self backupTextColor];
    // 添加...文字
    [mutAttString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"..."
                                                                                attributes:@{
        NSForegroundColorAttributeName: textColor,
        NSFontAttributeName: self.font,
        NSLinkAttributeName: gQADQADTailWithIconTextViewAdTextKey,
        NSParagraphStyleAttributeName: paragraphStyle,
    }]];
    // 添加广告图标图片
    [mutAttString appendAttributedString:[self adIconImageAttString]];
    return mutAttString;
}

/// 获取截断范围
- (NSRange)truncatedRange {
    CGSize maxSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:self.adAttributedText]; // 文字 + 图片
    
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:maxSize];
    textContainer.lineFragmentPadding = self.textContainer.lineFragmentPadding;
    textContainer.maximumNumberOfLines = self.textContainer.maximumNumberOfLines;
    textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
    // 防止计算不准确，多减5以获取到截断位置
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(maxSize.width - QADTailWithIconTextViewAdIconWidth - 5,
                                                                     maxSize.height - QADTailWithIconTextViewAdIconHeight,
                                                                     QADTailWithIconTextViewAdIconWidth,
                                                                     QADTailWithIconTextViewAdIconHeight)];
    // 排除广告标的路径
    textContainer.exclusionPaths = @[path];
    [layoutManager addTextContainer:textContainer];
    
    // 获取是否有截断的字符
    NSInteger glyphIndex = [layoutManager glyphIndexForCharacterAtIndex:textStorage.length - 1];
    NSRange truncatedRange = [layoutManager truncatedGlyphRangeInLineFragmentForGlyphAtIndex:glyphIndex];

    return truncatedRange;
}

/// 不允许成为第一响应者，禁止复制，拷贝
- (BOOL)canBecomeFirstResponder {
    return NO;
}

/// 获取点击的touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.clickTouch = touches.allObjects.firstObject;
    [super touchesBegan:touches withEvent:event];
}

- (void)setLongText:(NSString *)longText {
    _longText = longText;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setImageIcon:(UIImage *)imageIcon {
    _imageIcon = imageIcon;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
