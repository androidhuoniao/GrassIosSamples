//
//  SampleViewController.h
//  GrassIosSamples
//
//  Created by grass on 2020/11/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SampleViewController : UIViewController
@property(nonatomic) NSString *topTitle;
-(instancetype) initWithTitle:(NSString *) title;
@end

NS_ASSUME_NONNULL_END
