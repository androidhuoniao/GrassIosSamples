//
//  CollectionViewPagingAndCenteFlowLayout.m
//  GrassIosSamples
//
//  Created by grassswwang on 2023/8/8.
//  Copyright © 2023 Tencent. All rights reserved.
//

#import "CollectionViewPagingAndCenterFlowLayout.h"

@interface CollectionViewPagingAndCenterFlowLayout ()

@property (nonatomic, assign) CGFloat screenWidth;

@end

/// 一次滑动切换一个，同时卡片居中显示
@implementation CollectionViewPagingAndCenterFlowLayout

// 当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息。
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds {
    return YES;
}

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
