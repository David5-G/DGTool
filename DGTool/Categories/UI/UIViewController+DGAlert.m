//
//  UIViewController+DGAlert.m
//  DGTool
//
//  Created by david on 2018/12/26.
//  Copyright © 2018 david. All rights reserved.
//

#import "UIViewController+DGAlert.h"
#import <objc/message.h>

static const char *associatedAlertKey = "associatedAlertKey";

@implementation UIViewController (DGAlert)

#pragma mark - 关联对象
-(void)setAssociatedAlert:(UIAlertController *)alert{
    objc_setAssociatedObject(self, associatedAlertKey, alert, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id)associatedAlert {
    UIAlertController *alert = objc_getAssociatedObject(self, associatedAlertKey);
    return alert;
}


#pragma mark - 警告框 提醒
-(void)dg_alertWithTitle:(NSString *)title message:(NSString *)message{
    [self dg_alertWithTitle:title message:message duration:1.0f];
}

/** 显示警告框 */
-(void)dg_alertWithTitle:(NSString *)title message:(NSString *)message duration:(float)duration{
    //1.创建AlertController
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    //设置关联对象
    [self setAssociatedAlert:alert];
    
    
    if(title.length){
        NSMutableAttributedString *attributedTitleStr = [[NSMutableAttributedString alloc] initWithString:title];
        [attributedTitleStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(0, title.length)];
        [alert setValue:attributedTitleStr forKey:@"attributedTitle"];
    }
    
    if (message.length) {
        NSMutableAttributedString *attributedMsgStr = [[NSMutableAttributedString alloc] initWithString:message];
        [attributedMsgStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, message.length)];
        [alert setValue:attributedMsgStr forKey:@"attributedMessage"];
    }
    
    //2.显示AlertController
    [self presentViewController:alert animated:YES completion:nil];
    
    //3.定时收起警告框
    [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(performDismiss) userInfo:nil repeats:NO];
}

/** 收起警告框 */
-(void) performDismiss{
    UIAlertController *alert = [self associatedAlert];
    [alert dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 警告框 操作
-(void)dg_alert:(UIAlertControllerStyle)style Title:(NSString *)title message:(NSString *)message actions:(NSArray<UIAlertAction *> *)actions{
    
    [self dg_alert:style Title:title titleFontSize:17.0 message:message messageFontSize:15 actions:actions];
}

-(void)dg_alert:(UIAlertControllerStyle)style Title:(NSString *)title titleFontSize:(float)titleFontSize message:(NSString *)message messageFontSize:(float)messageFontSize actions:(NSArray<UIAlertAction *> *)actions{
    //1.创建AlertController
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    //title
    if(title.length){
        NSMutableAttributedString *attributedTitleStr = [[NSMutableAttributedString alloc] initWithString:title];
        [attributedTitleStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:titleFontSize] range:NSMakeRange(0, title.length)];
        [alert setValue:attributedTitleStr forKey:@"attributedTitle"];
    }
    //message
    if (message.length) {
        NSMutableAttributedString *attributedMsgStr = [[NSMutableAttributedString alloc] initWithString:message];
        [attributedMsgStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:messageFontSize] range:NSMakeRange(0, message.length)];
        [alert setValue:attributedMsgStr forKey:@"attributedMessage"];
    }
    
    //2.添加action
    for (NSInteger i=0; i<actions.count; i++) {
        [alert addAction:actions[i]];
    }
    
    //3.显示AlertController
    [self presentViewController:alert animated:YES completion:nil];
}

@end
