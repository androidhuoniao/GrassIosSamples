//
//  SampleInfo.m
//  GrassIosSamples
//
//  Created by grass on 2020/11/10.
//

#import "SampleInfo.h"

@implementation SampleInfo

+ (instancetype)initWithName:(NSString *)name andVCFactory:(VCFactory)factory{
    SampleInfo *info = [SampleInfo new];
    info.name = name;
    info.vcFactory = factory;
    return info;
}

- (UIViewController *)getSampleVC{
    return _vcFactory();
}

@end
