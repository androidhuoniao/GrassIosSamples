//
//  QADLandingPageVRReporterTest.m
//  GrassIosSamplesTests
//
//  Created by 王圣伟 on 2021/1/16.
//

#import <XCTest/XCTest.h>
#import <OCHamcrest/OCHamcrest.h>
#import <OCMock/OCMock.h>
#import "QADLandingPageVRReporter.h"

@interface QADLandingPageVRReporter (test)
@property(nonatomic,assign) BOOL hasCompleteReport;
- (void)reportVREvent:(NSDictionary *)params;

@end
@interface QADLandingPageVRReporterTest : XCTestCase

@end

@implementation QADLandingPageVRReporterTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

// 验证只能上报一次的逻辑
- (void)test1{
    QADLandingPageVRReporter *reporter = [[QADLandingPageVRReporter alloc] init];
    reporter = OCMPartialMock(reporter);
    [reporter onPageloadStart];
    OCMVerify([reporter reportVREvent:nil]);
    [reporter onPageloadFinishWithResult:QADLandingPageLoadingResult_Success errorCode:[OCMArg any]];
    OCMVerify([reporter reportVREvent:nil]);
    assertThatBool(reporter.hasCompleteReport, isTrue());
}

// 验证只能上报一次的逻辑
- (void)test2{
    QADLandingPageVRReporter *reporter = [[QADLandingPageVRReporter alloc] init];
    reporter = OCMPartialMock(reporter);
    [reporter onPageloadStart];
    OCMVerify([reporter reportVREvent:nil]);
    [reporter onPageInterrupted];
   
    OCMVerify([reporter onPageloadFinishWithResult:QADLandingPageLoadingResult_Interupt errorCode:@""]);
    OCMVerify([reporter reportVREvent:nil]);
    assertThatBool(reporter.hasCompleteReport, isTrue());
    
}



@end
