//
//  DGHttpRequestRecord.m
//  DGTool
//
//  Created by david on 2018/10/23.
//  Copyright © 2018 david. All rights reserved.
//

#import "DGHttpRequestRecord.h"

#define kParamsKey       @"parameters"
#define kRequestUrlKey   @"requestUrl"

@interface DGHttpRequestRecord()

@property (nonatomic,strong) NSString *plistPath;

@end

@implementation DGHttpRequestRecord

#pragma mark - lazy load
/** plist的路径 */
- (NSString *)plistPath {
    
    if (!_plistPath) {
        BOOL isDir = NO;
        //1. temp路径
        NSString * docDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *dataFilePath = [docDir stringByAppendingPathComponent:@"requestRecod"];
        
        //2. 创建文件夹
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL existed = [fileManager fileExistsAtPath:dataFilePath isDirectory:&isDir];
        
        if (!(isDir && existed)) {
            [fileManager createDirectoryAtPath:dataFilePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        //3. 获取plist路径
        _plistPath = [dataFilePath stringByAppendingPathComponent:@"record.plist"];
    }
    
    return _plistPath;
}

#pragma mark - init
+ (instancetype)getInstance{
    static DGHttpRequestRecord *record = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        record = [[DGHttpRequestRecord alloc]init];
    });
    return record;
}

#pragma mark - method
- (BOOL)insertRequestDataWithService:(NSString *)service requestUrl:(NSString *)requestUrl parameters:(NSString *)parameters{
    
    BOOL isSuccess = NO;
    //1.获取plist文件对应的recordDic
    NSString *plistPath = self.plistPath;
    NSMutableDictionary *recordDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    if (recordDic == nil) {
        recordDic = [[NSMutableDictionary alloc]init];
    }
    //2.记录到recordDic
    if (service.length > 0) {
        [recordDic setObject:@{kRequestUrlKey:requestUrl, kParamsKey:parameters} forKey:service];
    }else{
        [recordDic setObject:@{kRequestUrlKey:requestUrl, kParamsKey:parameters} forKey:requestUrl];
    }
 
    //3. 将recordDic写入文件
    isSuccess = [recordDic writeToFile:plistPath atomically:YES];
    
    //4. ruturn
    return isSuccess;
}

/** 获取所有params */
- (NSString *)totalParameters{

    //1.获取plist文件对应的recordDic
    NSMutableDictionary *recordDic = [[NSMutableDictionary alloc] initWithContentsOfFile:self.plistPath];
    
    //2.过滤
    if (!recordDic) {
        return nil;
    }
    //3.获取param
    NSString * resultStr = @"";
    for (NSDictionary * dic in recordDic.allValues) {
        NSString *aStr = [NSString stringWithFormat:@";%@", dic[kParamsKey]];
        resultStr = [resultStr stringByAppendingString:aStr];
    }
    resultStr = [resultStr substringFromIndex:1];
    
    //4.return
    return resultStr;
}



/** 获取所有totalStr */
-(NSString *)getTotalStr{
    
    NSMutableDictionary *usersDic = [[NSMutableDictionary alloc] initWithContentsOfFile:self.plistPath];
    if (!usersDic) {
        return nil;
    }
    NSString * paraStr = @"";
    for (NSDictionary * dic in usersDic.allValues) {
        NSString *urlS=dic[@"requestUrl"];
        if (![urlS hasSuffix:@"?"]) {
            urlS=[urlS stringByAppendingString:@"?"];
        }
        paraStr = [paraStr stringByAppendingString:[NSString stringWithFormat:@";%@%@",urlS,dic[@"parameters"]]];
    }
    paraStr = [paraStr substringFromIndex:1];
    return paraStr;
}

@end
