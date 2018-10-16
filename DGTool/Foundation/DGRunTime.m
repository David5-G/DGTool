//
//  DGRunTime.m
//  DGTool
//
//  Created by david on 2018/10/9.
//  Copyright © 2018 david. All rights reserved.
//

#import "DGRunTime.h"
#import<objc/runtime.h>

@implementation DGRunTime
/* 获取对象的所有属性 */
-(NSArray *)getAllProperties:(id)objc {
    u_int count;
    // 传递count的地址过去 &count
    objc_property_t *properties  =class_copyPropertyList([objc class], &count);
    
    //arrayWithCapacity的效率稍微高那么一丢丢
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++){
        //此刻得到的propertyName为c语言的字符串
        const char* propertyName =property_getName(properties[i]);
        
        //此步骤把c语言的字符串转换为OC的NSString
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
        
        NSLog(@"-- %@",[NSString stringWithUTF8String: propertyName]);
    }
    //class_copyPropertyList底层为C语言，所以我们一定要记得释放properties
    // You must free the array with free().
    free(properties);
    
    return [propertiesArray copy];
}

@end
