//
//  MockTVViewController.m
//  GrassIosSamples
//
//  Created by grass on 2020/11/22.
//

#import "MockTVViewController.h"
#import "QLAppLaunchTaskList_MainSync1.h"
#import "QLAppLaunchTaskList_MainSync2.h"

@interface MockTVViewController ()
@property(nonnull,nonatomic,strong) UIButton *getMainSync1Btn;
@property(nonnull,nonatomic,strong) UIButton *getMainSync2Btn;
@end

@implementation MockTVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = self.view.bounds.size.width;
    _getMainSync1Btn = [[UIButton alloc]init];
    _getMainSync1Btn.backgroundColor = UIColor.blueColor;
    _getMainSync1Btn.frame = CGRectMake(0, 100, width, 100);
    [_getMainSync1Btn setTitle:@"MainSync1" forState:UIControlStateNormal];
    [_getMainSync1Btn addTarget:self action:@selector(onGetMainSync1BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getMainSync1Btn];
    
    
    _getMainSync2Btn = [[UIButton alloc]init];
    _getMainSync2Btn.backgroundColor = UIColor.blueColor;
    CGFloat bottomSaveBtn = [self getBottomY:_getMainSync1Btn];
    _getMainSync2Btn.frame = CGRectMake(0, bottomSaveBtn+20, width, 100);
    [_getMainSync2Btn setTitle:@"MainSync2" forState:UIControlStateNormal];
    [_getMainSync2Btn addTarget:self action:@selector(onGetMainSync2BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getMainSync2Btn];
    
}

-(void) onGetMainSync1BtnClick:(UIButton *) button{
   
    QLAppLaunchTaskList *mainSync1TaskList = [QLAppLaunchTaskList appLaunchTaskListWithType:MAIN_SYNC1];
    NSLog(@"onGetMainSync1BtnClick is working %@",mainSync1TaskList);
    [mainSync1TaskList runTasks];
    
}

-(void) onGetMainSync2BtnClick:(UIButton *) button{
    QLAppLaunchTaskList *mainSync2TaskList = [QLAppLaunchTaskList appLaunchTaskListWithType:MAIN_SYNC2];
    NSLog(@"onGetMainSync2BtnClick is working %@",mainSync2TaskList);
    [mainSync2TaskList runTasks];
}

@end
