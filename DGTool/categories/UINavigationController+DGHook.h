//
//  UINavigationController+DGHook.h
//  DGTool
//
//  Created by david on 2018/10/12.
//  Copyright © 2018 david. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (DGHook)

+ (void)dg_hookPush;

+ (void)dg_hookPop;

@end
