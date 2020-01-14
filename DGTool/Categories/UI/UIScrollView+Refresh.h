//
//  UIScrollView+Refresh.h
//  
//
//  Created by david on 15/4/11.
//  Copyright © 2015年 GW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface UIScrollView (Refresh)
#pragma mark - add
/** 添加简单的头部刷新 (没有上次刷新时间,没有状态) */
- (void)addSimpleHeaderRefresh:(MJRefreshComponentAction)block;
/** 添加头部刷新 */
- (void)addHeaderRefresh:(MJRefreshComponentAction)block;
/** 添加脚部自动刷新 */
- (void)addAutoFooterRefresh:(MJRefreshComponentAction)block;
/** 添加脚部自动刷新 (当底部控件出现多少时就自动刷新 0~1.0) */
- (void)addAutoFooterRefreshWithPercent:(CGFloat)percent block:(MJRefreshComponentAction)block;
/** 添加脚步返回刷新 */
- (void)addBackFooterRefresh:(MJRefreshComponentAction)block;
/** 设置脚部title */
- (void)setStateFooterTitle:(NSString *)title forState:(MJRefreshState)state;
/** 设置头部title */
- (void)setStateHeaderTitle:(NSString *)title forState:(MJRefreshState)state;

#pragma mark - begin/end
/** 开始头部刷新 */
- (void)beginHeaderRefresh;
/** 开始脚部刷新 */
- (void)beginFooterRefresh;
/** 结束头部刷新 */
- (void)endHeaderRefresh;
/** 结束脚部刷新 */
- (void)endFooterRefresh;
/** 结束脚步刷新并设置没有更多数据 */
- (void)endFooterRefreshWithNoMoreData;

@end










