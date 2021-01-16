//
//  QADLandingPageVRReporter.h
//  VBQADCommonKit
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, QADLandingPageLoadingResult) {
    QADLandingPageLoadingResult_Fail = 0,
    QADLandingPageLoadingResult_Success = 1,
    /// 用户终止
    QADLandingPageLoadingResult_Interupt = 2,
};

typedef NS_ENUM(NSUInteger, QADLandingPageReportStatus) {
    QADLandingPageReportStatus_Start = 0,
    QADLandingPageReportStatus_Finish = 1,
};

@interface QADLandingPageVRReporter : NSObject

- (instancetype)initWithUrl:(NSString *)url pageid:(NSString *)pageid pageView:(UIView *)pageView;

- (void)onPageloadStart;
- (void)onPageloadFinishWithResult:(QADLandingPageLoadingResult)loadResult errorCode:(NSString *)errorCode;
- (void)onPageInterrupted;

@end

NS_ASSUME_NONNULL_END
