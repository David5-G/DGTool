//
//  NSDictionary+DGSafe.h
//  DGTool
//
//  Created by david on 2018/10/9.
//  Copyright © 2018 david. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Safe)

- (id)safe_objectForKey:(id<NSCopying>)aKey;

@end
