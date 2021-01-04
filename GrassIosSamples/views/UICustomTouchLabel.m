//
//  UICustomTouchLabel.m
//  GrassIosSamples
//
//  Created by grassswwang(王圣伟) on 2021/1/4.
//

#import "UICustomTouchLabel.h"

@implementation UICustomTouchLabel

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

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    return [super pointInside:point withEvent:event];
}

@end
