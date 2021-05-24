//
//  ButtonViewController.m
//  GrassIosSamples
//
//  Created by grass on 2020/11/10.
//

#import "ButtonViewController.h"

@interface ButtonViewController ()
@property(nonatomic,strong) UIButton *button;
@end

@implementation ButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[self button]];
    NSLog(@"ButtonViewController.viewDidLoad");
}

- (UIButton *)button{
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(50,300, 250,50);
//        _button.frame = CGRectMake(10,100, 250,50);
        _button.backgroundColor = UIColor.redColor;
        [_button setTitle:@"1111" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(onClickAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _button;
}


-(void)onClickAction:(UIButton *) button{
    NSLog(@"onClickAction is working");
}
@end
