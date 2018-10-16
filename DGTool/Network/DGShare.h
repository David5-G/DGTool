//
//  DGShare.h
//  DGTool
//
//  Created by david on 2018/10/9.
//  Copyright © 2018 david. All rights reserved.
//

#ifdef DEBUG
#   define DGHttpLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DGHttpLog(...)
#endif


#import <Foundation/Foundation.h>

@interface DGShare : NSObject

/** 快速打印 */
NSString *dg_str(NSString *format, ...);

@end
