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
#import "DGHttpRequestRecord.h"
#import "DGHttpResponseLogicModel.h"

@interface DGHttpSessionTask()
/** 统一处理回调合集 */
@property(nonatomic,strong) NSMutableArray *logicMutArr;
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
    model.serviceStr = paramsDic[@"service"];
    
    //4.设置执行block的deleage
    DGHttpSessionTask *executorDelegate = [[DGHttpSessionTask alloc] init];
    executorDelegate.completionHandler = completionHandler;// 绑定执行完成时的block
    
    //5.创建session
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession  *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:executorDelegate delegateQueue:nil];
    
    //6.设置params参数
    if ([paramsDic isKindOfClass:[NSDictionary class]]) {
        paramsDic = [[NSMutableDictionary alloc] initWithDictionary:paramsDic];
    }
    
    if (!_forbiddenTimeStamp) {
        if (!paramsDic[@"timestamp"]) {
            NSDate *datenow = [NSDate date];
            NSString *timeStamp = [NSString stringWithFormat:@"%.0f", [datenow timeIntervalSince1970]*1000];
            [paramsDic setObject:timeStamp forKey:@"timestamp"];
        }
    }
    
    if (_extreDic) {
        NSArray *keys = [_extreDic allKeys];
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
    
    model.requestUrlStr = urlReq.URL.absoluteString;
    model.requestStr = [NSString stringWithFormat:@"%@%@",urlReq.URL.absoluteString,paraString];
    
    __block DGHttpSessionTask *blockSelf = self;
    NSURLSessionDownloadTask *downTask = [session downloadTaskWithRequest:urlReq completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        [session finishTasksAndInvalidate];
        
        //域名处理
        if (NSURLErrorCannotFindHost == error.code) {
            NSURL *errorUrl =  error.userInfo[NSURLErrorFailingURLErrorKey];
            NSString *ipStr = blockSelf.scopeIp;
            
            if (ipStr.length>0 && errorUrl.host.length>0) {
                
                NSMutableString *mutErrorUrlStr = [NSMutableString stringWithString:errorUrl.relativeString];
                NSString *newUrlStr = [mutErrorUrlStr stringByReplacingOccurrencesOfString:errorUrl.host withString:ipStr];
                NSURL *newUrl = [NSURL URLWithString:newUrlStr];
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [blockSelf.requestHttpHeaderFieldDic setObject:errorUrl.host forKey:@"host"];
                    [blockSelf request:newUrl Params:paramsDic type:type completionHandler:^(NSString *errorStr, DGHttpResponseModel *model) {
                        completionHandler(errorStr,model);
                    }];
                    executorDelegate.completionHandler(@"", model);
                });
                return ;
            }
            
        }else {
            [blockSelf.requestHttpHeaderFieldDic setObject:@"" forKey:@"host"];
        }
        
        if(paramsDic[@"getDate"] || blockSelf.needResponseDate) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            [blockSelf loadResponseDate:model response:httpResponse];
        }
        
        if (error) {
            [model parsingError:error];
        }else {
            NSString *resultStr= [NSString stringWithContentsOfURL:location encoding:NSUTF8StringEncoding error:&error];
            //NSCAssert(!resultStr, @"没有解析成数据");
            if (!resultStr) {
                NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
                resultStr = [NSString stringWithContentsOfURL:location encoding:enc error:&error];
                if (model.debug&&resultStr) {
                    DGHttpLog(@"返回头是GBK编码");
                }
            }
            [model parsingResult:resultStr];
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (model.debug) {
                [[DGHttpRequestRecord getInstance]insertRequestDataWithService:paramsDic[@"service"] requestUrl:tempUrl.absoluteString parameters:paraString];
            }
            if (model.resultDic) {
                NSString *tempStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:model.resultDic options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
                DGHttpLog(@"%@\n%@",model.requestStr,tempStr);
            }else{
                DGHttpLog(@"%@\n%@",model.requestStr,model.resultStr);
            }
            
            NSArray *keyNames = [blockSelf.logicBlockMutDic allKeys];
            for (NSString *name in keyNames) {
                DGHttpResponseLogicModel *logicModel = blockSelf.logicBlockMutDic[name];
                if (logicModel.logicPathArr.count > 0) {
                    [blockSelf reponseLogicPassed:logicModel result:model.resultDic index:0];
                    //使用更新后的数据
                    DGHttpResponseLogicModel *newModel=blockSelf.logicBlockMutDic[logicModel.logicNameStr];
                    if (newModel.logicPassed) {
                        newModel.logicBlock(model.resultDic);
                        if (newModel.logicPassStop) {
                            return ;
                        }
                    }
                }
            }
            executorDelegate.completionHandler(model.errorMsgStr, model);
        });
    }];
    
    
    [downTask resume];
}


#pragma mark request
/** 创建request */
- (NSURLRequest *)requestWithUrl:(NSURL *)url andParamters:(NSString *)paramsString andType:(int)type{
    
    //1.创建request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    request.URL = url;
    
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

#pragma mark - tool
/** 获取httpResponse的时间 */
- (void)loadResponseDate:(DGHttpResponseModel *)model response:(NSHTTPURLResponse *)httpResponse{
    //1.获取date
    NSString *date = [[httpResponse allHeaderFields] objectForKey:@"Date"];
    //2.截取
    date = [date substringFromIndex:5];
    date = [date substringToIndex:[date length]-4];
    //3.格式化
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init]; formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setDateFormat:model.responseDateFormatStr];
    
    NSDate *netDate = [[formatter dateFromString:date] dateByAddingTimeInterval:60*60*8];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: netDate];
    NSDate *localeDate = [netDate dateByAddingTimeInterval: interval];
    model.responseDate = localeDate;
}

- (void)reponseLogicPassed:(DGHttpResponseLogicModel *)model result:(id)result index:(int)index{
    if (!result) {
        return;
    }
    model.logicPassed=0;
    if ([result isKindOfClass:[NSString class]]||
        [result isKindOfClass:[NSNumber class]]) {
        if ([result isKindOfClass:[NSNumber class]]) {
            result = [NSString stringWithFormat:@"%@",result];
        }
        if (model.logicEqualStr) {
            if ([result isEqualToString:model.logicEqualStr]) {//字段相等 通过
                model.logicPassed=1;
            }else{
                model.logicPassed=0;
            }
        }else{//有这个字段 通过
            model.logicPassed=1;
        }
        [_logicBlockMutDic setObject:model forKey:model.logicNameStr];
        return;
    }
    if (index>=model.logicPathArr.count) {
        NSCAssert(index<model.logicPathArr.count, @"该路径下不是一个字段");
        return;
    }
    [self reponseLogicPassed:model result:result[model.logicPathArr[index]] index:index+1];
}

@end
