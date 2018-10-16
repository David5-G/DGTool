//
//  DGHttpSessionTask.h
//  DGTool
//
//  Created by david on 2018/10/9.
//  Copyright © 2018 david. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DGHttpResponseModel.h"

typedef void(^HttpTaskCompletionHandler)(NSString *errorStr, DGHttpResponseModel *model);

@interface DGHttpSessionTask : NSObject<NSURLSessionDelegate>

+ (instancetype)getInstance;


#pragma mark - 设置请求
/** 访问ip */
@property(nonatomic,copy) NSString *scopeIp;

/**
 *  设置一次 额外的 每个接口都要发送的数据
 *  可放入 比如 authedUserId timestamp
 */
@property(nonatomic,retain) NSDictionary *extreDic;

/** 超时时间 */
@property(nonatomic,assign) NSTimeInterval timeoutInterval;

/** 不传 时间戳字段 */
@property(nonatomic,assign) BOOL forbiddenTimeStamp;

/** 不传 埋点路径操作数据 */
@property(nonatomic,assign) BOOL forbiddenSendHookTrack;

/** 获取 根据response里返回的http头部的时间 即服务端相应发送时间 */
@property(nonatomic,assign) BOOL needResponseDate;

/** 设置登录后拿到的signKey */
@property(nonatomic,retain) NSString *signKeyStr;

/** 执行完成后回调的block */
@property(nonatomic,copy) HttpTaskCompletionHandler completionHandler;

/** 设置通用响应结果特殊处理回调集合 */
@property(nonatomic,retain) NSMutableDictionary *logicBlockMutDic;

/** 添加额外参数 */
- (void)addExtreDic:(NSDictionary *)dic;

#pragma mark - httpHeaderField
/** 设置http请求头部 */
@property(nonatomic,strong) id requestHttpHeaderFieldDic;
/**
 *  重写requestHTTPHeaderFieldDic的set和get
 *  类型可以为NSDictionary or NSMutableDictionary
 */
- (void)setRequestHTTPHeaderFieldDic:(id)requestHTTPHeaderFieldDic;
- (id)requestHTTPHeaderFieldDic;

#pragma mark - request
/**
 * url NSString 或者 NSURL
 * paramsDic的关键字
 */
- (void)post:(id)url params:(id)paramsDic completionHandler:(HttpTaskCompletionHandler)completionHandler;

- (void)get:(id)url params:(id)paramsDic completionHandler:(HttpTaskCompletionHandler)completionHandler;

/**
 *  设置通用响应结果特殊处理回调逻辑
 *  logicName  给这个逻辑处理起一个名字
 *  logicStr  判断条件语句  提供两种判断
 可连续配置多种不同的特殊处理回调逻辑用‘,’分隔嵌套字段
 1 根据响应某字段aaa=bbb   如response,error=third
 2 根据响应有无某字段aaa    如response,error
 *  stop 是否立即停止只跑回调方法 即正常的回调不再回调过去
 应用场景：弹出其他地方登录后 黑底白字的提示不用弹 统一不回调回去 stop=YES
 *  popOnce 是否只回调一次
 应用场景：进入一个页面连续调3个接口 3个接口回调都会报在其他地方登录 只要一次回调弹窗提示 需要过滤其他两个时 popOnce=YES
 *  logicBlock 符合条件后的回调，回调的逻辑，需要在appDelegate里配置
 *
 *  例子:
 *  [[DGHttpSessionTask getInstance] addResponseLogic:@"PARAMETER_ERROR" logicStr:@"response,error,name=PARAMETER_ERROR" stop:YES popOnce:YES logicBlock:^(NSDictionary *resultDic) {
 //在这里添加处理代码
 }];
 */
- (void)addResponseLogic:(NSString *)logicName logicStr:(NSString *)logicStr stop:(BOOL)stop popOnce:(BOOL)popOnce logicBlock:(void (^)(NSDictionary *resultDic))block;


/**
 *  logicName  添加时起的名字
 *  重置只回调一次的设置
 *  应用场景：其他地方登陆后点确定后需重置 因为下一次调就又要弹窗了
 *
 *  例子：
 *  [[DGHttpSessionTask getInstance] resetResponseLogicPopOnce:@"PARAMETER_ERROR"];
 */
- (void)resetResponseLogicPopOnce:(NSString *)logicName;


@end
