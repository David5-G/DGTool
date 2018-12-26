//
//  DGAlertController.h
//  DGTool
//
//  Created by david on 2018/10/29.
//  Copyright © 2018 david. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGAlertAction.h"

typedef enum : NSUInteger {
    DGAlertControllerStyleAlert,
    DGAlertControllerStyleActionSheet
} DGAlertControllerStyle;


@interface DGAlertController : UIViewController

/** init方法, ppActions是添加操作的数组 */
- (instancetype _Nonnull)initWithStyle:(DGAlertControllerStyle)style ppActions:(nonnull NSArray <DGAlertAction *>*)ppActions;

/** init方法, ppActions是添加操作的数组 */
- (instancetype _Nonnull)initWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message style:(DGAlertControllerStyle)style ppActions:(NSArray <DGAlertAction *>* _Nonnull)ppActions;

/** 触发touchesBegan方法时,是否dismiss本控制器 默认为YES */
@property (nonatomic,assign) BOOL touchDismissEnabled;
@end
