//
//  QADAdConfigManager.m
//  GrassIosSamples
//
//  Created by grassswwang(王圣伟) on 2020/11/23.
//

#import "QADAdConfigManager.h"
@interface QADAdConfigManager()
@property (nonatomic, strong) NSDictionary<NSString *, id> *jsonObject;
@end

@implementation QADAdConfigManager

+ (instancetype)sharedInstance {
    static QADAdConfigManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (BOOL)enableIDFAAccessRequest{
    
    return YES;
    
}

- (BOOL)shouldIDFARequestAccessSkipAppAlert{
    return YES;
}

- (id)getValue:(NSString *)key{
    return [_jsonObject valueForKey:key];
}
@end
