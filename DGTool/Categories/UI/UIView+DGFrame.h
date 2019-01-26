//
//  UIView+DGFrame.h
//  DGTool
//
//  Created by david on 2019/1/25.
//  Copyright © 2019 david. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

#pragma mark -
@interface UIView (DGFrame)

@property CGPoint origin;
@property CGSize size;
@property CGFloat height;
@property CGFloat width;

#pragma mark -
@property (readonly) CGPoint topLeft;//就是origin
@property (readonly) CGPoint topRight;
@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;

@property CGFloat centerX;
@property CGFloat centerY;

@property CGFloat top;
@property CGFloat left;
@property CGFloat bottom;
@property CGFloat right;

#pragma mark -
-(void)moveBy:(CGPoint)delta;
-(void)scaleBy:(CGFloat)scaleFactor;
-(void)fixCenterScaleBy:(CGFloat)scaleFactor;
-(void)fitInSize:(CGSize)aSize;

@end

NS_ASSUME_NONNULL_END
