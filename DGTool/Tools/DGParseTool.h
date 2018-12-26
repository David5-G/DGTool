//
//  DGParseTool.h
//  DGTool
//
//  Created by david on 2018/10/9.
//  Copyright © 2018 david. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DGParseTool : NSObject



/** 默认definedKey=key_map */
+ (nonnull NSMutableArray *)addMapToArr:(nonnull NSMutableArray *)mArr forKey:(nonnull NSString *)key map:(nonnull NSDictionary *)map;

/** 向dicArray里边 添加构建出来的key-value对
 * mArr :  需要加键值对的目标,mArr里边元素是dic
 * key :   dic元素的key,用此key对应的value作为key,去获取map对应的value
 * map :   原料map
 * definedKey: 新构建键值对,自定义的key
 
 * mArr = @[@{id:001, name:aaa},@{id: 002, name:bbb}];
 * map = @{001: 18岁, 002: 20岁}
 * 这里的key=id, 假定definedKey=age
 * 结果:resultArr = @[@{id:001, name:aaa, age:18岁},@{idStr: 002, name:bbb, age:20岁}];
 */
+ (NSMutableArray *)addMapToArr:(nonnull NSMutableArray *)mArr forKey:(nonnull NSString *)key map:(nonnull NSDictionary *)map definedKey:(nonnull NSString *)definedKey;



/** 向dicArray里边 添加构建出来的key-value对
 * mArr : 需要加键值对的目标,mArr里边元素是dic
 * key : dic元素的key,要拼接到prefix后边的str
 * prefix :  前缀
 * definedKey: 新构建键值对,自定义的key
 
 * mArr = @[@{id:001, name:aaa},@{id: 002, name:bbb}];
 * prefix = @"http://xxx.resource?userId="
 * 这里的key=userId, 假定definedKey=userLogoUrl
 * 结果:resultArr = @[@{id:001, name:aaa, userLogoUrl:http://xxx.resource?userId=001},@{idStr: 002, name:bbb, userLogoUrl:http://xxx.resource?userId=002}];
 */
+ (nonnull NSMutableArray *)addKeyValueToArr:(nonnull NSMutableArray *)mArr forKey:(nonnull NSString *)key prefix:(nonnull NSString *)prefix definedKey:(nonnull NSString *)definedKey;


+ (nonnull NSMutableArray *)addBoolValueToArr:(nonnull NSMutableArray *)mArr forKey:(nonnull NSString *)key judgeArr:(nonnull NSArray *)judgeArr definedKey:(nonnull NSString *)definedKey;

@end
