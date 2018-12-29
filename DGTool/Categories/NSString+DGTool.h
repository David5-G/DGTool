//
//  NSString+DGTool.h
//  DGTool
//
//  Created by david on 2018/12/27.
//  Copyright © 2018 david. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (DGTool)


#pragma mark - time
/** 两个日期 是否是同一天
 * 适用时间格式: 2018-11-20 18:00:00
 */
+ (BOOL)isTheSameDay:(NSString *)timeStr1 timeStr2:(NSString *)timeStr2;


#pragma mark - attributedStr
/**
 创建attributed字符串
 spaceStr: 中间间隔, 起空格填充作用
 */
+ (NSMutableAttributedString *)attributedStrWithContent:(NSString *)content color:(UIColor *)color fontSize:(CGFloat)fontSize spaceStr:(NSString *)spaceStr suffixStr:(NSString *)sStr suffixColor:(UIColor *)sColor suffixFontSize:(CGFloat)sFontSize;


#pragma mark - 尺寸
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

#pragma mark - 字符长度
- (NSUInteger)includChineseCharacterLength;
- (NSUInteger)includChineseCharacterLength2;

#pragma mark - 汉字转拼音
/** 将汉字转换成拼音 */
+ (NSString *)convertChineseStrToPhoneticizeStr:(NSString *)cStr;

/** 截取汉字的拼音首字母 */
+ (NSString *)extractFirstLetterWithChineseStr:(NSString *)cStr;

@end

