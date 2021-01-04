//
//  SWHelloTouchEventViewController.m
//  GrassIosSamples
//
//  Created by grassswwang(王圣伟) on 2021/1/4.
//

#import "SWHelloTouchEventViewController.h"
#import "UICustomTouchLabel.h"

@interface SWHelloTouchEventViewController ()
@property(nonatomic,strong) UICustomTouchLabel *touchLabel;
@end

@implementation SWHelloTouchEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.touchLabel];
}

- (UICustomTouchLabel *)touchLabel{
    if (!_touchLabel) {
        _touchLabel = [[UICustomTouchLabel alloc] init];
        _touchLabel.frame = CGRectMake(0, 30, self.view.bounds.size.width, 100);
        _touchLabel.backgroundColor = [UIColor redColor];
    }
    return _touchLabel;
    
}

#pragma mark -------------------------- Override Methods
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s",__func__);
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s",__func__);
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s",__func__);
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s",__func__);
    [super touchesCancelled:touches withEvent:event];
}


@end
