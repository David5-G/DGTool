//
//  NSMutableDictionary+Safe.h
//  DGTool
//
//  Created by david on 2018/10/10.
//  Copyright © 2018 david. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Safe)

- (void)safe_setObject:(id)anObject forKey:(id<NSCopying>)aKey;

- (void)safe_removeObjectForKey:(id<NSCopying>)aKey;

@end
