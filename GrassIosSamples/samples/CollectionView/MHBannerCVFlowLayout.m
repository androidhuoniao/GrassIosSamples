//
//  MHBannerCVFlowLayout.m
//  GrassIosSamples
//
//  Created by grassswwang on 2023/11/5.
//

#import "MHBannerCVFlowLayout.h"

@interface MHBannerCVFlowLayout()

@property (nonatomic, assign) UIEdgeInsets sectionInsets;
@property (nonatomic, assign) CGFloat miniLineSpace;
@property (nonatomic, assign) CGFloat miniInterItemSpace;
@property (nonatomic, assign) CGSize eachItemSize;
/**<记录上次滑动停止时contentOffset值*/
@property (nonatomic, assign) CGPoint lastOffset;

@end

@implementation MHBannerCVFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        _lastOffset = CGPointZero;
        _miniLineSpace = 8.f;
        _miniInterItemSpace = 8.f;
        _eachItemSize = CGSizeMake([self cardWidth], 150);
        _sectionInsets = UIEdgeInsetsMake(0, 16, 0, 0);
    }
    return self;
}

- (CGFloat)cardWidth {
    return self.screenWidth - 2 * 16;
}

- (CGFloat)screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

-(void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;// 水平滚动
    /*设置内边距*/
    self.sectionInset = _sectionInsets;
    self.minimumLineSpacing = _miniLineSpace;
    self.minimumInteritemSpacing = _miniInterItemSpace;
    self.itemSize = _eachItemSize;
    /**
     * decelerationRate系统给出了2个值：
     * 1. UIScrollViewDecelerationRateFast（速率快）
     * 2. UIScrollViewDecelerationRateNormal（速率慢）
     * 此处设置滚动加速度率为fast，这样在移动cell后就会出现明显的吸附效果
     */
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
}

/**
 * 这个方法的返回值，就决定了collectionView停止滚动时的偏移量
 */
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat pageSpace = [self stepSpace];//计算分页步距
    CGFloat offsetMax = self.collectionView.contentSize.width - (pageSpace + self.sectionInset.right + self.miniLineSpace);
    CGFloat offsetMin = 0;
    /*修改之前记录的位置，如果小于最小contentsize或者大于最大contentsize则重置值*/
    if (_lastOffset.x < offsetMin) {
        _lastOffset.x = offsetMin;
    }
    else if (_lastOffset.x > offsetMax) {
        _lastOffset.x = offsetMax;
    }
    
    CGFloat offsetForCurrentPointX = ABS(proposedContentOffset.x - _lastOffset.x);//目标位移点距离当前点的距离绝对值
    CGFloat velocityX = velocity.x;
    BOOL direction = (proposedContentOffset.x - _lastOffset.x) > 0;//判断当前滑动方向,手指向左滑动：YES；手指向右滑动：NO
    
    if (offsetForCurrentPointX > pageSpace/8. && _lastOffset.x>=offsetMin && _lastOffset.x<=offsetMax) {
        NSInteger pageFactor = 0;//分页因子，用于计算滑过的cell个数
        if (velocityX != 0) {
            /*滑动*/
            pageFactor = ABS(velocityX);//速率越快，cell滑过数量越多
        } else {
            /**
             * 拖动
             * 没有速率，则计算：位移差/默认步距=分页因子
             */
            pageFactor = ABS(offsetForCurrentPointX/pageSpace);
        }
        
        /*设置pageFactor上限为2, 防止滑动速率过大，导致翻页过多*/
//        pageFactor = pageFactor<1?1:(pageFactor<3?1:2);
        pageFactor = 1;
        CGFloat pageOffsetX = pageSpace * pageFactor;
        proposedContentOffset = CGPointMake(_lastOffset.x + (direction? pageOffsetX : -pageOffsetX), proposedContentOffset.y);
    }
    else {
        /*滚动距离，小于翻页步距一半，则不进行翻页操作*/
        proposedContentOffset = CGPointMake(_lastOffset.x, _lastOffset.y);
    }
    
    //记录当前最新位置
    _lastOffset.x = proposedContentOffset.x;
    return proposedContentOffset;
}

/**
 *计算每滑动一页的距离：步距
 */
-(CGFloat)stepSpace {
    return self.eachItemSize.width + self.miniLineSpace;
}

// 当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息。
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds {
    return YES;
}

@end
