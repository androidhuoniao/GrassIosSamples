//
//  GetIDFAViewController.m
//  GrassIosSamples
//
//  Created by grassswwang(王圣伟) on 2020/11/16.
//

#import "GetIDFAViewController.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/ASIdentifierManager.h>

@interface GetIDFAViewController ()
-(NSString *) getIdfa;
-(NSString *) getIdfaBeforeIOS14;
-(BOOL) isAdvertisingTrackingEnabled;
@end

@implementation GetIDFAViewController

-(instancetype)init{
    self = [super init];
    NSLog(@"init is working %@",self);
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad is working %@",self);
    UILabel *lable = [[UILabel alloc] init];
    
    lable.frame = CGRectMake(0, 0, self.view.frame.size.width, 300);
    lable.backgroundColor = UIColor.blueColor;
    lable.textColor = UIColor.whiteColor;
    lable.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:lable];
    NSString *lableText = [[NSString alloc] init];
//    lableText = [lableText stringByAppendingString:@"begin-------"];
    lableText = [lableText stringByAppendingFormat:@"\nisAdvertisingTrackingEnabled=%i",[self isAdvertisingTrackingEnabled]];
    lableText = [lableText stringByAppendingFormat:@"\ngetIdfaBeforeIOS14=%@",[self getIdfaBeforeIOS14]];
    lable.numberOfLines = 4;
    
    NSLog(@"lableText is %@",lableText);
    [lable setText:lableText];
    [self getIdfa];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear is working %@",self);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear is working %@",self);
}

- (NSString *)getIdfa{
    NSString __block *idfa = @"";
    if (@available(iOS 14, *)) {
        // iOS14及以上版本需要先请求权限
        NSLog(@"%s is working after ios14",__func__);
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            NSLog(@"ATTrackingManagerAuthorizationStatus:%li",status);
            // 获取到权限后，依然使用老方法获取idfa
            if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
                idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
                NSLog(@"%@",idfa);
            } else {
                NSLog(@"请在设置-隐私-跟踪中允许App请求跟踪");
            }
        }];
    } else {
        // iOS14以下版本依然使用老方法
        // 判断在设置-隐私里用户是否打开了广告跟踪
        if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
            idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
            NSLog(@"%@",idfa);
        } else {
            NSLog(@"请在设置-隐私-广告中打开广告跟踪功能");
        }
    }
    return idfa;
}

- (NSString *)getIdfaBeforeIOS14{
    NSString __block *idfa = @"";
    idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    NSLog(@"%@",idfa);
    return idfa;
}
- (BOOL)isAdvertisingTrackingEnabled{
    BOOL isAdvertising = [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled];
    return isAdvertising;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear is working");
}
- (void)dealloc{
    NSLog(@"deallloc is working");
}

@end
