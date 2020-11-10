//
//  ViewController.m
//  GrassIosSamples
//
//  Created by grass on 2020/11/10.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource>

@property(nonnull,nonatomic,strong) UITableView *myTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"viewDidLoad is working");
    // Do any additional setup after loading the view.
//    [self.view addSubview:[self myTableView]];
    [self.view addSubview:self.myTableView];
}

- (UITableView *)myTableView {
    NSLog(@"myTabView create is working1: %@",_myTableView);
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _myTableView.backgroundColor = UIColor.blueColor;
        _myTableView.dataSource = self;
        NSLog(@"myTabView create is working");
    }
    return _myTableView;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellid = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        NSString * text = [NSString stringWithFormat:@"%li",(long)indexPath.row];
        cell.textLabel.text = text;
        NSLog(@"UITableViewCell create is working %@",text);
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


@end
