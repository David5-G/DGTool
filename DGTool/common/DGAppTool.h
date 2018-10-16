//
//  DGAppTool.h
//  DGTool
//
//  Created by david on 2018/10/9.
//  Copyright © 2018 david. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DGAppTool : NSObject

/** 获取Bundle字典 */
+ (NSDictionary *)getBundle;

/** 获取CFBundleIdentifier */
+ (NSString *)getBundleId;

/** 获取CFBundleShortVersionString */
+ (NSString *)getVersion;

@end
