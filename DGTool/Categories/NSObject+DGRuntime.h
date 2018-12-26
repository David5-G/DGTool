//
//  NSObject+DGRuntime.h
//  DGTool
//
//  Created by david on 2018/11/19.
//  Copyright © 2018 david. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (runtimeTool)

/** 获取对象的所有属性 @return属性数组 */
-(NSArray *)getAllProperties;

/** 获取所有属性及对应的值 */
-(NSDictionary *)getAllPropertiesAndValues;

/** 获取对象的所有方法 */
-(NSArray *)getAllMethods;

@end
