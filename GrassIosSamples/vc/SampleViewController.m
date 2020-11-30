//
//  SampleViewController.m
//  GrassIosSamples
//
//  Created by grass on 2020/11/10.
//

#import "SampleViewController.h"

@interface SampleViewController ()
@end

@implementation SampleViewController

- (instancetype)initWithTitle:(NSString *)title{
    self.topTitle = title;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"the title is %@",self.topTitle);
    self.title = self.topTitle;
}

-(UIButton *) makeButton:(NSString *) title andTop:(NSInteger) top{
    CGFloat width = self.view.bounds.size.width;
    UIButton *btn = [[UIButton alloc]init];
    btn.backgroundColor = UIColor.blueColor;
    btn.frame = CGRectMake(0, top, width, 100);
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}

- (CGFloat) getBottomY:(UIView *) view{
    CGFloat bottomY = view.frame.origin.y + view.frame.size.height;
    return bottomY;
}

@end
