//
//  BaseSampleInfo.h
//  GrassIosSamples
//
//  Created by grass on 2020/11/10.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseSampleInfo : NSObject
@property(nonnull,nonatomic,strong) NSString *name;
@property(nonnull,nonatomic,strong) NSString *desc;
@property(nonnull,nonatomic,strong) UIViewController *controller;
-(UIViewController *) getSampleVC;
@end

NS_ASSUME_NONNULL_END
