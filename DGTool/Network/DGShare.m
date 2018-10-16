//
//  DGShare.m
//  DGTool
//
//  Created by david on 2018/10/9.
//  Copyright © 2018 david. All rights reserved.
//

#import "DGShare.h"

@implementation DGShare

NSString *dg_str(NSString *format, ...){
    
    /*
     * 函数参数的传递原理
    　　函数参数是以数据结构:栈的形式存取,从右至左入栈。
    　　首先是参数的内存存放格式：参数存放在内存的堆栈段中，在执行函数的时候，从最后一个开始入栈。因此栈底高地址，栈顶低地址
     例:void func(int x, float y, char z);
        调用函数的时候，实参char z先进栈，然后是float y，最后是int x，因此在内存中变量的存放次序是 x->y->z。
    */
    va_list ap;// 申请参数列表变量
    va_start (ap, format);//初始化ap变量, 申明最后一个传递给函数的已知的固定参数
    NSString *body = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end (ap);
    
    return body;
}

@end
