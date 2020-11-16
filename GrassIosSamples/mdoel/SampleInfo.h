//
//  SampleInfo.h
//  GrassIosSamples
//
//  Created by grass on 2020/11/10.
//

#import "BaseSampleInfo.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef UIViewController* (^VCFactory)(void);

@interface SampleInfo : BaseSampleInfo
@property(nonatomic,strong) VCFactory vcFactory;

+ (instancetype) initWithName:(NSString * )name andVCFactory:(VCFactory) factory;
@end

NS_ASSUME_NONNULL_END
