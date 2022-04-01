//
//  SWBaseSampleListViewController.m
//  GrassIosSamples
//
//  Created by grassswwang(王圣伟) on 2020/11/27.
//

#import "SWBaseSampleListViewController.h"
#import "SampleListViewController.h"
#import "ButtonViewController.h"
#import "ImageUIViewController.h"
#import "SampleInfo.h"
#import "CustomViewViewController.h"
#import "GetIDFAViewController.h"
#import "NSUserDefaultsViewController.h"
#import "HelloJsonViewController.h"

@interface SWBaseSampleListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonnull,nonatomic,strong) UITableView *myTableView;
@property(nonatomic,strong) NSArray<SampleInfo *> *sampleList;

@end

@implementation SWBaseSampleListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myTableView];
}
- (NSArray *)sampleList{
    if(_sampleList == nil){
        _sampleList = [self createSampleList];
    }
    return _sampleList;
}
- (NSArray<SampleInfo *> *)createSampleList{
   return @[
        [SampleInfo initWithName:@"sample" andVCFactory:^UIViewController *{
            return [ButtonViewController new];
        } ]
   ];
}

- (UITableView *)myTableView {
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _myTableView.backgroundColor = UIColor.blueColor;
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
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
    return self.sampleList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SampleInfo *info = [_sampleList objectAtIndex:indexPath.row];
    UIViewController *vc = [info getSampleVC];
    [self.navigationController pushViewController:vc animated:false];
}
@end
