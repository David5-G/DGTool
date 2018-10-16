//
//  DGScannerTool.m
//  DGTool
//
//  Created by david on 2018/10/12.
//  Copyright © 2018 david. All rights reserved.
//

#import "DGScannerTool.h"

@implementation DGScannerTool

/** scanner扫描 由16进制str获取UIColor */
+ (UIColor *)dg_scannerColorwithHexString:(NSString *)colorStr {
    
    //1.处理
    NSString *cString = [colorStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    cString = [cString uppercaseString];
    
    //2. 过滤不符长度
    if (cString.length < 6 || cString.length > 8) {
        return [UIColor clearColor];
    }
    
    //3. strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])  cString = [cString substringFromIndex:1];
    if ([cString length] != 6)     return [UIColor clearColor];
    
    //4. Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    //5. Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    //6.return
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

/** scanner扫描 截取str */
+ (NSString *)dg_scannerStrWithContentStr:(NSString *)contentStr start:(NSString *)startStr end:(NSString *)endStr needStartEnd:(BOOL)needStartEnd {
    
    //1.扫描
    NSScanner *scanner = [NSScanner scannerWithString:contentStr];
    NSString *resultStr = nil;
    while ([scanner isAtEnd] == NO) {
        [scanner scanUpToString:startStr intoString:NULL] ;
        [scanner scanUpToString:endStr intoString:&resultStr] ;
    }
    
    //2. 是否需要startStr和endStr
    if (needStartEnd) {
        resultStr = [resultStr stringByAppendingString:endStr];
    }else{
        resultStr = [resultStr stringByReplacingOccurrencesOfString:startStr withString:@""];
    }
    
    //3.return
    return resultStr;
}

@end
