//
//  SampleListViewController.m
//  GrassIosSamples
//
//  Created by grass on 2020/11/10.
//

#import "SampleListViewController.h"

@interface SampleListViewController () <UITableViewDataSource,UITableViewDelegate>
@property(nonnull,nonatomic,strong) UITableView *myTableView;
@property(nonatomic,strong) NSArray *sampleList;
@end

@implementation SampleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"viewDidLoad is working");
    // Do any additional setup after loading the view.
//    [self.view addSubview:[self myTableView]];
    [self.view addSubview:self.myTableView];
}
- (NSArray *)sampleList{
    if(_sampleList == nil){
        _sampleList = @[@"UILable",@"UIImageView",@"UIButton",@"UITableView"];
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
        
        cell.textLabel.text = [_sampleList objectAtIndex:indexPath.row];
        NSLog(@"UITableViewCell create is working %@",[_sampleList objectAtIndex:indexPath.row]);
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sampleList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"提示" message:@"message" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
