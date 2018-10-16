//
//  DGHttpResponseModel.m
//  DGTool
//
//  Created by david on 2018/10/9.
//  Copyright © 2018 david. All rights reserved.
//

#import "DGHttpResponseModel.h"

@implementation DGHttpResponseModel

- (instancetype)init{
    
    self = [super init];
    if (self) {
        _debug = 1;
        _responseDateFormatStr = @"dd MM yyyy HH:mm:ss";
    }
    return self;
}


@end
