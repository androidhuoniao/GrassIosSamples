//
//  QADIdfaManager.h
//  GrassIosSamples
//
//  Created by grassswwang(王圣伟) on 2020/11/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QADIdfaManager : NSObject
/**
 *  尝试申请IDFA权限
 */
+ (void)tryRequestIDFAAccess;
@end

NS_ASSUME_NONNULL_END
