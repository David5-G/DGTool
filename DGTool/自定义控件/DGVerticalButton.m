//
//  DGVerticalButton.m
//  DGTool
//
//  Created by david on 2019/12/30.
//  Copyright © 2019 david. All rights reserved.
//

#import "DGVerticalButton.h"

@interface DGVerticalButton ()
/** 图片的尺寸 */
@property(nonatomic,assign)CGSize imageSize;

/** 按钮高度 */
@property (nonatomic, assign) CGFloat labelHeight;

/** 图片距离顶部高度 */
@property (nonatomic, assign) CGFloat imageTopSpace;

/** 标题距离底部高度 */
@property (nonatomic, assign) CGFloat titleBottomSpace;
@end

#pragma mark -
@implementation DGVerticalButton

 - (instancetype)initWithFrame:(CGRect)frame
                 withImageSize:(CGSize)imageViewSize
                    withLabelH:(CGFloat)labelH{
     if (self = [super initWithFrame:frame]) {
         //文本居中
         self.titleLabel.textAlignment = NSTextAlignmentCenter;
         
         //图片的内容模式
         self.imageView.contentMode = UIViewContentModeScaleAspectFit;
         
         //图片的尺寸
         self.imageSize = imageViewSize;
         
         //文字高度
         self.labelHeight = labelH;
     }
     return self;
 }

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //按钮的高度
    CGFloat selfHeight = self.bounds.size.height;
    //按钮的宽度
    CGFloat selfWidth = self.bounds.size.width;

    
    CGFloat imageY = 0;
    if (self.imageTopSpace != 0) {
        imageY = self.imageTopSpace;
    }
    
    CGFloat titleY = selfHeight - self.labelHeight;
    if (self.titleBottomSpace != 0) {
        titleY -= self.titleBottomSpace;
    }
    
    self.imageView.frame = CGRectMake((selfWidth - self.imageSize.width)/2, imageY, self.imageSize.width, self.imageSize.height);

    
    self.titleLabel.frame = CGRectMake(0, titleY, selfWidth, self.labelHeight);
}

#pragma mark -
//图片距离顶部间距
- (void)imageTopSpace:(CGFloat)space{

    self.imageTopSpace = space;
    [self setNeedsLayout];
    
}

//标题距离底部间距
- (void)titleBottomSpace:(CGFloat)space{
    self.titleBottomSpace = space;
    [self setNeedsLayout];
}

@end
