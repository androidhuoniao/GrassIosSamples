//
//  QLReCord.h
//  GrassIosSamples
//
//  Created by grassswwang(王圣伟) on 2020/11/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QLReCord : NSObject
@property (nonatomic, assign, readonly) NSInteger total;

- (void)record;

- (void)addWithIndex:(NSInteger )index;

@end

NS_ASSUME_NONNULL_END
