//
//  SWPureOCViewController.m
//  GrassIosSamples
//
//  Created by grassswwang(王圣伟) on 2020/11/27.
//

#import "SWPureOCViewController.h"
#import "ButtonViewController.h"
@interface SWPureOCViewController ()

@end

@implementation SWPureOCViewController

- (NSArray<SampleInfo *> *)createSampleList{
   return @[
        [SampleInfo initWithName:@"UILable" andVCFactory:^UIViewController *{
            return [ButtonViewController new];
        }]
   ];
}
@end
