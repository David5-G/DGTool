//
//  DGAlertAction.m
//  DGTool
//
//  Created by david on 2018/10/29.
//  Copyright © 2018 david. All rights reserved.
//

#import "DGAlertAction.h"
@interface DGAlertAction ()
@property (nullable, nonatomic,copy) NSString *title;
@property (nonatomic) DGAlertActionStyle style;
@property (nonatomic,copy) DGAlertActionHandler handler;
@end


@implementation DGAlertAction

+ (instancetype _Nonnull )ppActionCancel{
    return [self ppActionWithTitle:@"取消" style:DGAlertActionStyleCancel handler:nil];
}

+ (instancetype)ppActionWithTitle:(nonnull NSString *)title style:(DGAlertActionStyle)style handler:(DGAlertActionHandler)handler {
    
    DGAlertAction *ppAction = [[DGAlertAction alloc] init];
    if (ppAction) {
        ppAction.title = title;
        ppAction.style = style;
        ppAction.handler = handler;
    }
    return ppAction;
}

@end
