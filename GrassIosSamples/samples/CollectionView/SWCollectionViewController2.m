//
//  SWCollectionViewController2.m
//  GrassIosSamples
//
//  Created by grassswwang on 2022/8/14.
//

#import "SWCollectionViewController2.h"
#import "UILabelCollectionViewCell.h"

@interface SWCollectionViewController2 () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

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
