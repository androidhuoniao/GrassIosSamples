//
//  SWNSAttributeStringFactory.m
//  GrassIosSamples
//
//  Created by grassswwang on 2023/7/25.
//  Copyright © 2023 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWNSAttributeStringFactory.h"

static NSString * const gQADInteractiveImmersiveOptimizationNormalPosterViewAdLabelKey = @"gQADInteractiveImmersiveOptimizationNormalPosterViewAdLabelKey";
static NSString * const gQADInteractiveImmersiveOptimizationNormalPosterViewSubTitleKey = @"gQADInteractiveImmersiveOptimizationNormalPosterViewSubTitleKey";
static NSString * const gQADInteractiveImmersiveOptimizationNormalPosterViewFeedbackIconKey = @"gQADInteractiveImmersiveOptimizationNormalPosterViewFeedbackIconKey";



@interface SWNSAttributeStringFactory ()
/// 标签文案
@property (nonatomic, copy) NSString *adLabelText;
/// 广告主文案
@property (nonatomic, copy) NSString *floatSubTitle;
/// 截断区域
@property (nonatomic, assign) NSRange truncatedRange;

@end

@implementation SWNSAttributeStringFactory

- (instancetype)init {
    self = [super init];
    if (self) {
        _truncatedRange = NSMakeRange(NSNotFound, 0);
    }
    return self;
}

+ (SWNSAttributeStringFactory *)createFactoryWithLabelText:(NSString *)adLabelText floatSubTitle:(NSString *)floatSubTitle {
    SWNSAttributeStringFactory *factory = [[SWNSAttributeStringFactory alloc] init];
    factory.adLabelText = adLabelText;
    factory.floatSubTitle = floatSubTitle;
    if ([factory.floatSubTitle hasSuffix:@"\r"]) {
        factory.floatSubTitle = [factory.floatSubTitle stringByReplacingOccurrencesOfString:@"\r" withString:@" "];
    } else if ([factory.floatSubTitle hasSuffix:@"\r\n"]) {
        factory.floatSubTitle = [factory.floatSubTitle stringByReplacingOccurrencesOfString:@"\r\n" withString:@" "];
    }
    return factory;
}

- (NSMutableAttributedString *)adAttributedText {
    NSMutableAttributedString *mutAttString = [[NSMutableAttributedString alloc] init];
    [mutAttString appendAttributedString:[self titleTextAttString]];
    [mutAttString appendAttributedString:[self adIconImageAttString]];
    return mutAttString;
}

/// 广告文案，只有广告标签和广告标题，不带广告图标
- (NSMutableAttributedString *)titleTextAttString {
    // 广告文案
    NSMutableAttributedString *mutAttString = [[NSMutableAttributedString alloc] init];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    // 添加标签
    if (self.adLabelText.length) {
        [mutAttString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:self.adLabelText
                                                                                    attributes:@{
            NSForegroundColorAttributeName: [UIColor redColor],
            NSFontAttributeName:[UIFont systemFontOfSize:14],
            NSLinkAttributeName:gQADInteractiveImmersiveOptimizationNormalPosterViewAdLabelKey,
            NSParagraphStyleAttributeName:paragraphStyle,
        }]];
    }
    
    // 添加广告文案
    if (self.floatSubTitle.length) {
        [mutAttString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ", self.floatSubTitle]
                                                                                    attributes:@{
            NSForegroundColorAttributeName: UIColor.whiteColor,
            NSFontAttributeName:[UIFont systemFontOfSize:14],
            NSLinkAttributeName:gQADInteractiveImmersiveOptimizationNormalPosterViewSubTitleKey,
            NSParagraphStyleAttributeName:paragraphStyle,
        }]];
    }
    
    return mutAttString;
}

- (NSMutableAttributedString *)adIconImageAttString {
    // 带有广告图标的附件对象
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.lineSpacing = 5;
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"qad_interactive_immersive_adicon"];
    attachment.bounds = CGRectMake(0, -3, QADInteractiveImmersiveTitleTextViewAdIconWidth, QADInteractiveImmersiveTitleTextViewAdIconHeight);
    
    // 插入广告图标图片
    NSMutableAttributedString *arrowImageAttString = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    [arrowImageAttString addAttributes:@{
        NSFontAttributeName:[UIFont systemFontOfSize:14],
        NSLinkAttributeName:gQADInteractiveImmersiveOptimizationNormalPosterViewFeedbackIconKey,
        NSParagraphStyleAttributeName:paragraphStyle,
    }
                                 range:NSMakeRange(0, arrowImageAttString.length)];
    return arrowImageAttString;
}

// 截断文案，是... 省略号和广告图标
- (NSMutableAttributedString *) truncatedAttString {
    NSMutableAttributedString *mutAttString = [[NSMutableAttributedString alloc] init];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.lineSpacing = 5;
    
    // 添加...文字
    [mutAttString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"... "
                                                                                attributes:@{
        NSForegroundColorAttributeName: UIColor.whiteColor,
        NSFontAttributeName:[UIFont systemFontOfSize:14],
        NSLinkAttributeName:gQADInteractiveImmersiveOptimizationNormalPosterViewSubTitleKey,
        NSParagraphStyleAttributeName:paragraphStyle,
    }]];
    // 添加广告图标图片
    [mutAttString appendAttributedString:[self adIconImageAttString]];
    return mutAttString;
}

- (NSAttributedString *)truncatedText {
    NSRange truncatedRange = self.truncatedRange;
    NSLog(@"grass_immer_truncatedRange:%@ notFound:%d", NSStringFromRange(truncatedRange), (truncatedRange.location != NSNotFound));
    if (truncatedRange.location != NSNotFound) {
        // 计算是否有截断，有截断进行文字截断
        NSMutableAttributedString *truncatedAttString = [self truncatedAttString];
        NSLog(@"grass_immer_truncatedAttString:%@", truncatedAttString);
        NSLog(@"grass_immer_titleTextAttString:%@", [self titleTextAttString]);
        // 防止容器计算失误，将截断字符往前截断...号和图片的字符
        NSRange subRange = [self titleTextAttString].length >= (truncatedRange.location - truncatedAttString.length) ?
                           NSMakeRange(0, truncatedRange.location - truncatedAttString.length):
                           NSMakeRange(0, [self titleTextAttString].length - truncatedAttString.length);
        NSLog(@"grass_immer_subRange:%@ titleTextAttString.length:%ld", NSStringFromRange(subRange), [self titleTextAttString].length);
        NSAttributedString *subAttStr = [[self titleTextAttString] attributedSubstringFromRange:subRange];
        NSMutableAttributedString *mutAttString = subAttStr.mutableCopy;
        [mutAttString appendAttributedString:truncatedAttString];
        NSLog(@"grass_immer_truncatedText:%@", mutAttString.string);
        return mutAttString;
    }
    NSLog(@"grass_immer_返回无截断文案: %@", [self adAttributedText]);
    // 无截断赋值文案
    return [self adAttributedText];
}


@end
