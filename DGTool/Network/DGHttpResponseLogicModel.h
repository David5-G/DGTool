//
//  DGHttpResponseLogicModel.h
//  DGTool
//
//  Created by david on 2018/10/23.
//  Copyright © 2018 david. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DGHttpResponseLogicModel : NSObject

/** 统一处理回调 的名字 */
@property(nonatomic,copy) NSString *logicNameStr;

/** 统一处理回调 的判断字段路径 */
@property(nonatomic,copy) NSArray *logicPathArr;

/** 统一处理回调 的判断相等的字段 */
@property(nonatomic,copy) NSString *logicEqualStr;

/** 统一处理回调 是否立即停止不传递 */
@property(nonatomic,assign) BOOL logicPassStop;

/** 统一处理回调 只回调一次 */
@property(nonatomic,assign) BOOL logicPopOnce;

/** 统一处理回调 条件判断成立 */
@property(nonatomic,assign) BOOL logicPassed;

/** 统一处理回调 block*/
@property(nonatomic,copy) void (^logicBlock)(NSDictionary *resultDic);

@end
