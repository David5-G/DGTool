//
//  DGAlertAction.h
//  DGTool
//
//  Created by david on 2018/10/29.
//  Copyright © 2018 david. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum: NSUInteger {
    DGAlertActionStyleDefault,
    DGAlertActionStyleCancel,
    DGAlertActionStyleConfirm,//红色字体
}DGAlertActionStyle;

@class DGAlertAction;
typedef void(^DGAlertActionHandler)(DGAlertAction * _Nullable ppAction);

@interface DGAlertAction : NSObject

+ (instancetype _Nonnull )ppActionCancel;

+ (instancetype _Nonnull )ppActionWithTitle:(nonnull NSString *)title style:(DGAlertActionStyle)style handler:(DGAlertActionHandler _Nullable )handler;

@property (nullable, nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) DGAlertActionStyle style;
@property (nonatomic, getter=isEnabled) BOOL enabled;

@property (nonatomic,copy,readonly) DGAlertActionHandler _Nullable handler;

@end
