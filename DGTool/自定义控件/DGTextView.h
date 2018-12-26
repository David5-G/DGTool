//
//  DGTextView.h
//  
//
//  Created by David.G on 16/7/20.
//  Copyright © 2016年 david. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DGTextView : UITextView

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;

//放出来给外界调用, 因为设置attributeText的富文本,不会触发UITextViewTextDidChangeNotification
-(void)textChanged:(NSNotification*)notification;

/** 设置InputAccessoryView, 用于点击"完成"撤销键盘 */
-(void)setDoneInputAccessoryView;

@end
