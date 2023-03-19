//
//  UIImage+Swizzle.m
//  GrassIosSamples
//
//  Created by grassswwang on 2022/8/29.
//  Copyright © 2022 Tencent. All rights reserved.
//

#import "UIImage+Swizzle.h"
#import <objc/message.h>

@implementation UIImage (Swizzle)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceSel:@selector(init) withNewSel:@selector(qq_init)];
        [self swizzleClassSel:@selector(imageNamed:) withNewSel:@selector(qq_imageNamed:)];
    });
}

+ (void)swizzleInstanceSel:(SEL)oldSel withNewSel:(SEL)newSel {
    Class class = self.class;
    Method oldM = class_getInstanceMethod(class, oldSel);
    Method newM = class_getInstanceMethod(class, newSel);
    BOOL didAdd = class_addMethod(class, oldSel, method_getImplementation(newM), method_getTypeEncoding(newM));
    if (didAdd) {
        NSLog(@"swizzleInstanceSel * didAdd");
        class_replaceMethod(class, newSel, method_getImplementation(oldM), method_getTypeEncoding(oldM));
    } else {
        NSLog(@"swizzleInstanceSel * didn'tAdd ----> exchange!");
        method_exchangeImplementations(oldM, newM);
    }
}

+ (void)swizzleClassSel:(SEL)oldSel withNewSel:(SEL)newSel {
    Class class = objc_getMetaClass(object_getClassName(self));
    Method oldM = class_getClassMethod(class, oldSel);
    Method newM = class_getClassMethod(class, newSel);
    BOOL didAdd = class_addMethod(class, oldSel, method_getImplementation(newM), method_getTypeEncoding(newM));
    if (didAdd) {
        NSLog(@"swizzleInstanceSel * didAdd");
        class_replaceMethod(class, newSel, method_getImplementation(oldM), method_getTypeEncoding(oldM));
    }
    else {
        NSLog(@"swizzleInstanceSel * didn'tAdd ----> exchange!");
        method_exchangeImplementations(oldM, newM);
    }
}

- (instancetype)qq_init {
    NSLog(@"自定义的qq_init方法 - %s", __func__);
    return [self qq_init];
}

+ (UIImage *)qq_imageNamed:(NSString *)name {
    NSLog(@"自定义的imageNamed方法 - %s", __func__);
    return [self qq_imageNamed:name];
}

@end
