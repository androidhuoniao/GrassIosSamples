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

@interface SampleListViewController () <UITableViewDataSource,UITableViewDelegate>
@property(nonnull,nonatomic,strong) UITableView *myTableView;
@property(nonatomic,strong) NSArray<SampleInfo *> *sampleList;
@end

@implementation SampleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"SampleListViewController.viewDidLoad is working");
    // Do any additional setup after loading the view.
//    [self.view addSubview:[self myTableView]];
    [self.view addSubview:self.myTableView];
}
- (NSArray *)sampleList{
    if(_sampleList == nil){
        _sampleList = @[
            [SampleInfo makeInfoWithName:@"UILable" andDes:@"" andVC:[ButtonViewController new] ],
            [SampleInfo makeInfoWithName:@"UIImageView" andDes:@"" andVC:[[ImageUIViewController alloc] initWithTitle:@"UIImageViewDemo"]],
            [SampleInfo makeInfoWithName:@"UIButton" andDes:@"" andVC:[ButtonViewController new]],
            [SampleInfo makeInfoWithName:@"UITableView" andDes:@"" andVC:[ButtonViewController new]],
            [SampleInfo makeInfoWithName:@"自定义view" andVCBlock:^UIViewController * _Nonnull{
                return [CustomViewViewController new];
            }],
            [SampleInfo makeInfoWithName:@"获取idfa" andVCBlock: ^(void){
                return [GetIDFAViewController new];
            }]
        ];
    }
    return _sampleList;
}

- (UITableView *)myTableView {
    NSLog(@"myTabView create is working1: %@",_myTableView);
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
//        NSString * text = [NSString stringWithFormat:@"%li",_sampleList];
        
        cell.textLabel.text = [_sampleList objectAtIndex:indexPath.row].name;
        NSLog(@"UITableViewCell create is working %@",[self.sampleList objectAtIndex:indexPath.row]);
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"count is %li",self.sampleList.count);
    return _sampleList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = nil;
    SampleInfo *info = [_sampleList objectAtIndex:indexPath.row];
    if(info.vcGenerateBlock){
        vc =  info.vcGenerateBlock();
    }else {
        vc = [_sampleList objectAtIndex:indexPath.row].controller;
    }
  
    [self.navigationController pushViewController:vc animated:false];
}
@end
