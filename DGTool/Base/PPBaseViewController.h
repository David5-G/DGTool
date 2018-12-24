//
//  PPBaseViewController.h
//  PaPa
//
//  Created by david on 2018/10/24.
//  Copyright © 2018 万耀辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPNavigationBar.h"

@interface PPBaseViewController : UIViewController

@property(nonatomic,weak,readonly) PPNavigationBar *naviBar;

@property (nonatomic,weak,readonly) UIView *displayView;

#pragma mark - statusBar
- (UIStatusBarStyle)preferredStatusBarStyle;
- (UIStatusBarStyle)getStatusBarStyle;

#pragma mark - navi
/** 设置navigationBar  默认 */
- (void)setNaviBarDefault;

/** 设置navigationBar  透明无标题 */
- (void)setNaviBarClear;

/** 设置navigationBar  白底黑字 */
- (void)setNaviBarWhite;

/** 设置navigationBar  灰底,黑字 */
- (void)setNaviBarGray;

/** 设置navigationBar  barType类型 */
- (void)setNaviBarWithType:(PPNavigationBarType)barType;

/** 获取navigationBar类型 */
- (PPNavigationBarType)naviBarType;


#pragma mark 
/** naviBar的高度 */
-(CGFloat)naviBarHeight;

/** 设置naviBar的背景图 */
-(void)setNavigBarBackgroundImage:(UIImage *)image;

/** 设置naviBar背景色,此方法会隐藏导航栏背景图 */
-(void)setNaviBarBackgroundColor:(UIColor *)color;

#pragma mark title
/** 获取title */
- (NSString *)naviBarTitle;

/** 设置title */
- (void)setNaviBarTitle:(NSString *)title;

/** 设置title颜色 */
- (void)setNaviBarTitleColor:(UIColor *)color;

/** 设置title字体大小 */
- (void)setNaviBarTitleFont:(UIFont *)font;

#pragma mark backButton
/** 隐藏backBtn */
- (void)hiddenBackButton;

/** 点击backBtn */
- (void)clickBackButton;



@end
