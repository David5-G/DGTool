//
//  NSString+DGTool.m
//  DGTool
//
//  Created by david on 2018/12/27.
//  Copyright © 2018 david. All rights reserved.
//

#import "NSString+DGTool.h"

@implementation NSString (DGTool)


#pragma mark - time
/** 两个日期 是否是同一天
 * 适用时间格式: 2018-11-20 18:00:00
 */
+ (BOOL)isTheSameDay:(NSString *)timeStr1 timeStr2:(NSString *)timeStr2 {
    NSRange judgeRange = NSMakeRange(0, 10);
    timeStr1 = [timeStr1 substringWithRange:judgeRange];
    timeStr2 = [timeStr2 substringWithRange:judgeRange];
    return [timeStr1 isEqualToString:timeStr2];
}

#pragma mark - attributedStr
+ (NSMutableAttributedString *)attributedStrWithContent:(NSString *)content color:(UIColor *)color fontSize:(CGFloat)fontSize spaceStr:(NSString *)spaceStr suffixStr:(NSString *)sStr suffixColor:(UIColor *)sColor suffixFontSize:(CGFloat)sFontSize {
    
    //1.创建aStr
    NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@",content,spaceStr,sStr]];
    
    //2.1 content内容
    [aStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0,content.length)];
    [aStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0,content.length)];
    
    //2.2 space间隔
    [aStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(content.length,spaceStr.length)];
    
    //2.3 suffix后缀
    NSRange sRange = NSMakeRange(content.length+spaceStr.length,sStr.length);
    [aStr addAttribute:NSForegroundColorAttributeName value:sColor range:sRange];
    [aStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:sFontSize] range:sRange];
    
    //3.return
    return aStr;
}

#pragma mark - 尺寸
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize textSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return textSize;
}


#pragma mark - 字符长度
/** 中英文混合字符串长度 方法1 */
- (NSUInteger)includChineseCharacterLength {
    NSUInteger strLength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    
    NSUInteger totalLength = [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<totalLength ;i++) {
        if (*p) {
            p++;
            strLength++;
            
        }else {
            p++;
        }
    }
    
    return strLength;
}

/** 中英文混合字符串长度 方法2 */
- (NSUInteger)includChineseCharacterLength2 {
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [self dataUsingEncoding:enc];
    return [da length];
}


#pragma mark - 汉字转拼音
/** 将汉字转换成拼音 */
+ (NSString *)convertChineseStrToPhoneticizeStr:(NSString *)cStr {
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:cStr];
    
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL,kCFStringTransformMandarinLatin,NO);
    
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL,kCFStringTransformStripDiacritics,NO);
    
    //转化为大写拼音
    NSString *pStr = [str capitalizedString];
    
    //获取并返回首字母
    return pStr;
}

/** 截取汉字的拼音首字母 */
+ (NSString *)extractFirstLetterWithChineseStr:(NSString *)cStr{
    
    NSString * pStr = [self convertChineseStrToPhoneticizeStr:cStr];
    
    if(pStr.length > 0){
        return [pStr substringWithRange:NSMakeRange(0, 1)];
    }
    
    return nil;
}


@end
