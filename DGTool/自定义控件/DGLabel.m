//
//  DGLabel.m
//  DGTool
//
//  Created by jczj on 2018/8/23.
//  Copyright © 2018年 david. All rights reserved.
//

#import "DGLabel.h"

@implementation DGLabel

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}



/** 创建 制定font,color的label */
+ (UILabel *)labelWithFontSize:(CGFloat)fontSize color:(UIColor *)color {
    return [self labelWithFontSize:fontSize color:color bold:NO];
}

/** 创建 制定font,color的label */
+ (DGLabel *)labelWithFontSize:(CGFloat)fontSize color:(UIColor *)color bold:(BOOL)isBold {
    
    DGLabel *label = [[DGLabel alloc]init];
    label.textColor = color;
    label.textAlignment = NSTextAlignmentLeft;
    
    if (isBold) {
        label.font = [UIFont boldSystemFontOfSize:fontSize];
    }else{
        label.font = [UIFont systemFontOfSize:fontSize];
    }
    return label;
}

@end
