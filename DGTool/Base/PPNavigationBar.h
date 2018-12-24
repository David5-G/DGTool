//
//  PPNavigationBar.h
//  PaPa
//
//  Created by david on 2018/10/24.
//  Copyright © 2018 万耀辉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PPNavigationBarType) {
    PPNavigationBarTypeDefault,           // 红色背景 白色标题
    PPNavigationBarTypeClear,         //透明背景  无标题
    PPNavigationBarTypeWhite,         //白色背景  黑色标题
    PPNavigationBarTypeGray           // 灰色背景f2f2f2, 黑色标题
};

@interface PPNavigationBar : UIView

@property (nonatomic,weak) UIButton *backButton;
@property (nonatomic,weak) UILabel *titleLabel;
@property (nonatomic,strong) UIImage *bgImage;
@property (nonatomic,assign) PPNavigationBarType barType;

-(void)setNaviBarBackgroundColor:(UIColor *)bgColor;
@end
