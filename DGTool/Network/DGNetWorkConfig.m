//
//  DGNetWorkConfig.m
//  DGTool
//
//  Created by david on 2018/10/9.
//  Copyright © 2018 david. All rights reserved.
//

#import "DGNetWorkConfig.h"

static  NSString *develop_url = @"http://user-mapi.kuaitui.net/client/service.json?";
static NSString *product_url = @"http://mapi.njgreat88.com/client/service.json?";

/**
 0: 开发环境
 1: 生产环境
 */
static NSInteger url_choose = 1;

@implementation DGNetWorkConfig



/** 拼接域名 */
//+ (NSString *)getREQUEST{
//    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"Scope"] isKindOfClass:[NSDictionary class]]) {
//        NSDictionary *scopDic = [[NSUserDefaults standardUserDefaults]objectForKey:@"Scope"];
//        NSString *scopeStr = [NSString stringWithFormat:@"http://%@/client/service.json?",scopDic[@"KT_USER"]];
//        
//        [CC_HttpTask getInstance].scopeIp = scopDic[@"IP"];
//        return scopeStr;
//    }
//    return nil;
//}


@end
