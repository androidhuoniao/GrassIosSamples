//
//  SampleInfo.h
//  GrassIosSamples
//
//  Created by grass on 2020/11/10.
//

#import "BaseSampleInfo.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SampleInfo : BaseSampleInfo
@property(nonatomic,strong) UIViewController* (^vcGenerateBlock)(void);
+ (instancetype) makeInfoWithName:(NSString * )name andDes:(NSString *)desc andVC:(UIViewController *)controller;
+ (instancetype) makeInfoWithName:(NSString * )name andVCBlock:(UIViewController* (^)(void)) block;
@end

NS_ASSUME_NONNULL_END
