//
//  ImageUIViewController.m
//  GrassIosSamples
//
//  Created by grass on 2020/11/10.
//

#import "ImageUIViewController.h"

@interface ImageUIViewController ()
@property(nonatomic,strong) UIImageView *subView;
@end

@implementation ImageUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[self subView]];
}

- (UIImageView *)subView{
    if(_subView == nil){
        _subView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100,100)];
        _subView.image = [UIImage imageNamed:@"test"];
    }
    return _subView;
}

@end
