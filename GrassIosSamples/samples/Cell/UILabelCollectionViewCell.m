//
//  UILabelCollectionViewCell.m
//  GrassIosSamples
//
//  Created by grassswwang on 2022/8/14.
//

#import "UILabelCollectionViewCell.h"

@implementation UILabelCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.textLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize contentViewSize = self.contentView.bounds.size;
    self.textLabel.frame = CGRectMake(0,
                                       contentViewSize.height / 2,
                                       contentViewSize.width,
                                       100);
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        _textLabel.text = @"1111111";
        _textLabel.backgroundColor = UIColor.blueColor;
    }
    return _textLabel;
}

@end
