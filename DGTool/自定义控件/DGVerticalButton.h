//
//  DGVerticalButton.h
//  DGTool
//
//  Created by david on 2019/12/30.
//  Copyright © 2019 david. All rights reserved.
//

#import "DGButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface DGVerticalButton : DGButton

/**
 自定义（图上 文下） 按钮的初始化方法

 @param frame 按钮的尺寸
 @param imageViewSize 图片的尺寸
 @param labelH 文字高度
 @return 创建按钮
 */
- (instancetype)initWithFrame:(CGRect)frame
                withImageSize:(CGSize)imageViewSize
                   withLabelH:(CGFloat)labelH;

/** 图片距离顶部间距 */
- (void)imageTopSpace:(CGFloat)space;

/** 标题距离底部间距 */
- (void)titleBottomSpace:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END
