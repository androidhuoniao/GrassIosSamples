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
#import "SWCollectionViewController.h"
#import "SWNSAttributeStringViewController.h"
#import "SWUILableViewController.h"
#import "SWHelloTouchEventViewController.h"
#import "SWUITextViewViewController.h"
#import "SWWKWebViewController.h"
#import "SWUIPageControlViewController.h"
#import "SWUIScrollViewController.h"
#import "HelloFrameAndBoundsViewController.h"
#import "HelloCenterViewController.h"
#import "SWHelloAFNViewController.h"
#import "YZCollectionViewSubViewController.h"

@interface SampleListViewController () <UITableViewDataSource,UITableViewDelegate>
@property(nonnull,nonatomic,strong) UITableView *myTableView;
@property(nonatomic,strong) NSArray<SampleInfo *> *sampleList;
@end

@implementation SampleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myTableView];
}

- (NSArray *)sampleList{
    if(_sampleList == nil){
        _sampleList = @[
            [SampleInfo initWithName:@"UILable" andVCFactory:^UIViewController *{
                return [[SWUILableViewController alloc] initWithTitle:@"UILableDemo"];
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
            }],
            [SampleInfo initWithName:@"CollectionView" andVCFactory:^UIViewController *{
                return [[SWCollectionViewController alloc] initWithTitle:@"CollectionView"];
            }],
            [SampleInfo initWithName:@"NSAttributeString" andVCFactory:^UIViewController *{
                return [[SWNSAttributeStringViewController alloc] initWithTitle:@"NSAttributeString"];
            }],
            [SampleInfo initWithName:@"学习touch事件" andVCFactory:^UIViewController *{
                return [[SWHelloTouchEventViewController alloc] initWithTitle:@"学习touch事件"];
            }],
            [SampleInfo initWithName:@"UITextView" andVCFactory:^UIViewController *{
                return [[SWUITextViewViewController alloc] initWithTitle:@"UITextView"];
            }],
            [SampleInfo initWithName:@"WKWebView" andVCFactory:^UIViewController *{
                return [[SWWKWebViewController alloc] initWithTitle:@"WKWebView"];
            }],
            [SampleInfo initWithName:@"UIPageControl" andVCFactory:^UIViewController *{
                return [[SWUIPageControlViewController alloc] initWithTitle:@"UIPageControl"];
            }],
            [SampleInfo initWithName:@"UIScrollView" andVCFactory:^UIViewController *{
                return [[SWUIScrollViewController alloc] initWithTitle:@"UIScrollView"];
            }],
            [SampleInfo initWithName:@"HelloFrameAndBoundsViewController" andVCFactory:^UIViewController *{
                return [[HelloFrameAndBoundsViewController alloc] init];
            }],
            [SampleInfo initWithName:@"HelloCenterViewController" andVCFactory:^UIViewController *{
                return [[HelloCenterViewController alloc] init];
            }],
            [SampleInfo initWithName:@"SWHelloAFNViewController" andVCFactory:^UIViewController *{
                return [[SWHelloAFNViewController alloc] init];
            }],
            [SampleInfo initWithName:@"YZCollectionViewSubViewController" andVCFactory:^UIViewController *{
                return [[YZCollectionViewSubViewController alloc] init];
            }],
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
//        cell.textLabel.text = [_sampleList objectAtIndex:indexPath.row].name;
    }
    cell.textLabel.text = [_sampleList objectAtIndex:indexPath.row].name;
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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"frame.size= %@ bounds.size=%@",NSStringFromCGRect(self.myTableView.frame), NSStringFromCGRect(self.myTableView.bounds));
}

@end
