//
//  SWTimeViewController.m
//  GrassIosSamples
//
//  Created by grassswwang on 2023/1/31.
//  Copyright © 2023 Tencent. All rights reserved.
//

#import "SWTimeViewController.h"

@interface SWTimeViewController ()
@property (nonatomic, assign) CFTimeInterval lastTime;
@property (nonatomic, assign) CFAbsoluteTime lastAbsoluteTime;
@end

@implementation SWTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
//
//    CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
//    NSLog(@"grass_profile_cost startTime:%f %f ms", startTime, linkTime *1000.0);
//    CFTimeInterval mediaTime = CACurrentMediaTime();
//    NSLog(@"grass_profile_cost mediaTime:%f", mediaTime);
}

- (void)viewWillAppear:(BOOL)animated {
    self.lastTime = CACurrentMediaTime();
    self.lastAbsoluteTime = CFAbsoluteTimeGetCurrent();
}

- (void)viewWillDisappear:(BOOL)animated {
    CFTimeInterval mediaTime = CACurrentMediaTime();
    NSLog(@"grass_profile_cost mediaTime:%f cost:%f", mediaTime, mediaTime - self.lastTime);
    CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - self.lastAbsoluteTime);
    NSLog(@"grass_profile_cost  linkTime:%f ms", linkTime *1000.0);
}

@end
