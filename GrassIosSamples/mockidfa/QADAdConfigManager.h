//
//  QADAdConfigManager.h
//  GrassIosSamples
//
//  Created by grassswwang(王圣伟) on 2020/11/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QADAdConfigManager : NSObject
+ (instancetype)sharedInstance;
-(BOOL) enableIDFAAccessRequest;
-(BOOL) shouldIDFARequestAccessSkipAppAlert;
-(id) getValue:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
