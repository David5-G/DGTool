//
//  DGValidityTool.m
//  DGTool
//
//  Created by david on 2018/12/29.
//  Copyright © 2018 david. All rights reserved.
//

#import "DGValidityTool.h"

@implementation DGValidityTool

/** 纯数字 */
+ (BOOL)isPureInt:(NSString *)str {
    NSScanner *scan = [NSScanner scannerWithString:str];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

/** 纯浮点数 */
+ (BOOL)isPureFloat:(NSString*)str {
    NSScanner* scan = [NSScanner scannerWithString:str];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

/** 纯字母 */
+ (BOOL)isPureLetter:(NSString *)str {
    if (str.length == 0){
        return NO;
    }
    NSString *regex =@"[a-zA-Z]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:str];
}

/** 纯中文 */
+ (BOOL)isPureChinese:(NSString *)str {
    if (str.length == 0) return NO;
    
    NSString *regex =@"[\u4e00-\u9fa5]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:str];
}

/** 有中文 */
+ (BOOL)hasChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

/** 只有字母和数字 */
+ (BOOL)isOnlyNumerAndLetter:(NSString *)str {
    NSString *regex = @"[a-zA-Z0-9][a-zA-Z0-9]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:str];
}

/** 只有数字字母和中文 */
+ (BOOL)isOnlyNumberWordChinese:(NSString *)str{
    NSString *regex = @"[a-zA-Z0-9\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:str];
}

#pragma mark - 
/** 手机号码验证*/
+ (BOOL)isValidMobile:(NSString *)str{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((12[0-9])|(13[0,0-9])|(14[0,0-9])|(15[0,0-9])|(16[0,0-9])|(17[0,0-9])|(18[0,0-9])|(19[0,0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [pred evaluateWithObject:str];
}


/** 邮箱*/
+ (BOOL)isValidEmail:(NSString *)str{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [pred evaluateWithObject:str];
}

/**
 背景
 于是去查询了相关资料
 这里我们只考虑二代身份证，即18位（15位的估计也没人用了）。
 新的二代公民身份号码是特征组合码，由十七位数字本体码和一位校验码组成。排列顺序从左至右依次为：六位数字地址码，八位数字出生日期码，三位数字顺序码和一位校验码。
 其含义如下：
 
 地址码：表示编码对象常住户口所在县(市、旗、区)的行政区划代码，按GB/T2260的规定执行。
 出生日期码：表示编码对象出生的年、月、日，按GB/T7408的规定执行，年、月、日分别用4位、2位、2位数字表示，之间不用分隔符。
 顺序码：表示在同一地址码所标识的区域范围内，对同年、同月、同日出生的人编定的顺序号，顺序码的奇数分配给男性，偶数分配给女性。
 校验码：这个是根据前17位，加权求和，对11求余，在对应得到相应的值。
 
 有了这个就简单多了，只要先用正则过滤一遍，在用校验码算法验证，基本就可以了。而且，有需要的话，甚至可以根据这个逆推出用户的出生日期，性别，地址。
 
 校验的计算方式：
 
 对前17位数字本体码加权求和
 
 公式为：S = Sum(Ai * Wi), i = 0, ... , 16。
 其中Ai表示第i位置上的身份证号码数字值，Wi表示第i位置上的加权因子
 其各位对应的值依次为： 7 9 10 5 8 4 2 1 6 3 7 9 10 5 8 4 2
 
 
 以11对计算结果取模
 Y = sum % 11
 根据模的值得到对应的校验码
 对应关系为：
 
 Y值:   0 1 2 3 4 5 6 7 8 9 10
 校验码: 1 0 X 9 8 7 6 5 4 3 2
 
 作者：adu443
 链接：https://www.jianshu.com/p/9405ced634ee
 */

/** 身份证 */
+ (BOOL)isValidateIdCard:(NSString *)str {
    
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //1.长度校验
    NSInteger length = str.length;
    if (!str
        || length < 1
        || length != 15
        || length != 18) {
        return NO;
    }
    
    //2.省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *start2Str = [str substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:start2Str]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return NO;
    }
    
    //3.格式校验
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    int year =0;
    
    //3.1 15位的身份证
    if(length == 15){
        year = [str substringWithRange:NSMakeRange(6,2)].intValue +1900;
        
        if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
            
            regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
        }else {
            regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
        }
        numberofMatch = [regularExpression numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
        
        // [regularExpression release];
        
        if(numberofMatch >0) {
            return YES;
        }else {
            return NO;
        }
    }
    
    //3.2 18位的身份证
    if(length == 18){
        year = [str substringWithRange:NSMakeRange(6,4)].intValue;
        if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
            
            regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"  options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
        }else {
            regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"  options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
        }
        numberofMatch = [regularExpression numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
        
        // [regularExpressionrelease];
        
        if (numberofMatch < 1) {
            return NO;
        }
        
        int S = ([str substringWithRange:NSMakeRange(0,1)].intValue + [str substringWithRange:NSMakeRange(10,1)].intValue) *7 +
        ([str substringWithRange:NSMakeRange(1,1)].intValue + [str substringWithRange:NSMakeRange(11,1)].intValue) *9 +
        ([str substringWithRange:NSMakeRange(2,1)].intValue + [str substringWithRange:NSMakeRange(12,1)].intValue) *10 +
        ([str substringWithRange:NSMakeRange(3,1)].intValue + [str substringWithRange:NSMakeRange(13,1)].intValue) *5 +
        ([str substringWithRange:NSMakeRange(4,1)].intValue + [str substringWithRange:NSMakeRange(14,1)].intValue) *8 +
        ([str substringWithRange:NSMakeRange(5,1)].intValue + [str substringWithRange:NSMakeRange(15,1)].intValue) *4 +
        ([str substringWithRange:NSMakeRange(6,1)].intValue + [str substringWithRange:NSMakeRange(16,1)].intValue) *2 +
        [str substringWithRange:NSMakeRange(7,1)].intValue *1 +
        [str substringWithRange:NSMakeRange(8,1)].intValue *6 +
        [str substringWithRange:NSMakeRange(9,1)].intValue *3;
        
        int Y = S %11;
        NSString *M =@"F";
        NSString *JYM =@"10X98765432";
        M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
        if ([M isEqualToString:[str substringWithRange:NSMakeRange(17,1)]]) {
            return YES;// 检测ID的校验位
        }else {
            return NO;
        }
        
    }
    
    //4.其余为NO
    return NO;
}


@end
