//
//  UIView+DGFrame.m
//  DGTool
//
//  Created by david on 2019/1/25.
//  Copyright © 2019 david. All rights reserved.
//

#import "UIView+DGFrame.h"

CGPoint CGRectGetCenter(CGRect rect) {
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center){
    CGRect newrect = CGRectZero;
    newrect.origin.x = center.x-CGRectGetMidX(rect);
    newrect.origin.y = center.y-CGRectGetMidY(rect);
    newrect.size = rect.size;
    return newrect;
}

#pragma mark -
@implementation UIView (DGFrame)

-(CGPoint)origin {
    return self.frame.origin;
}

-(void)setOrigin:(CGPoint)origin {
    CGRect newframe = self.frame;
    newframe.origin = origin;
    self.frame = newframe;
}

-(CGSize)size {
    return self.frame.size;
}

-(void)setSize:(CGSize)size {
    CGRect newframe = self.frame;
    newframe.size = size;
    self.frame = newframe;
}

-(CGFloat)height {
    return self.size.height;
}

-(void)setHeight:(CGFloat)height {
    CGRect newframe = self.frame;
    newframe.size.height = height;
    self.frame = newframe;
}

-(CGFloat)width {
    return self.size.width;
}

-(void)setWidth:(CGFloat)width {
    CGRect newframe = self.frame;
    newframe.size.width = width;
    self.frame = newframe;
}


#pragma mark -
-(CGPoint)topLeft {
    return self.origin;
}

-(CGPoint)topRight {
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}

-(CGPoint)bottomLeft {
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

-(CGPoint)bottomRight {
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}


-(CGFloat)centerX {
    return self.center.x;
}

-(void)setCenterX:(CGFloat)centerX {
    CGPoint newCenter = self.center;
    newCenter.x = centerX;
    self.center = newCenter;
}

-(CGFloat)centerY {
    return self.center.y;
}

-(void)setCenterY:(CGFloat)centerY {
    CGPoint newCenter = self.center;
    newCenter.y = centerY;
    self.center = newCenter;
}

-(CGFloat)top {
    return self.frame.origin.y;
}

-(void)setTop:(CGFloat)top {
    CGRect newframe = self.frame;
    newframe.origin.y = top;
    self.frame = newframe;
}

-(CGFloat)left {
    return self.frame.origin.x;
}

-(void)setLeft:(CGFloat)left {
    CGRect newframe = self.frame;
    newframe.origin.x = left;
    self.frame = newframe;
}

-(CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

-(void)setBottom:(CGFloat)bottom {
    CGRect newframe = self.frame;
    newframe.origin.y = bottom - self.frame.size.height;
    self.frame = newframe;
}

-(CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

-(void)setRight:(CGFloat)right {
    CGRect newframe = self.frame;
    CGFloat delta = right - self.right;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

#pragma mark - 
-(void)moveBy:(CGPoint)delta {
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

-(void)scaleBy:(CGFloat)scaleFactor {
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

-(void)fixCenterScaleBy:(CGFloat)scaleFactor {
    CGFloat x = (self.width * (1 - scaleFactor))/2;
    CGFloat y = (self.height * (1 - scaleFactor))/2;
    CGFloat newWidth = self.width * scaleFactor;
    CGFloat newHeight = self.height * scaleFactor;
    self.bounds = CGRectMake(x, y, newWidth, newHeight);
}

-(void)fitInSize:(CGSize)aSize {
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height))
    {
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width))
    {
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;
}


@end
