//
//  NSObject+runtimeTool.m
//  PaPa
//
//  Created by david on 2018/11/19.
//  Copyright © 2018 万耀辉. All rights reserved.
//

#import "NSObject+runtimeTool.h"
#import <objc/message.h>

@implementation NSObject (runtimeTool)

/** 获取所有属性及对应的值 */
-(NSDictionary *)getAllPropertiesAndValues {
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount;
    //属性的链表
    objc_property_t *properties =class_copyPropertyList([self class], &outCount);
    //遍历链表
    for (int i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        //获取属性字符串
        const char* propertyName =property_getName(property);
        //转换成NSString
        NSString *key = [NSString stringWithUTF8String:propertyName];
        //获取属性对应的value
        id value = [self valueForKey:key];
        if (value)
        {
            [props setObject:value forKey:key];
        }
    }
    //释放结构体数组内存
    free(properties);
    return props;
}

/**
 *  获取对象的所有属性
 *
 *  @return 属性数组
 */
- (NSArray *)getAllProperties {
    
    unsigned int count;
    //获取属性的链表
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
    {
        objc_property_t property = properties[i];
        const char* propertyName =property_getName(property);
        [propertiesArray addObject: [NSString stringWithUTF8String:propertyName]];
    }
    
    free(properties);
    
    return propertiesArray;
}

/**
 *  获取对象的所有方法
 */
-(NSArray *)getAllMethods {
    unsigned int count =0;
    //1,获取方法链表
    Method* methodList = class_copyMethodList([self class],&count);
    
    //2.创建储存method的数组
    NSMutableArray *methodsArray = [NSMutableArray arrayWithCapacity:count];
    
    //3.遍历获取方法名
    for(int i=0;i<count;i++) {
        Method method = methodList[i];
        //3.1方法的调用地址
        //IMP imp = method_getImplementation(method);
        
        //3.2 方法
        SEL sel = method_getName(method);
        
        //3.3 方法名字符串
        const char* name = sel_getName(sel);
        //方法的NSString字符串
        NSString *methodStr = NSStringFromSelector(sel);
        [methodsArray addObject:methodStr];
        
        //3.4参数数量
        int arguments = method_getNumberOfArguments(method);
        
        //3.5 返回方法的参数和返回值的描述的字串
        const char* encoding = method_getTypeEncoding(method);
        NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name],
              arguments,[NSString stringWithUTF8String:encoding]);
    }
    
    //4.释放
    free(methodList);
    
    //5.返回方法名Array
    return methodsArray;
}


@end
