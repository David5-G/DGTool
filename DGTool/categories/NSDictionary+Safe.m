//
//  NSDictionary+Safe.m
//  DGTool
//
//  Created by david on 2018/10/9.
//  Copyright © 2018 david. All rights reserved.
//

#import "NSDictionary+Safe.h"

@implementation NSDictionary (Safe)

- (id)safe_objectForKey:(id<NSCopying>)aKey
{
    if (aKey) {
        return [self objectForKey:aKey];
    }
    
    return nil;
}

@end
