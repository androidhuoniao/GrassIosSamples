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
    lableText = [lableText stringByAppendingFormat:@"\nisAdvertisingTrackingEnabled=%i",[self isAdvertisingTrackingEnabled]];
//    lableText = [lableText stringByAppendingFormat:@"\ngetIdfaBeforeIOS14=%@",[self getIdfaBeforeIOS14]];
    lableText = [lableText stringByAppendingFormat:@"\ntrackingAuthorizationStatus: %@",[self convertTrackingStatusToString:ATTrackingManager.trackingAuthorizationStatus]];
    lable.numberOfLines = 6;
    
    NSLog(@"lableText is %@",lableText);
    [lable setText:lableText];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 400, self.view.frame.size.width, 80)];
    button.backgroundColor = UIColor.orangeColor;
    [button setTitle:@"getIDFA" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClickGetIDFAAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

-(void) onClickGetIDFAAction:(UIButton *) button{
    NSLog(@"onClickAction is working");
    [self getIdfaAfaterIOS14];
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
        NSLog(@"%s is working after ios14----1",__func__);
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            NSLog(@"ATTrackingManagerAuthorizationStatus:%@",[self convertTrackingStatusToString:status]);
            // 获取到权限后，依然使用老方法获取idfa
            if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
                idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
                NSLog(@"%@",idfa);
            } else {
                NSLog(@"请在设置-隐私-跟踪中允许App请求跟踪");
            }
        }];
        NSLog(@"%s is working after ios14----2",__func__);
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
    NSLog(@"%s is working after ios14----3",__func__);
    return idfa;
}

- (NSString *)getIdfaAfaterIOS14{
    NSString __block *idfa = @"";
    NSLog(@"currentStatus: %@",[self convertTrackingStatusToString:[ATTrackingManager trackingAuthorizationStatus]]);
    [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            switch (status) {
                case ATTrackingManagerAuthorizationStatusDenied:
                    NSLog(@"用户拒绝");
                    break;
                case ATTrackingManagerAuthorizationStatusAuthorized:
                    NSLog(@"用户允许");
                    idfa = [ASIdentifierManager.sharedManager advertisingIdentifier].UUIDString;
                    break;
                case ATTrackingManagerAuthorizationStatusNotDetermined:
                    NSLog(@"用户未做选择或未弹窗");
                    break;
                default:
                    break;
            }
        }];
    return idfa;
}

- (NSString *)convertTrackingStatusToString:(ATTrackingManagerAuthorizationStatus) status{
    NSString *result;
    switch (status) {
        case ATTrackingManagerAuthorizationStatusDenied:
            result= @"StatusDenied";
            break;
        case ATTrackingManagerAuthorizationStatusAuthorized:
            result= @"StatusAuthorized";
            break;
        case ATTrackingManagerAuthorizationStatusNotDetermined:
            result= @"StatusNotDetermined";
            break;
        case ATTrackingManagerAuthorizationStatusRestricted:
            result= @"StatusRestricted";
            break;
        default:
            break;
    }
    return result;
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
