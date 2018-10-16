//
//  DGHookTrack.h
//  DGTool
//
//  Created by david on 2018/10/10.
//  Copyright © 2018 david. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DGHookTrack : NSObject

/** debug */
@property (nonatomic,assign) NSInteger debug;

/** 堆栈中所有控制器的名字 */
@property(nonatomic,strong) NSMutableArray *lastVCs;

/** 目前所在控制器的名字 */
@property(nonatomic,copy) NSString *currentVCStr;

#pragma mark - popPushActionStr
/** 预制记录 接口请求成功后会有控制器进入的动作 */
@property(nonatomic,copy) NSString *prePushActionStr;

/** 预制记录 接口请求成功后会有控制器退出的动作 */
@property(nonatomic,copy) NSString *prePopActionStr;

/** 记录控制器进出的记录 */
@property(nonatomic,copy) NSString *pushPopActionStr;

/** 记录动作点击触发的记录 */
@property(nonatomic,copy) NSString *triggerActionStr;


#pragma mark -
/** 获取单例对象 */
+ (instancetype)getInstance;

/** 抓取这个请求发起时触发的路径 */
+ (void)catchTrack;

/**
 *  toVC 将要进入的控制器名称
 *  这个接口请求成功后 将要进入的控制器
 *  需要在接口请求前预制
 */
+ (void)willPushTo:(NSString *)toVC;

/**
 *  index 控制器将后退的层数
 *  这个接口请求成功后 将要后退的层数
 *  需要在接口请求前预制
 */
+ (void)willPopOfIndex:(int)index;



@end
