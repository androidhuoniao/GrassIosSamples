
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString * const gQADQADTailWithIconTextViewAdTextKey = @"gQADQADTailWithIconTextViewAdTextKey";
static NSString * const gQADQADTailWithIconTextViewAdIconKey = @"gQADQADTailWithIconTextViewAdIconKey";

static CGFloat const QADTailWithIconTextViewAdIconWidth = 38;
static CGFloat const QADTailWithIconTextViewAdIconHeight = 16;


NS_ASSUME_NONNULL_BEGIN

@interface QADTailWithIconTextView : UITextView
/// 获取点击的touch
@property (nonatomic, strong, readonly) UITouch *clickTouch;

@property (nonatomic, copy) NSString *longText;
/// 尾部的icon
@property (nonatomic, strong, readwrite) UIImage *imageIcon;

@end

NS_ASSUME_NONNULL_END
