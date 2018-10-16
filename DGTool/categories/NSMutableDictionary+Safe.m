//
//  NSMutableDictionary+Safe.m
//  DGTool
//
//  Created by david on 2018/10/10.
//  Copyright © 2018 david. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"

@implementation NSMutableDictionary (Safe)

- (void)safe_setObject:(id)anObject forKey:(id<NSCopying>)aKey{
    
    if (!aKey) {
        return;
    }
    if (!anObject) {
        [self removeObjectForKey:aKey];
        return;
    }
    [self setObject:anObject forKey:aKey];
}


- (void)safe_removeObjectForKey:(id<NSCopying>)aKey{
    
    if (aKey) {
        [self removeObjectForKey:aKey];
    }
}

@end
