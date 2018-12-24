//
//  DGHttpRequestRecord.h
//  DGTool
//
//  Created by david on 2018/10/23.
//  Copyright © 2018 david. All rights reserved.
//

#import <Foundation/Foundation.h>

//此类作用: 记录网络请求的 URL、Response
@interface DGHttpRequestRecord : NSObject

@property (nonatomic,copy) NSArray *paramsArr;

+ (instancetype)getInstance;


/**
 插入请求数据
 
 @param service 请求的域名
 @param requestUrl 请求URL地址
 @param parameters 请求参数
 @return 是否记录成功
 */
- (BOOL)insertRequestDataWithService:(NSString *)service requestUrl:(NSString *)requestUrl parameters:(NSString *)parameters;

/** 获取摸个service对应的requestUrlStr */
- (NSString *)fullRequestUrlStrWithService:(NSString *)service;


@end
