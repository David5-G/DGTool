//
//  UIImage+DGEffect.h
//  DGTool
//
//  Created by david on 2018/12/26.
//  Copyright © 2018 david. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Effect)

/** CoreImage进行模糊 */
+ (UIImage *)coreBlurImage:(UIImage *)image blurLevel:(CGFloat)blur;

/** vImage进行模糊 */
+ (UIImage *)vBlurImage:(UIImage *)image blurLevel:(CGFloat)blur;

@end

NS_ASSUME_NONNULL_END
