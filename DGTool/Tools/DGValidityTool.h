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


/** 纯数字 */
+ (BOOL)isPureInt:(NSString *)str;

/** 纯浮点数 */
+ (BOOL)isPureFloat:(NSString*)str;

/** 纯字母 */
+ (BOOL)isPureLetter:(NSString *)str;

/** 纯中文 */
+ (BOOL)isPureChinese:(NSString *)textStr;

/** 有中文 */
+ (BOOL)hasChinese:(NSString *)str;

/** 只有字母和数字 */
+ (BOOL)isOnlyNumerAndLetter:(NSString *)textStr;

/** 只有数字字母和中文 */
+ (BOOL)isOnlyNumberWordChinese:(NSString *)str;



#pragma mark - 有效性
/** 手机号码验证*/
+ (BOOL)isValidMobile:(NSString *)str;

/** 邮箱*/
+ (BOOL)isValidEmail:(NSString *)str;

/** 身份证 */
+ (BOOL)isValidateIdCard:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
