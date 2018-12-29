//
//  DGValidityTool.h
//  DGTool
//
//  Created by david on 2018/12/29.
//  Copyright © 2018 david. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DGValidityTool : NSObject

+ (BOOL)isOnlyNumerAndLetter:(NSString *)textStr;
+ (BOOL)isOnlyChinese:(NSString *)textStr;


/** 纯数字 */
+ (BOOL)isPureInt:(NSString *)str;

/** 纯字母 */
+ (BOOL)isPureLetter:(NSString *)str;

/** 只有数字字母和中文 */
+ (BOOL)isMatchNumberWordChinese:(NSString *)str;

/** 有中文 */
+ (BOOL)hasChinese:(NSString *)str;

/** 手机号码验证*/
+ (BOOL)validateMobile:(NSString *)mobileStr;
/** 邮箱*/
+ (BOOL)validateEmail:(NSString *)emailStr;

@end

NS_ASSUME_NONNULL_END
