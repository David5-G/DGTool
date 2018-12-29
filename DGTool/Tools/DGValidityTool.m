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

/** 纯字母 */
+ (BOOL)isPureLetter:(NSString *)str {
    if (str.length == 0) return NO;
    NSString *regex =@"[a-zA-Z]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:str];
}

@end
