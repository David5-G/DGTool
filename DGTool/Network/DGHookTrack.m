//
//  DGHookTrack.m
//  DGTool
//
//  Created by david on 2018/10/10.
//  Copyright © 2018 david. All rights reserved.
//

#import "DGHookTrack.h"
#import "DGScannerTool.h"
#import "DGShare.h"

@implementation DGHookTrack

static DGHookTrack *userManager=nil;
static dispatch_once_t onceToken;

/** 获取单例对象 */
+ (instancetype)getInstance{
    dispatch_once(&onceToken, ^{
        userManager=[[DGHookTrack alloc]init];
    });
    return userManager;
}

/** 发起track */
+ (void)catchTrack{
    NSInteger max = 5;
    NSInteger count = [NSThread callStackSymbols].count;
    if (count<max) {
        max=count;
    }
    NSString *actionStr;
    if (max > 3) {
        for (NSInteger i=max-1; i>2; i--) {
            
            NSString *callStackStr = [DGScannerTool dg_scannerStrWithContentStr:[NSThread callStackSymbols][i] start:@"[" end:@"]" needStartEnd:YES];
            
            actionStr = dg_str(@"%@%@-",actionStr?actionStr:@"",callStackStr);
        }
        
        if ([DGHookTrack getInstance].debug) {
            DGHttpLog(@"###%@###", actionStr);
        }
    }
    [DGHookTrack getInstance].triggerActionStr = actionStr;
}


/** track willPushTo */
+ (void)willPushTo:(NSString *)toVC{
    NSString *actionStr = [NSString stringWithFormat:@"%@-%@-%@",[DGHookTrack getInstance].currentVCStr,@"popTo",toVC];
    
    if ([DGHookTrack getInstance].debug) {
        DGHttpLog(@"###%@###", actionStr);
    }
    [DGHookTrack getInstance].prePushActionStr = actionStr;
}


/** track willPopOfIndex */
+ (void)willPopOfIndex:(int)index {
    
    NSUInteger count = [DGHookTrack getInstance].lastVCs.count;
    NSString *popToVC = [DGHookTrack getInstance].lastVCs[count-index-1];
    
    NSString *actionStr = [NSString stringWithFormat:@"%@-%@-%@",[DGHookTrack getInstance].currentVCStr,@"popTo",popToVC];
    
    if ([DGHookTrack getInstance].debug) {
        DGHttpLog(@"###%@###", actionStr);
    }
    [DGHookTrack getInstance].prePopActionStr = actionStr;
}



@end
