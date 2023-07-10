//
//  SWTableViewAnimationViewController.m
//  GrassIosSamples
//
//  Created by grassswwang on 2023/7/10.
//  Copyright © 2023 Tencent. All rights reserved.
//

#import "SWTableViewAnimationViewController.h"

@interface SWTableViewAnimationViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonnull,nonatomic,strong) UITableView *myTableView;
@property(nonatomic,strong) NSArray<NSString *> *dataList;

@end

@implementation SWTableViewAnimationViewController

- (void)viewDidLoad {
    UIBarButtonItem *startAni = [[UIBarButtonItem alloc] initWithTitle:@"startAnimation" style:UIBarButtonItemStylePlain target:self action:@selector(startAnimation)];
    self.navigationItem.rightBarButtonItems = @[startAni];

    [super viewDidLoad];
    [self.view addSubview:self.myTableView];
}

- (NSArray<NSString *> *)dataList{
    if(!_dataList){
        NSMutableArray<NSString *> *mList = [[NSMutableArray alloc] initWithCapacity:10];
        for (NSInteger index = 0; index < 10; index++) {
            [mList addObject:@(index).stringValue];
        }
        _dataList = [mList copy];
    }
    return _dataList;
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
    }
    cell.textLabel.text = [self.dataList objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - 动画相关

- (void)startAnimation {
    NSLog(@"startAnimation is working");
//    UICollectionViewCell *cell = self.collectionView.visibleCells.firstObject;
//    [self leftInsertAnimation:cell];
//    [self.collectionView.visibleCells enumerateObjectsUsingBlock:^(__kindof UICollectionViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"idx:%ld cell:%p", idx, cell);
//        if (idx == 0) {
////            [self leftInsertAnimation:cell];
////            [self heightAnimation:cell];
//            [self scaleAnimation:cell];
//        } else {
//            [self springAnimation:cell];
//        }
//    }];
    UICollectionViewCell *cell = [self orderedVisibleCells:self.myTableView].firstObject;
//    [self scaleAnimation:cell];
//    [self springAnimation:cell];
    [self performBatchUpdatesAnimation:cell];
}

-(void)leftInsertAnimation:(UITableViewCell *)cell {
    CGPoint center = cell.center;
    CGPoint orgCenter = center;
    center.x += cell.bounds.size.width;
    cell.center = center;
    [UIView animateWithDuration:0.5 animations:^{
        cell.center = orgCenter;
    }];
}

-(void)springAnimation:(UICollectionViewCell *)cell {
    cell.transform = CGAffineTransformMakeTranslation(0, -80);
    [UIView animateWithDuration:0.5 animations:^{
        cell.transform = CGAffineTransformIdentity;
    }];
}

-(void)heightAnimation:(UICollectionViewCell *)cell {
//    QFSFeedListBaseViewCell *viewCell = (QFSFeedListBaseViewCell *)cell;
//    UIView *adView = viewCell.feedAdView;
//    CGRect frame = adView.frame;
//    CGRect oriFrame = frame;
//    CGRect startFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 0);
//    adView.frame = startFrame;
//    [UIView animateWithDuration:2 animations:^{
//        adView.frame = oriFrame;
//    }];
}

- (void)performBatchUpdatesAnimation:(UICollectionViewCell *)cell {
    [UIView animateWithDuration:0.3 animations:^{
       [self.myTableView performBatchUpdates:^{
        } completion:^(BOOL finished) {
        }];
     
        [self.myTableView layoutIfNeeded];
//        [self.collectionView reloadData];
    }];
}

-(void)scaleAnimation:(UICollectionViewCell *)cell {
    cell.transform = CGAffineTransformMakeScale(0.0, 0.0);
    [UIView animateWithDuration:0.5 animations:^{
        cell.transform = CGAffineTransformIdentity;
    }];
}

- (NSArray *)orderedVisibleCells:(UITableView *)collectionView {
    NSArray *cells = [collectionView visibleCells];
    return [cells sortedArrayWithOptions:NSSortStable usingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return ((UIView *)obj1).frame.origin.y > ((UIView *)obj2).frame.origin.y;
    }];
}


@end
