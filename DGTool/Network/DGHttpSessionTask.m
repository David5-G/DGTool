//
//  DGHttpSessionTask.m
//  DGTool
//
//  Created by david on 2018/10/9.
//  Copyright © 2018 david. All rights reserved.
//

#import "DGHttpSessionTask.h"
#import "DGShare.h"
#import "DGHookTrack.h"

@interface DGHttpSessionTask()
/** 统一处理回调合集 */
@property(nonatomic,retain) NSMutableArray *logicMutArr;
@end


@implementation DGHttpSessionTask

#pragma mark - init
static DGHttpSessionTask *instance = nil;
static dispatch_once_t onceToken;

+ (instancetype)getInstance
{
    dispatch_once(&onceToken, ^{
        instance = [[DGHttpSessionTask alloc] init];
        [instance initBase];
    });
    return instance;
}

- (void)initBase{
    _timeoutInterval= 10;
}

#pragma mark - request
-(void)post:(id)url params:(id)paramsDic completionHandler:(HttpTaskCompletionHandler)completionHandler {
    [self request:url Params:paramsDic type:0 completionHandler:completionHandler];
}

-(void)get:(id)url params:(id)paramsDic completionHandler:(HttpTaskCompletionHandler)completionHandler {
    [self request:url Params:paramsDic type:1 completionHandler:completionHandler];
}

- (void)request:(id)url Params:(id)paramsDic type:(NSInteger)type completionHandler:(HttpTaskCompletionHandler)completionHandler {
    
    //1.判断url
    NSURL *tempUrl;
    if ([url isKindOfClass:[NSURL class]]) {
        tempUrl = url;
    }else if ([url isKindOfClass:[NSString class]]) {
        tempUrl = [NSURL URLWithString:url];
    }else{
        DGHttpLog(@"url 不合法");
    }
    
    //2.设置hookTrack
//    [CC_HookTrack catchTrack];
    
    //3.创建responseModel获取service
    DGHttpResponseModel *model = [[DGHttpResponseModel alloc]init];
    model.serviceStr=paramsDic[@"service"];
    
    //4.设置执行block的deleage
    DGHttpSessionTask *executorDelegate = [[DGHttpSessionTask alloc]init];
    executorDelegate.completionHandler = completionHandler;// 绑定执行完成时的block
    
    //5.创建session
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession  *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:executorDelegate delegateQueue:nil];
    
    //6.设置params参数
    if ([paramsDic isKindOfClass:[NSDictionary class]]) {
        paramsDic=[[NSMutableDictionary alloc] initWithDictionary:paramsDic];
    }
    
    if (!_forbiddenTimeStamp) {
        if (!paramsDic[@"timestamp"]) {
            NSDate *datenow = [NSDate date];
            NSString *timeStamp = [NSString stringWithFormat:@"%.0f", [datenow timeIntervalSince1970]*1000];
            [paramsDic setObject:timeStamp forKey:@"timestamp"];
        }
    }
    
    if (_extreDic) {
        NSArray *keys=[_extreDic allKeys];
        for (int i=0; i<keys.count; i++) {
            [paramsDic setObject:_extreDic[keys[i]] forKey:keys[i]];
        }
    }
    
    if (!_signKeyStr) {
        if (model.debug) {
            DGHttpLog(@"_signKeyStr为空");
        }
    }
    
    //添加埋点追踪
    if (!_forbiddenSendHookTrack) {
        NSString *pushPop = [DGHookTrack getInstance].pushPopActionStr;
        if (pushPop) {
            [paramsDic setObject:pushPop forKey:@"pushPopAction"];
            [DGHookTrack getInstance].pushPopActionStr = nil;
        }
        NSString *trigger = [DGHookTrack getInstance].triggerActionStr;
        if (trigger) {
            [paramsDic setObject:trigger forKey:@"triggerAction"];
            [DGHookTrack getInstance].triggerActionStr = nil;
        }
        NSString *prePush = [DGHookTrack getInstance].prePushActionStr;
        if (prePush) {
            [paramsDic setObject:prePush forKey:@"prePushAction"];
            [DGHookTrack getInstance].prePushActionStr = nil;
        }
        NSString *prePop = [DGHookTrack getInstance].prePopActionStr;
        if (prePop) {
            [paramsDic setObject:prePop forKey:@"prePopAction"];
            [DGHookTrack getInstance].prePopActionStr = nil;
        }
    }
    
    NSString *paraString;// = [CC_FormatDic getSignFormatStringWithDic:paramsDic andMD5Key:_signKeyStr];
    
    NSURLRequest *urlReq = [self requestWithUrl:tempUrl andParamters:paraString andType:type];
}


#pragma mark request
/** 创建request */
- (NSURLRequest *)requestWithUrl:(NSURL *)url andParamters:(NSString *)paramsString andType:(int)type{
    
    //1.创建request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    request.URL=url;
    
    //2.设置
    request.HTTPBody = [paramsString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSArray *types = @[@"POST",@"GET"];
    [request setHTTPMethod:types[type]];
    [request setTimeoutInterval:_timeoutInterval];
    
    //3.设置headerField
    if (!_requestHttpHeaderFieldDic) {
        DGHttpLog(@"没有设置_requestHTTPHeaderFieldDic");
        return request;
    }
    
    NSArray *keys=[_requestHttpHeaderFieldDic allKeys];
    for (int i=0; i<keys.count; i++) {
        [request setValue:_requestHttpHeaderFieldDic[keys[i]] forHTTPHeaderField:keys[i]];
    }
    return request;
}

@end
