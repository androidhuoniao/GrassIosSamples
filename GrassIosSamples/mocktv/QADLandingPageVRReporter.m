//
//  QADLandingPageVRReporter.m
//  VBQADCommonKit
//

#import "QADLandingPageVRReporter.h"

@interface QADLandingPageVRReporter ()

@property(nonatomic,copy) NSString *url;
@property(nonatomic,copy) NSString *pageid;
@property(nonatomic,weak) UIView *pageView;
@property(nonatomic,assign) BOOL isLoading;
@property(nonatomic,assign) NSInteger startTime;
@property(nonatomic,assign) BOOL hasCompleteReport;

@end
@implementation QADLandingPageVRReporter

- (instancetype)initWithUrl:(NSString *)url pageid:(NSString *)pageid pageView:(UIView *)pageView{
    self = [super init];
    if (self) {
        self.url = url;
        self.pageid = pageid;
        self.pageView = pageView;
        self.hasCompleteReport = NO;
    }
    return self;
}

- (void)onPageloadStart{
    NSLog(@"grass_wk_%s hasCompleteReport:%li",__func__,self.hasCompleteReport);
    if (self.hasCompleteReport) {
        return;
    }
    self.isLoading = YES;
    self.startTime = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970] * 1000;
    [self reportVREvent:nil];

}

- (void)onPageloadFinishWithResult:(QADLandingPageLoadingResult)loadResult errorCode:(NSString *)errorCode{
    NSLog(@"grass_wk_%s hasCompleteReport:%li",__func__,self.hasCompleteReport);
    if (self.hasCompleteReport) {
        return;
    }
    [self reportVREvent:nil];
    self.hasCompleteReport = YES;
}


- (void)onPageInterrupted{
    NSLog(@"grass_wk_%s hasCompleteReport:%li",__func__,self.hasCompleteReport);
    if (self.hasCompleteReport) {
        return;
    }
    [self onPageloadFinishWithResult:QADLandingPageLoadingResult_Interupt errorCode:@""];
}

- (void)reportVREvent:(NSDictionary *)params{
    NSLog(@"%s params:%@",__func__,params);
}

- (void)logImportantValues:(NSDictionary *)vrParams{
    if (!vrParams) {
        return;
    }
    NSMutableDictionary *logDict = [[NSMutableDictionary alloc] init];
  
    NSLog(@"%s params:%@",__func__,logDict);
}

@end
