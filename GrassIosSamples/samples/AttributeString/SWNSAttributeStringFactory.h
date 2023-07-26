//
//  SWNSAttributeStringFactory.h
//  GrassIosSamples
//
//  Created by grassswwang on 2023/7/25.
//  Copyright © 2023 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static CGFloat const QADInteractiveImmersiveTitleTextViewAdIconWidth = 38;
static CGFloat const QADInteractiveImmersiveTitleTextViewAdIconHeight = 16;

@interface SWNSAttributeStringFactory : NSObject

+ (SWNSAttributeStringFactory *)createFactoryWithLabelText:(NSString *)adLabelText floatSubTitle:(NSString *)floatSubTitle;

/// 广告文案，有广告标签和广告标题和带广告图标
- (NSMutableAttributedString *)adAttributedText;

/// 截断后的文案
- (NSAttributedString *)truncatedText;

@end

NS_ASSUME_NONNULL_END
