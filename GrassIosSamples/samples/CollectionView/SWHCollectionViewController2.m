//
//  SWHCollectionViewController2.m
//  GrassIosSamples
//
//  Created by grassswwang on 2023/8/8.
//  Copyright © 2023 Tencent. All rights reserved.
//

#import <Masonry/Masonry.h>
#import "SWHCollectionViewController2.h"
#import "UILabelCollectionViewCell.h"

@interface SWHCollectionViewController2 () <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) CGFloat myOffsetX; // 滑动时的偏移量

@end

@implementation SWHCollectionViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)setupUI {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = NO; /// 禁止分页滑动时，根据偏移量判断滑动到第几个item
    collectionView.scrollEnabled = YES; /// 禁止滑动
    collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.mas_left).offset([UIScreen mainScreen].bounds.size.width/375*20);
//        make.right.top.bottom.equalTo(self);
        make.edges.equalTo(self.view);
    }];
    [collectionView registerClass:[UILabelCollectionViewCell class] forCellWithReuseIdentifier:@"UILabelCollectionViewCell"];
    self.collectionView = collectionView;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
//    [self addLeftAndRightTouchGesture];
}

- (void)refreshHomeNewWordStudyCollectionView {
    [self.collectionView reloadData];
}

#pragma mark -- <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    // item 大小
    return CGSizeMake([UIScreen mainScreen].bounds.size.width/375*335, [UIScreen mainScreen].bounds.size.width/375*525);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    // 行间距（上下）
//    return 40;
    return [UIScreen mainScreen].bounds.size.width/375*10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    // 列间距（左右）
    return [UIScreen mainScreen].bounds.size.width/375*1;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake([UIScreen mainScreen].bounds.size.width/375*5, [UIScreen mainScreen].bounds.size.width/375*20, [UIScreen mainScreen].bounds.size.width/375*5, [UIScreen mainScreen].bounds.size.width/375*20);
    
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UILabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UILabelCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    N2_homeHeaderWordBookStudiedCell *cell = (N2_homeHeaderWordBookStudiedCell *)[collectionView cellForItemAtIndexPath:indexPath];
}

#pragma mark -- -- 以下四个方法，就是实现UICollectionView根据偏移量offset滑动，实现（pagingEnabled）效果的方法

/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    NSLog(@"开始滑动 scrollView.contentOffset.x = %.2f ", scrollView.contentOffset.x);

     // 整个引导页先弄一个UIViewController，在VC中添加其他需要的东西，比如一个UICollectionView、“跳过”按钮，和翻页控件UIpageControl
    // 可以设置刚开始进入APP时的引导图，可以使用UICollectionView，再在上面添加“跳过”按钮
    // 原理：当scrollView.contentOffset.x < 0时，禁止向右滑动，同理，滑到最后一个item，也设置禁止在向左滑动
    if (scrollView.contentOffset.x < 0) {
        self.collectionView.scrollEnabled = NO;
    } else {
        self.collectionView.scrollEnabled = YES;
    }
    
}
**/

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 停止滑动时，当前的偏移量（即最近停止的位置）
    self.myOffsetX = scrollView.contentOffset.x;
    NSLog(@"scrollView.contentOffset.x = %.2f", self.myOffsetX);
    
}

/// collectionView.pagingEnabled = NO; /// 禁止分页滑动时，根据偏移量判断滑动到第几个item
/// 滑动 “减速滚动时” 是触发的代理，当用户用力滑动或者清扫时触发
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {

    // 为了简化代码用了一个手势从滑动方向判断，所以用到了绝对值比对判断 左右滑动的值。
    // fabs ：处理double类型的取绝对值
    if (fabs(scrollView.contentOffset.x - self.myOffsetX) > 10) {
        [self scrollToNextPageOrLastPage:scrollView];
    }
}

/// 用户拖拽时 调用
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if (fabs(scrollView.contentOffset.x - self.myOffsetX) > 10) {
        [self scrollToNextPageOrLastPage:scrollView];
    }
    
}

- (void)scrollToNextPageOrLastPage:(UIScrollView *)scrollView {
    
    /// 之前停止的位置，判断左滑、右滑
    if (scrollView.contentOffset.x > self.myOffsetX) { // i > 0（左滑，下一个（i最大为cell个数））
        
        // 计算移动的item的个数（item.width + 间距）
        NSInteger i = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width/375*(335+10)+1;
        
        NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
        // item居中显示
        [self.collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        NSLog(@"😆index = %ld", i);
        
    }else{  // i <= 0 （右滑，上一个）（i 最小为-1，所以有需要的话，在这里添加判断，使其最小为 i = 0）
        
        NSInteger i = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width/375*(335+10)+1;
        
        NSIndexPath *index = [NSIndexPath indexPathForRow:i-1 inSection:0];
        
        [self.collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        NSLog(@"☺️☺️☺️index = %ld", i-1);
    }
}

@end
