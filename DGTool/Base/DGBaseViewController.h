//
//  DGBaseViewController.h
//  DGTool
//
//  Created by david on 2018/12/26.
//  Copyright © 2018 david. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGNavigationBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface DGBaseViewController : UIViewController

@property(nonatomic,weak,readonly) DGNavigationBar *naviBar;

@property (nonatomic,weak,readonly) UIView *displayView;

#pragma mark - statusBar
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
- (void)setNaviBarWithType:(DGNavigationBarType)barType;

/** 获取navigationBar类型 */
- (DGNavigationBarType)naviBarType;

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

/** 延迟点击backBtn */
- (void)clickBackButtonWithDelay:(CGFloat)delay;

#pragma mark - 查看图片
- (void)previewImages:(NSArray <UIImage *>*)images defaultIndex:(NSInteger)index;
- (void)previewImage:(UIImage *)image;
- (void)previewImageWithUrl:(NSURL *)imageUrl;

@end

NS_ASSUME_NONNULL_END
