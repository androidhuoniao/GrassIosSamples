//
//  SWCollectionViewController2.m
//  GrassIosSamples
//
//  Created by grassswwang on 2022/8/14.
//

#import "SWCollectionViewController2.h"
#import "UILabelCollectionViewCell.h"

@interface SWCollectionViewController2 () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *dynamicAdBtn;
@property (nonatomic, strong) NSMutableArray<NSString *> *data;
@property (nonatomic, assign) NSIndexPath *currentIndexPath;

@end

@implementation SWCollectionViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[self collectionView]];
    //    [self.view addSubview:self.dynamicAdBtn];
    [self.view insertSubview:self.dynamicAdBtn aboveSubview:self.collectionView];
    CGSize contentViewSize = self.view.bounds.size;
    CGSize dynamicAdBtnSize = self.dynamicAdBtn.frame.size;
    self.dynamicAdBtn.frame = CGRectMake((contentViewSize.width - dynamicAdBtnSize.width) / 2,
                                         contentViewSize.height - dynamicAdBtnSize.height - 300,
                                         dynamicAdBtnSize.width,
                                         dynamicAdBtnSize.height);
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_collectionView registerClass:[UILabelCollectionViewCell class] forCellWithReuseIdentifier:@"UILabelCollectionViewCell"];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
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
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
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

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView;                                               // any offset changes
//- (void)scrollViewDidZoom:(UIScrollView *)scrollView API_AVAILABLE(ios(3.2)); // any zoom scale changes
//
//// called on start of dragging (may require some time and or distance to move)
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
//// called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset API_AVAILABLE(ios(5.0));
//// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
//
//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;   // called on finger up as we are moving
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;      // called when scroll view grinds to a halt
//
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView; // called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
//
//- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView;     // return a view that will be scaled. if delegate returns nil, nothing happens
//- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view API_AVAILABLE(ios(3.2)); // called before the scroll view begins zooming its content
//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale; // scale between minimum and maximum. called after any 'bounce' animations
//
//- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView;   // return a yes if you want to scroll to the top. if not defined, assumes YES
//- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView;      // called when scrolling animation finished. may be called immediately if already at top
//
///* Also see -[UIScrollView adjustedContentInsetDidChange]
// */
//- (void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView API_AVAILABLE(ios(11.0), tvos(11.0));

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint scrollVelocity = [scrollView.panGestureRecognizer velocityInView:scrollView.superview];
//    if (scrollVelocity.y > 0.0f) {
//        NSLog(@"going down");
//    } else if (scrollVelocity.y < 0.0f) {
//        NSLog(@"going up");
//    }
    NSLog(@"scrollViewDidScroll isDragging:%d, isDecelerating:%d, isTracking:%d decelerationRate:%f scrollVelocity:%@",scrollView.isDragging, scrollView.isDecelerating, scrollView.isTracking, scrollView.decelerationRate, NSStringFromCGPoint(scrollVelocity));
    
}

//called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"scrollViewWillBeginDragging");
}

// called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSLog(@"scrollViewWillEndDragging velocity:%@ y:%f", NSStringFromCGPoint(velocity), targetContentOffset ->y);
}

// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"scrollViewDidEndDragging");
}

// called on finger up as we are moving
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewWillBeginDecelerating");
}

// called when scroll view grinds to a halt
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating");
}


#pragma mark - lazy

- (UILabel *)dynamicAdBtn {
    if (!_dynamicAdBtn) {
        _dynamicAdBtn = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        _dynamicAdBtn.text = @"dynamicAdd";
        _dynamicAdBtn.userInteractionEnabled = YES;
        _dynamicAdBtn.backgroundColor = UIColor.blueColor;
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onDynamicAdBtnClick2)];
        [_dynamicAdBtn addGestureRecognizer:gr];
    }
    return _dynamicAdBtn;
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
