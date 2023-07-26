//
//  SWTableViewAnimationViewController.m
//  GrassIosSamples
//
//  Created by grassswwang on 2023/7/10.
//  Copyright © 2023 Tencent. All rights reserved.
//

#import "SWTableViewAnimationViewController.h"

@interface SWTableViewAnimationViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonnull, nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray<NSString *> *dataList;
@property (nonatomic, assign) BOOL expandFirstCell;

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
        //        _myTableView.backgroundColor = UIColor.blueColor;
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
    cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@, %p", [self.dataList objectAtIndex:indexPath.row], cell];
    if (indexPath.row == 0) {
        cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, 0, 0);
        cell.backgroundColor = UIColor.greenColor;
    } else {
        cell.backgroundColor = UIColor.orangeColor;
    }
    cell.bounds = CGRectMake(0, 0, self.myTableView.bounds.size.width, 44);
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if (indexPath.row == 0) {
    //        if (self.expandFirstCell) {
    //            return 140;
    //        } else {
    //            return 0;
    //        }
    //    }
    //    return 44;
    return 200;
}


#pragma mark - 动画相关

- (void)startAnimation {
    NSLog(@"startAnimation is working");
    //    UITableViewCell *cell = self.collectionView.visibleCells.firstObject;
    //    [self leftInsertAnimation:cell];
    //    [self.collectionView.visibleCells enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
    //        NSLog(@"idx:%ld cell:%p", idx, cell);
    //        if (idx == 0) {
    ////            [self leftInsertAnimation:cell];
    ////            [self heightAnimation:cell];
    //            [self scaleAnimation:cell];
    //        } else {
    //            [self springAnimation:cell];
    //        }
    //    }];
    //    UITableViewCell *cell = [self orderedVisibleCells:self.myTableView].firstObject;
    //    [self heightAnimation:cell];
    //    [self scaleAnimation:cell];
    //    [self springAnimation:cell];
    //    [self performBatchUpdatesAnimation:cell];
    //        [self reloadRowsWithAnimation:cell];
    //    [self tryExpandFirstCell:cell];
    //    [self boundsAnimation:cell];
    //    [self frameSizeAnimation:cell];
    NSArray<UITableViewCell *> *cellList = [self orderedVisibleCells:self.myTableView];
    [self scaleAnimation:cellList[0]];
    //    for (NSInteger index = 0; index < cellList.count; index++) {
    //        if (index == 0) {
    //            [self heightAnimation:cellList[index]];
    //        } else {
    //            [self centerAnimation:cellList[index]];
    //        }
    //    }
}

- (void)reloadRowsWithAnimation:(UITableViewCell *)cell {
    NSIndexPath *targetIndexPath = [self.myTableView indexPathForCell:cell];
    [self.myTableView reloadRowsAtIndexPaths:@[targetIndexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)tryExpandFirstCell:(UITableViewCell *)cell {
    self.expandFirstCell = YES;
    [self frameSizeAnimation:cell];
    [self.myTableView beginUpdates];
    
    [self.myTableView endUpdates];
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

-(void)springAnimation:(UITableViewCell *)cell {
    cell.transform = CGAffineTransformMakeTranslation(0, -80);
    [UIView animateWithDuration:0.5 animations:^{
        cell.transform = CGAffineTransformIdentity;
    }];
}

-(void)heightAnimation:(UITableViewCell *)cell {
    CGRect frame = cell.frame;
    [UIView animateWithDuration:1 animations:^{
        cell.frame =  CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height * 3);
    }];
}

- (void)centerAnimation:(UITableViewCell *)cell {
    CGRect frame = cell.frame;
    [UIView animateWithDuration:1 animations:^{
        cell.center = CGPointMake(cell.center.x, cell.center.y +  cell.frame.size.height * 2);
    }];
}

- (void)originYAnimation:(UITableViewCell *)cell {
    CGRect frame = cell.frame;
    [UIView animateWithDuration:1 animations:^{
        //        cell.center = CGPointMake(cell.center.x, cell.center.y +  cell.frame.size.height * 2);
        cell.frame = CGRectMake(frame.origin.x, frame.origin.y + 2 *frame.size.height, frame.size.width, frame.size.height);
    }];
}

-(void)frameSizeAnimation:(UITableViewCell *)cell {
    CGRect oriFrame = cell.frame;
    CGRect startFrame = CGRectMake(oriFrame.origin.x, oriFrame.origin.y, 0, 0);
    cell.frame = startFrame;
    [UIView animateWithDuration:0.5 animations:^{
        cell.frame = CGRectMake(oriFrame.origin.x, oriFrame.origin.y, self.myTableView.frame.size.width, 140);
        //        [self.myTableView layoutIfNeeded];
    }];
}

-(void)boundsAnimation:(UITableViewCell *)cell {
    CGRect startBounds = CGRectMake(0, 0, 0, 0);
    cell.bounds = startBounds;
    [UIView animateWithDuration:1 animations:^{
        cell.frame = CGRectMake(0, 0, self.myTableView.frame.size.width, 140);;
    }];
}

-(void)widthAnimation:(UITableViewCell *)cell {
    //    CGRect frame = cell.frame;
    //    CGRect oriFrame = frame;
    //    CGRect startFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 0);
    //    cell.frame = startFrame;
    //    [UIView animateWithDuration:2 animations:^{
    //        cell.frame = oriFrame;
    //    }];
}

- (void)performBatchUpdatesAnimation:(UITableViewCell *)cell {
    [UIView animateWithDuration:0.3 animations:^{
        [self.myTableView performBatchUpdates:^{
        } completion:^(BOOL finished) {
        }];
        
        [self.myTableView layoutIfNeeded];
    }];
}


-(void)scaleAnimation:(UITableViewCell *)cell {
    CABasicAnimation *animationScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animationScale.duration = 1;
    animationScale.repeatCount = 1;
    animationScale.fromValue = @0.0;
    animationScale.toValue = @1.0;
    animationScale.removedOnCompletion = NO;
    //    animationScale.delegate = self;
    CGRect frame = cell.frame;
    /*定点缩放的位置 锚点 如果（0,0）就是从左上角缩放，如果 (1,1)就是从右下角 */
    cell.layer.anchorPoint = CGPointMake(0.0, 0.0);
    cell.layer.position = CGPointMake(0, 0);
//    cell.frame = frame;
    [cell.layer addAnimation:animationScale forKey:@"scale-show-layer"];
}

-(void)scaleAnimation2:(UITableViewCell *)cell {
    cell.layer.anchorPoint = CGPointMake(0, 0);
    // 设置了这行代码之后，就可以了，真是神奇
    cell.layer.position = CGPointMake(0, 0);
    cell.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    [UIView animateWithDuration:1.F animations:^{
//        cell.transform = CGAffineTransformIdentity;
        cell.transform = CGAffineTransformMakeScale(1, 1);
    }];
}
- (NSArray *)orderedVisibleCells:(UITableView *)collectionView {
    NSArray *cells = [collectionView visibleCells];
    return [cells sortedArrayWithOptions:NSSortStable usingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return ((UIView *)obj1).frame.origin.y > ((UIView *)obj2).frame.origin.y;
    }];
}

- (void)translateAnimation {
    
}

@end
