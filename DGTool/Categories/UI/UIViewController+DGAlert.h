//
//  UIViewController+DGAlert.h
//  DGTool
//
//  Created by david on 2018/12/26.
//  Copyright © 2018 david. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (DGAlert)

#pragma mark - 警告框 提醒
-(void)dg_alertWithTitle:(NSString *)title message:(NSString *)message;
-(void)dg_alertWithTitle:(NSString *)title message:(NSString *)message duration:(float)duration;

#pragma mark - 警告框 操作
-(void)dg_alert:(UIAlertControllerStyle)style Title:(NSString *)title message:(NSString *)message actions:(NSArray<UIAlertAction *> *)actions;

-(void)dg_alert:(UIAlertControllerStyle)style Title:(NSString *)title titleFontSize:(float)titleFontSize message:(NSString *)message messageFontSize:(float)messageFontSize actions:(NSArray<UIAlertAction *> *)actions;

@end

NS_ASSUME_NONNULL_END
