//
//  SampleViewController.m
//  GrassIosSamples
//
//  Created by grass on 2020/11/10.
//

#import "SampleViewController.h"

@interface SampleViewController ()
@end

@implementation SampleViewController

- (instancetype)initWithTitle:(NSString *)title{
    self.topTitle = title;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"the title is %@",self.topTitle);
    self.title = self.topTitle;
}

@end
