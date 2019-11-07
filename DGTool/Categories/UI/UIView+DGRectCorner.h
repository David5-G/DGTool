//
//  UIView+DGRectCorner.h
//  DGTool
//
//  Created by david on 2019/9/16.
//  Copyright © 2019 david. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (DGRectCorner)

/** 切除view指定的角让其变为圆角,  rectCorner 一共四种可复选,  cornerRadius 圆角半径 */
- (void)dg_AddRectCorner:(UIRectCorner)rectCorner Radius:(CGFloat)cornerRadius;

/** 切除view指定的角让其变为圆角,
 @param rectCorner 一共四种可复选,
 @param cornerRadius 圆角半径,
 @param lineColor 环绕自身的一圈线的颜色
 @param lineWidth 线宽度
 */
- (void)dg_AddRectCorner:(UIRectCorner)rectCorner Radius:(CGFloat)cornerRadius LineColor:(UIColor *)lineColor LineWidth:(CGFloat)lineWidth;

@end

NS_ASSUME_NONNULL_END
