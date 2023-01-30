//
//  SWUIStackViewController.m
//  GrassIosSamples
//
//  Created by grassswwang on 2022/11/13.
//

#import <Masonry/Masonry.h>
#import "SWUIStackViewController.h"

@interface SWUIStackViewController ()

@property (nonatomic, strong) UIStackView *contentSV;

@end

@implementation SWUIStackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewDidLoad1];
}

- (void)viewDidLoad1 {
    UIStackView *subStackView1 = [self buildStack1];
    UIStackView *subStackView2 = [self buildStack2];

    [self.view addSubview:self.contentSV];
    [self.contentSV addArrangedSubview:subStackView1];
    [self.contentSV addArrangedSubview:subStackView2];
    
    [self.contentSV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
    }];
    [subStackView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(80);
    }];
    [subStackView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(80);
    }];
}

- (UIStackView *)buildStack1 {
    UIButton *redButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [redButton setTitle:@"红色按钮" forState:UIControlStateNormal];
    redButton.backgroundColor = [UIColor redColor];
    
    
    UIButton *greenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [greenButton setTitle:@"绿色按钮" forState:UIControlStateNormal];
    greenButton.backgroundColor = [UIColor greenColor];
  
    
    UIButton *blueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [blueButton setTitle:@"蓝色按钮" forState:UIControlStateNormal];
    blueButton.backgroundColor = [UIColor blueColor];
    
    UIStackView *stackView = [[UIStackView alloc]initWithArrangedSubviews:@[redButton, greenButton, blueButton]];
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    stackView.backgroundColor = [UIColor yellowColor];
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionFillEqually;
    
    [redButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(70);
    }];
    
    [greenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(60);
    }];

    return stackView;
}

- (UIStackView *)buildStack2 {
    UIButton *redButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [redButton setTitle:@"红色按钮" forState:UIControlStateNormal];
    redButton.backgroundColor = [UIColor redColor];
//    [redButton setContentHuggingPriority:100]
    [redButton setContentHuggingPriority:120 forAxis:UILayoutConstraintAxisHorizontal];
    [redButton setContentCompressionResistancePriority:758 forAxis:(UILayoutConstraintAxisHorizontal)];
    
    
    
    UIButton *greenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [greenButton setTitle:@"绿色按钮" forState:UIControlStateNormal];
    greenButton.backgroundColor = [UIColor greenColor];
  
    
    UIStackView *stackView = [[UIStackView alloc]initWithArrangedSubviews:@[redButton, greenButton]];
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    stackView.backgroundColor = [UIColor yellowColor];
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionFill;

    return stackView;
}

- (UIStackView *)contentSV {
    if(!_contentSV) {
        _contentSV = [[UIStackView alloc] initWithFrame:self.view.bounds];
        _contentSV.translatesAutoresizingMaskIntoConstraints = NO;
        _contentSV.axis = UILayoutConstraintAxisVertical;
        _contentSV.distribution = UIStackViewDistributionEqualSpacing;
        _contentSV.spacing = 20;
        _contentSV.alignment = UIStackViewAlignmentLeading;
        _contentSV.backgroundColor = [UIColor greenColor];
    }
    return _contentSV;
}

@end
