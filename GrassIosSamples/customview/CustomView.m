//
//  CustomView.m
//  GrassIosSamples
//
//  Created by grassswwang(王圣伟) on 2020/11/11.
//

#import "CustomView.h"

@interface CustomView()
// 两个内部子控件在内部包装起来，不给外界看到
@property (nonatomic, weak) UIImageView *icon;

@property (nonatomic, weak) UILabel *label;

@end

@implementation CustomView
- (instancetype)initWithFrame:(CGRect)frame{
    NSLog(@"%s %@",__func__,NSStringFromCGRect(frame));
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"%s add icon and lable， frame is %@",__func__,NSStringFromCGRect(frame));
        // 1. 创建书图标
        UIImageView *icon = [UIImageView new];
        self.icon = icon;
        self.icon.image = [UIImage imageNamed:@"test"];
        [self addSubview:self.icon];
        
        // 2.书名
        UILabel *bookName = [UILabel new];
        bookName.textAlignment = NSTextAlignmentCenter;
        self.label = bookName;
        self.label.text = @"西游记";
        [self addSubview:self.label];
    }
    return self;
}

- (void)layoutSubviews{
    CGSize size = self.frame.size;
    NSLog(@"%s self.frame is :%@ ",__func__,NSStringFromCGRect(self.frame));
    self.icon.frame = CGRectMake(0, 0, size.width , size.height * 0.7);
    self.label.frame = CGRectMake(0, size.height * 0.7, size.width, size.height *(1 - 0.7));
}

@end
