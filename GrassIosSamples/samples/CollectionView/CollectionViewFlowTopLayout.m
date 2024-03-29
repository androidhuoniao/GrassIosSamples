//
//  CollectionViewFlowTopLayout.m
//  GrassIosSamples
//
//  Created by grassswwang on 2023/8/7.
//  Copyright © 2023 Tencent. All rights reserved.
//

#import "CollectionViewFlowTopLayout.h"

@interface CollectionViewFlowTopLayout ()

@property (nonatomic, assign) CGFloat screenWidth;

@end

@implementation CollectionViewFlowTopLayout

// 当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息。
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds {
    return YES;
}

//手动指定偏移量
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
//    NSLog(@"flowlayout_targetContentOffsetForProposedContentOffset:%@ collectionViewSize:%@", NSStringFromCGPoint(proposedContentOffset), NSStringFromCGSize(self.collectionView.frame.size));
//    // 计算出最终显示的矩形框
//    CGFloat screenWidth = self.collectionView.frame.size.width;
//    CGRect rect;
//    rect.origin.y = 0;
//    rect.origin.x = proposedContentOffset.x;
//    rect.size = self.collectionView.frame.size;
//    NSInteger pageIndex = proposedContentOffset.x / screenWidth;
//    //获得super已经计算好的布局的属性
//    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
//    NSLog(@"flowlayout_targetContentOffsetForProposedContentOffset:arr.count:%ld", arr.count);
//    //计算collectionView最中心点的x值
//    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
//    CGFloat minDelta = [self cardWidth]; //cell的宽度
//    for (UICollectionViewLayoutAttributes *attrs in arr) {
//        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
//            minDelta = attrs.center.x - centerX;
//        }
//    }
//    proposedContentOffset.x += minDelta;
//    NSLog(@"flowlayout_targetContentOffsetForProposedContentOffset: centerX:%f minDelta:%f finalX:%f", centerX, minDelta, proposedContentOffset.x);
//    return proposedContentOffset;
//}

- (CGFloat)cardWidth {
    return self.screenWidth - 2 * 16;
}

//_collectionView.pagingEnabled一定要设置为NO;
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)offset
                                 withScrollingVelocity:(CGPoint)velocity {
    CGRect cvBounds = self.collectionView.bounds;
    CGFloat halfWidth = cvBounds.size.width * 0.5f;
    CGFloat proposedContentOffsetCenterX = offset.x + halfWidth;

    NSArray* attributesArray = [self layoutAttributesForElementsInRect:cvBounds];

    UICollectionViewLayoutAttributes* candidateAttributes;
    for (UICollectionViewLayoutAttributes* attributes in attributesArray) {

        // == Skip comparison with non-cell items (headers and footers) == //
        if (attributes.representedElementCategory !=
            UICollectionElementCategoryCell) {
            continue;
        }

        // == First time in the loop == //
        if(!candidateAttributes) {
            candidateAttributes = attributes;
            continue;
        }

        if (fabs(attributes.center.x - proposedContentOffsetCenterX) <
            fabs(candidateAttributes.center.x - proposedContentOffsetCenterX)) {
            candidateAttributes = attributes;
        }
    }

    return CGPointMake(candidateAttributes.center.x - halfWidth, offset.y);

}

- (CGFloat)screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

@end
