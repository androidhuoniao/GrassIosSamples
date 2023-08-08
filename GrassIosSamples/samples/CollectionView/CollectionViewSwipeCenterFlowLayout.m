//
//  CollectionViewSwipeCenteFlowLayout.m
//  GrassIosSamples
//
//  Created by grassswwang on 2023/8/8.
//  Copyright © 2023 Tencent. All rights reserved.
//

#import "CollectionViewSwipeCenterFlowLayout.h"

@interface CollectionViewSwipeCenterFlowLayout ()

@property (nonatomic, assign) CGFloat screenWidth;

@end

@implementation CollectionViewSwipeCenterFlowLayout

// 当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息。
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds {
    return YES;
}

// 手动指定偏移量
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    NSLog(@"flowlayout_targetContentOffsetForProposedContentOffset:%@ collectionViewSize:%@", NSStringFromCGPoint(proposedContentOffset), NSStringFromCGSize(self.collectionView.frame.size));
    // 计算出最终显示的矩形框
    CGFloat screenWidth = self.collectionView.frame.size.width;
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    NSInteger pageIndex = proposedContentOffset.x / screenWidth;
    //获得super已经计算好的布局的属性
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    NSLog(@"flowlayout_targetContentOffsetForProposedContentOffset:arr.count:%ld", arr.count);
    //计算collectionView最中心点的x值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    CGFloat minDelta = [self cardWidth]; //cell的宽度
    for (UICollectionViewLayoutAttributes *attrs in arr) {
        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
            minDelta = attrs.center.x - centerX;
        }
    }
    proposedContentOffset.x += minDelta;
    NSLog(@"flowlayout_targetContentOffsetForProposedContentOffset: centerX:%f minDelta:%f finalX:%f", centerX, minDelta, proposedContentOffset.x);
    return proposedContentOffset;
}

- (CGFloat)cardWidth {
    return self.screenWidth - 2 * 16;
}

- (CGFloat)screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

@end
