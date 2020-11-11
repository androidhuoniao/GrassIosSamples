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

@property (nonatomic, weak) UILabel *bookTitle;

@property (nonatomic, weak) UIImageView *mediaIcon;

-(void) makeMeidaIconCircle;
-(void) makeMeidaIconCircle:(UIImageView *) imageview;
@end

@implementation CustomView
- (instancetype)initWithFrame:(CGRect)frame{
    NSLog(@"%s %@",__func__,NSStringFromCGRect(frame));
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"%s add icon and lable， frame is %@",__func__,NSStringFromCGRect(frame));
        // 1. 创建书图标
        UIImageView *icon = [UIImageView new];
        //        icon.contentMode = UIViewContentModeCenter;
        self.icon = icon;
        self.icon.image = [UIImage imageNamed:@"test"];
        [self addSubview:self.icon];
        
        // 2.书名
        UILabel *bookName = [UILabel new];
        bookName.textAlignment = NSTextAlignmentCenter;
        self.label = bookName;
        self.label.text = @"西游记";
        [self addSubview:self.label];
        
        // 3.卡片标题
        UILabel *bookTile = [UILabel new];
        bookTile.textAlignment = NSTextAlignmentCenter;
        bookTile.text = @"如果你喜欢这本书，就收藏吧";
        bookTile.backgroundColor = UIColor.blueColor;
        bookTile.textColor = UIColor.whiteColor;
        self.bookTitle = bookTile;
        [self addSubview:self.bookTitle];
        
        // 4. 创建作者icon
        UIImageView *mediaIcon = [UIImageView new];
        self.mediaIcon = mediaIcon;
        self.mediaIcon.image = [UIImage imageNamed:@"mediaicon"];
        //        self.mediaIcon.layer.cornerRadius = mediaIcon.frame.size.width / 2;
        //        //将多余的部分切掉
        //        self.mediaIcon.layer.masksToBounds = YES;
        
        
        [self addSubview:self.mediaIcon];
        
    }
    return self;
}

- (void)layoutSubviews{
    CGSize size = self.frame.size;
    NSLog(@"%s self.frame is :%@ ",__func__,NSStringFromCGRect(self.frame));
    self.icon.frame = CGRectMake(0, 0, size.width , size.height * 0.7);
    self.bookTitle.frame = CGRectMake(0, 0, size.width , size.height * 0.7);
    self.label.frame = CGRectMake(0, size.height * 0.7, size.width, size.height *(1 - 0.7));
    CGFloat height = size.height *(1 - 0.7);
    self.mediaIcon.frame = CGRectMake(0, size.height * 0.7, height , height);
//    [self makeMeidaIconCircle];
    [self makeMeidaIconCircle: self.mediaIcon];
}

- (void)makeMeidaIconCircle{
    //开始对imageView进行画图
    UIGraphicsBeginImageContextWithOptions(self.mediaIcon.bounds.size, NO, 1.0);
    //使用贝塞尔曲线画出一个圆形图
    [[UIBezierPath bezierPathWithRoundedRect:self.mediaIcon.bounds cornerRadius:self.mediaIcon.frame.size.width] addClip];
    [self.mediaIcon drawRect:self.mediaIcon.bounds];
    self.mediaIcon.image = UIGraphicsGetImageFromCurrentImageContext();
    //结束画图
    UIGraphicsEndImageContext();
}

/**
 这种方式最好用
 */
- (void)makeMeidaIconCircle:(UIImageView *)imageView{
    if(imageView){
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(25, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = imageView.bounds;
        maskLayer.path = maskPath.CGPath;
        imageView.layer.mask = maskLayer;
    }
}
@end
