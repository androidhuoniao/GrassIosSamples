//
//  SampleListViewController.m
//  GrassIosSamples
//
//  Created by grass on 2020/11/10.
//

#import "SampleListViewController.h"
#import "ButtonViewController.h"
#import "ImageUIViewController.h"
#import "SampleInfo.h"
#import "CustomViewViewController.h"
#import "GetIDFAViewController.h"
#import "NSUserDefaultsViewController.h"
#import "HelloJsonViewController.h"
#import "MockTVViewController.h"
#import "SWGcdViewController.h"
#import "SWAlertViewController.h"


@interface SampleListViewController () <UITableViewDataSource,UITableViewDelegate>
@property(nonnull,nonatomic,strong) UITableView *myTableView;
@property(nonatomic,strong) NSArray<SampleInfo *> *sampleList;
@end

@implementation SampleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"SampleListViewController.viewDidLoad is working");
    // Do any additional setup after loading the view.
//    [self.view addSubview:[self myTableView]];
    [self.view addSubview:self.myTableView];
}
- (NSArray *)sampleList{
    if(_sampleList == nil){
        _sampleList = @[
            [SampleInfo initWithName:@"UILable" andVCFactory:^UIViewController *{
                return [ButtonViewController new];
            } ],
            [SampleInfo initWithName:@"UIImageView" andVCFactory:^UIViewController *{
                return [[ImageUIViewController alloc] initWithTitle:@"UIImageViewDemo"];
            }],
            [SampleInfo initWithName:@"UIButton" andVCFactory:^UIViewController *{
                return [ButtonViewController new];
            }],
            [SampleInfo initWithName:@"UITableView" andVCFactory:^UIViewController *{
                return [ButtonViewController new];
            }],
            [SampleInfo initWithName:@"自定义view"andVCFactory:^UIViewController *{
                return [CustomViewViewController new];
            }],
            [SampleInfo initWithName:@"获取idfa" andVCFactory:^UIViewController *{
                return [GetIDFAViewController new];
            }],
            [SampleInfo initWithName:@"NSUserDefaults" andVCFactory:^UIViewController *{
                return [[NSUserDefaultsViewController alloc] initWithTitle:@"HelloNSUserDefaults"];
            }],
            [SampleInfo initWithName:@"NSJSONSerialization" andVCFactory:^UIViewController *{
                return [[HelloJsonViewController alloc] initWithTitle:@"HelloJson"];
            }],
            [SampleInfo initWithName:@"NSNotification" andVCFactory:^UIViewController *{
                return [[HelloJsonViewController alloc] initWithTitle:@"HelloNSNotification"];
            }],
            [SampleInfo initWithName:@"MockTV" andVCFactory:^UIViewController *{
                return [[MockTVViewController alloc] initWithTitle:@"MockTV"];
            }],
            [SampleInfo initWithName:@"GCD" andVCFactory:^UIViewController *{
                return [[SWGcdViewController alloc] initWithTitle:@"CCD"];
            }],
            [SampleInfo initWithName:@"Alert" andVCFactory:^UIViewController *{
                return [[SWAlertViewController alloc] initWithTitle:@"Alert"];
            }]
        ];
    }
    return _sampleList;
}

- (UITableView *)myTableView {
//    NSLog(@"myTabView create is working1: %@",_myTableView);
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _myTableView.backgroundColor = UIColor.blueColor;
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        NSLog(@"myTabView create is working");
    }
    return _myTableView;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellid = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.textLabel.text = [_sampleList objectAtIndex:indexPath.row].name;
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"count is %li",self.sampleList.count);
    return self.sampleList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    SampleInfo *info = [_sampleList objectAtIndex:indexPath.row];
    UIViewController *vc = [info getSampleVC];

    [self.navigationController pushViewController:vc animated:false];
}
@end