//
//  DGScannerTool.h
//  DGTool
//
//  Created by david on 2018/10/12.
//  Copyright © 2018 david. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DGScannerTool : NSObject

/** scanner扫描 由16进制str获取UIColor */
+ (UIColor *)dg_scannerColorwithHexString:(NSString *)colorStr;

/** scanner扫描 截取str */
+ (NSString*)dg_scannerStrWithContentStr:(NSString*)contentStr start:(NSString *)startStr end:(NSString *)endStr needStartEnd:(BOOL)needStartEnd;

@end
