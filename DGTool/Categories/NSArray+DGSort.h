//
//  NSArray+DGSort.h
//  DGTool
//
//  Created by david on 2018/12/26.
//  Copyright © 2018 david. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (DGSort)

/**
 *  中文的排序
 *  proMutArr 需要排序的数组
 *  depthArr 字典深度的路径数组
 *  如排序一层中文 如@[@"张三",@"李四"];
 depthArr=nil;
 *  如排序嵌套字典的数组 如@[@{@"name":@"张三",@"id":@"xxx"},@{@"name":@"李四",@"id":@"xxx"}];
 depthArr=@[@"name"];
 */
+ (NSMutableArray *)sortChineseArr:(NSMutableArray *)sortMutArr depthArr:(NSArray *)depthArr;

@end

NS_ASSUME_NONNULL_END
