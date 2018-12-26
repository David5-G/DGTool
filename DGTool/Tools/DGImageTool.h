//
//  DGImageTool.h
//  DGTool
//
//  Created by david on 2018/9/28.
//  Copyright © 2018 david. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DGImageTool : NSObject

#pragma mark - color
/**
 根据图片获取主要颜色
 
 @param image      图片
        deviation  默认为0,不忽略偏差
 @return 颜色值
 */
+(UIColor*)mostColorForImage:(UIImage*)image;

/**
 根据图片获取主要颜色
 
 @param  image      图片
 @param  deviation  忽略偏差 (rgb两两偏差都小于此值的颜色,不记录比较)
 例1-> 灰色rgb相互偏差为0;  例2-> r=1,b=5,他们偏差为4
 @return 颜色值
 */
+(UIColor*)mostColorForImage:(UIImage*)image ignoreDeviation:(NSUInteger)deviation;

#pragma mark - imge
/** 画圆角矩形 */
+ (UIImage *)imageWithBgColor:(UIColor *)bgColor size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;

/** 图片缩放到指定大小尺寸 */
+ (UIImage *)scaleImage:(UIImage *)img toSize:(CGSize)size;

/** 给图片画文字 */
+ (UIImage *)addText:(NSString *)text toImage:(UIImage *)image attributes:(NSDictionary<NSString *, id> *)attributes leftEdge:(CGFloat)left topEdge:(CGFloat)top;

@end
