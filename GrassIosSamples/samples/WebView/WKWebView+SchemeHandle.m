//
//  WKWebView+SchemeHandle.m
//  GrassIosSamples
//
//  Created by grassswwang on 2022/8/28.
//

#import "WKWebView+SchemeHandle.h"

#import <objc/runtime.h>

@implementation WKWebView (SchemeHandle)

+ (void)load {
    NSLog(@"WKWebView load is working");
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod1 = class_getClassMethod(self, @selector(handlesURLScheme:));
        Method swizzledMethod1 = class_getClassMethod(self, @selector(yyhandlesURLScheme:));
        method_exchangeImplementations(originalMethod1, swizzledMethod1);
    });
}
 
+ (BOOL)yyhandlesURLScheme:(NSString *)urlScheme {
    NSLog(@"WKWebView yyhandlesURLScheme urlScheme:%@", urlScheme);
    if ([urlScheme isEqualToString:@"http"] || [urlScheme isEqualToString:@"https"] || [urlScheme isEqualToString:@"file"]) {
        return NO;  //这里让返回NO,应该是默认不走系统断言或者其他判断啥的
    } else {
        return [self handlesURLScheme:urlScheme];
    }
}

@end
