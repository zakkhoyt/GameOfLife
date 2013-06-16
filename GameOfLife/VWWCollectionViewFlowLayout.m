//
//  VWWCollectionViewFlowLayout.m
//  FlickrSearch
//
//  Created by Zakk Hoyt on 1/25/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "VWWCollectionViewFlowLayout.h"


static const CGFloat kMaxDistancePercentage = 0.3f;
static const CGFloat kMaxRotation = (CGFloat)(50.0 * (M_PI / 180.0));
static const CGFloat kMaxZoom = 0.3f;

@implementation VWWCollectionViewFlowLayout

- (id)init {
    if ((self = [super init])) {
//        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 2.0f;
    }
    return self;
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect { // 1
    CGRect visibleRect = (CGRect){
        .origin = self.collectionView.contentOffset,
        .size = self.collectionView.bounds.size
    };
    
    CGFloat maxDistance = visibleRect.size.width * kMaxDistancePercentage;
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes *attributes in array) {
        CGFloat w = visibleRect.size.width / 10;
        attributes.frame = CGRectMake(0, 0, w, w);
//        CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
//        CGFloat normalizedDistance = distance / maxDistance; normalizedDistance = MIN(normalizedDistance, 1.0f);
//        normalizedDistance = MAX(normalizedDistance, -1.0f);
//        CGFloat rotation = normalizedDistance * kMaxRotation;
//        CGFloat zoom = 1.0f + ((1.0f - ABS(normalizedDistance)) * kMaxZoom);
//        CATransform3D transform = CATransform3DIdentity;
//        transform.m34 = 1.0 / -1000.0;
//        transform = CATransform3DRotate(transform, rotation, 0.0f, 1.0f, 0.0f);
//        transform = CATransform3DScale(transform, zoom, zoom, 0.0f);
//        attributes.transform3D = transform;
    }
    return array;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}


//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
//                                 withScrollingVelocity:(CGPoint)velocity{
//    CGFloat offsetAdjustment = CGFLOAT_MAX;
//    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0f);
//    CGRect targetRect = CGRectMake(proposedContentOffset.x,
//                                   0.0f,
//                                   self.collectionView.bounds.size.width,
//                                   self.collectionView.bounds.size.height);
//    
//    NSArray *array = [super layoutAttributesForElementsInRect:targetRect];
//    for (UICollectionViewLayoutAttributes* layoutAttributes in array){
//        CGFloat distanceFromCenter = layoutAttributes.center.x - horizontalCenter;
//        if(ABS(distanceFromCenter) < ABS(offsetAdjustment)){
//            offsetAdjustment = distanceFromCenter;
//        }
//    }
//    
//    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
//}




@end
