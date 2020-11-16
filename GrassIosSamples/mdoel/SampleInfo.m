//
//  SampleInfo.m
//  GrassIosSamples
//
//  Created by grass on 2020/11/10.
//

#import "SampleInfo.h"

@implementation SampleInfo
+ (instancetype)makeInfoWithName:(NSString *)name andDes:(NSString *)desc andVC:(UIViewController *)controller{
    SampleInfo *info = [SampleInfo new];
    info.name = name;
    info.desc = desc;
    info.controller = controller;
    return info;
}

+ (instancetype)makeInfoWithName:(NSString *)name andVCFactory:(VCFactory)factory{
    SampleInfo *info = [SampleInfo new];
    info.name = name;
    info.vcFactory = factory;
    return info;
}

@end
