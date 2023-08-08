//
//  SWHorCollectionViewController.m
//  GrassIosSamples
//
//  Created by grassswwang on 2023/8/7.
//  Copyright © 2023 Tencent. All rights reserved.
//

#import "UILabelCollectionViewCell.h"
#import "SWHCollectionViewController.h"
#import "CollectionViewFlowTopLayout.h"
#import "CollectionViewSwipeCenterFlowLayout.h"
#import "CollectionViewPagingAndCenterFlowLayout.h"

@interface SWHCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *dynamicAdButton;
@property (nonatomic, strong) NSMutableArray<NSString *> *data;
@property (nonatomic, assign) NSIndexPath *currentIndexPath;
@property (nonatomic, assign) NSInteger card_height;
@property (nonatomic, assign) NSInteger card_width;

@end

@implementation SWHCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _card_height = 150;
    _card_width = self.view.bounds.size.width - 2 * 16;
    [self.view addSubview:[self collectionView]];
    [self insertButton];
}

- (void)insertButton {
    [self.view insertSubview:self.dynamicAdButton aboveSubview:self.collectionView];
    CGSize contentViewSize = self.view.bounds.size;
    CGSize buttonSize = self.dynamicAdButton.frame.size;
    self.dynamicAdButton.frame = CGRectMake((contentViewSize.width - buttonSize.width) / 2,
                                         contentViewSize.height - buttonSize.height - 300,
                                         buttonSize.width,
                                         buttonSize.height);
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[CollectionViewPagingAndCenterFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        layout.minimumLineSpacing = 8;
        layout.minimumInteritemSpacing = 8;
        layout.sectionInset = UIEdgeInsetsMake(0, 16, 0, 0);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[UILabelCollectionViewCell class] forCellWithReuseIdentifier:@"UILabelCollectionViewCell"];
        CGSize contentViewSize = self.view.bounds.size;
        _collectionView.frame = CGRectMake(0, 30, contentViewSize.width, self.card_height);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
//        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UILabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UILabelCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    self.currentIndexPath = indexPath;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.card_width, self.card_height);
}

- (void)onDynamicAdBtnClick {
    NSString *str = [[NSString alloc] initWithFormat:@"广告_%@", @(CFAbsoluteTimeGetCurrent()).stringValue];
    NSInteger insertPos = self.currentIndexPath.row - 1;
    [self.data insertObject:str atIndex:insertPos];
    NSIndexPath *insertIndexPath = [NSIndexPath indexPathForRow:insertPos inSection:0];
    [self.collectionView insertItemsAtIndexPaths:@[insertIndexPath]];
}

- (void)onDynamicAdBtnClick2 {
    NSString *str = [[NSString alloc] initWithFormat:@"广告_%@", @(CFAbsoluteTimeGetCurrent()).stringValue];
    NSInteger insertPos = self.currentIndexPath.row - 1;
    [self.data insertObject:str atIndex:insertPos];
    NSIndexPath *insertIndexPath = [NSIndexPath indexPathForRow:insertPos inSection:0];
    CGFloat bottomOffset = self.collectionView.contentSize.height - self.collectionView.contentOffset.y;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [self.collectionView performBatchUpdates:^{
        [self.collectionView insertItemsAtIndexPaths:@[insertIndexPath]];
    } completion:^(BOOL finished) {
        self.collectionView.contentOffset = CGPointMake(0, self.collectionView.contentSize.height - bottomOffset);
    }];
    [CATransaction commit];
}

#pragma mark - UICollectionViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint scrollVelocity = [scrollView.panGestureRecognizer velocityInView:scrollView.superview];
    //    if (scrollVelocity.y > 0.0f) {
    //        NSLog(@"going down");
    //    } else if (scrollVelocity.y < 0.0f) {
    //        NSLog(@"going up");
    //    }
//    NSLog(@"scrollViewDidScroll isDragging:%d, isDecelerating:%d, isTracking:%d decelerationRate:%f scrollVelocity:%@",scrollView.isDragging, scrollView.isDecelerating, scrollView.isTracking, scrollView.decelerationRate, NSStringFromCGPoint(scrollVelocity));
    
}

//called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    NSLog(@"scrollViewWillBeginDragging");
}

// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    NSLog(@"scrollViewDidEndDragging");
}

// called on finger up as we are moving
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"scrollViewWillBeginDecelerating");
}

// called when scroll view grinds to a halt
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"scrollViewDidEndDecelerating");
}


#pragma mark - lazy

- (UILabel *)dynamicAdButton {
    if (!_dynamicAdButton) {
        _dynamicAdButton = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        _dynamicAdButton.text = @"dynamicAdd";
        _dynamicAdButton.userInteractionEnabled = YES;
        _dynamicAdButton.backgroundColor = UIColor.blueColor;
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onDynamicAdBtnClick2)];
        [_dynamicAdButton addGestureRecognizer:gr];
    }
    return _dynamicAdButton;
}

- (NSMutableArray<NSString *> *)data {
    if (!_data) {
        _data = [NSMutableArray arrayWithCapacity:10];
        for (NSInteger index = 0; index < 10; index++) {
            NSString *str = [[NSString alloc] initWithFormat:@"content_%ld", index];
            [_data addObject:str];
        }
    }
    return _data;
}

@end
