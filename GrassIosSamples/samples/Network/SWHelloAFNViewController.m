//
//  SWHelloAFNViewController.m
//  GrassIosSamples
//
//  Created by 王圣伟 on 2021/7/11.
//

#import "SWHelloAFNViewController.h"

@interface SWHelloAFNViewController ()
@property(nonnull,nonatomic,strong) UIButton *getBtn;
@property(nonnull,nonatomic,strong) UIButton *postBtn;
@property(nonnull,nonatomic,strong) UIButton *clearBtn;
@end

@implementation SWHelloAFNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.getBtn = [self buildBtnWithTitle:@"get" clickAction:@selector(onGetBtnClick:)];
    [self.view addSubview:self.getBtn];
   
    self.postBtn = [self buildBtnWithTitle:@"post" clickAction:@selector(onPostBtnClick:)];
    [self.view addSubview:self.postBtn];
    
    CGRect getFrame = self.getBtn.frame;
    getFrame.origin = CGPointMake(0, 100);
    self.getBtn.frame = getFrame;
    
    CGRect postFrame = self.postBtn.frame;
    postFrame.origin = CGPointMake(0, 30 + CGRectGetMaxY(self.getBtn.frame));
    self.postBtn.frame = postFrame;
    
}


-(void)onGetBtnClick:(UIButton *)button {
    NSLog(@"%s",__func__);
   
}

-(void)onPostBtnClick:(UIButton *)button {
    NSLog(@"%s",__func__);
   
}

- (UIButton *)buildBtnWithTitle:(NSString *)title clickAction:(SEL)clickAction {
    CGFloat width = self.view.bounds.size.width;
    UIButton *btn = [[UIButton alloc]init];
    btn.backgroundColor = UIColor.blueColor;
    btn.frame = CGRectMake(0, 0, width, 70);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:clickAction forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

@end
