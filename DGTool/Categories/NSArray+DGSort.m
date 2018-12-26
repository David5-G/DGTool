//
//  NSArray+DGSort.m
//  DGTool
//
//  Created by david on 2018/12/26.
//  Copyright © 2018 david. All rights reserved.
//

#import "NSArray+DGSort.h"

@implementation NSArray (DGSort)

+ (NSString *)getDepthStr:(id)value depthArr:(NSArray *)depthArr index:(int)index{
    if (index>=depthArr.count) {
        return value;
    }
    value=value[depthArr[index]];
    index++;
    return [self getDepthStr:value depthArr:depthArr index:index];
}

+ (NSMutableArray *)sortChineseArr:(NSMutableArray *)sortMutArr depthArr:(NSArray *)depthArr{
    NSMutableDictionary *mutDic=[[NSMutableDictionary alloc]init];
    NSMutableArray *englishMutArr=[[NSMutableArray alloc]init];
    for (int i=0; i<sortMutArr.count; i++) {
        NSMutableString *ms;
        if (depthArr.count==0) {
            ms = [[NSMutableString alloc]initWithString:sortMutArr[i]];
        }else{
            ms = [[NSMutableString alloc]initWithString:[self getDepthStr:sortMutArr[i] depthArr:depthArr index:0]];
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0,kCFStringTransformMandarinLatin, NO)) {
            //            NSLog(@"pinyin: ---- %@", ms);
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0,kCFStringTransformStripDiacritics, NO)) {
            NSString *bigStr = [ms uppercaseString];
            [englishMutArr addObject:bigStr];
            [mutDic setObject:sortMutArr[i] forKey:bigStr];
        }
    }
    
    NSArray *resultkArrSort = [englishMutArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSMutableArray *newArr=[[NSMutableArray alloc]init];
    for (int i=0; i<resultkArrSort.count; i++) {
        [newArr addObject:mutDic[resultkArrSort[i]]];
    }
    return newArr;
}

@end
