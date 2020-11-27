//
//  SWBaseSampleListViewController.h
//  GrassIosSamples
//
//  Created by grassswwang(王圣伟) on 2020/11/27.
//

#import <UIKit/UIKit.h>
#import "SampleInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWBaseSampleListViewController : UIViewController
- (NSArray<SampleInfo *> *)createSampleList;
@end

NS_ASSUME_NONNULL_END
