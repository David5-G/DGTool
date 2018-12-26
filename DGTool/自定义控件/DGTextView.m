//
//  DGTextView.m
//  
//
//  Created by David.G on 16/7/20.
//  Copyright © 2016年 david. All rights reserved.
//

#import "DGTextView.h"

#define kLightGrayTextColor  [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1]
#define kScreenW ([UIScreen mainScreen].bounds.size.width)

@interface DGTextView ()
@property (nonatomic, strong) UILabel *placeHolderLabel;
@end

@implementation DGTextView

static CGFloat const DGTextViewDuration = 0.2;

#pragma mark - lazy load
-(UILabel *)placeHolderLabel {
    if (!_placeHolderLabel) {
        _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,8,self.bounds.size.width,10)];
        _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _placeHolderLabel.numberOfLines =0;
        _placeHolderLabel.font = self.font;
        _placeHolderLabel.backgroundColor = [UIColor clearColor];
        _placeHolderLabel.textColor = kLightGrayTextColor;
        _placeHolderLabel.alpha = 0;
    }
    return _placeHolderLabel;
}

#pragma mark - life circle

- (void)awakeFromNib{
    [super awakeFromNib];
    if (!self.placeholder) {
        [self setPlaceholder:@""];
    }
    if (!self.placeholderColor) {
        [self setPlaceholderColor:kLightGrayTextColor];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 2;// 字体的行间距
        NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle };
        self.typingAttributes = attributes;
        [self setPlaceholder:@""];
        [self setPlaceholderColor:kLightGrayTextColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

#pragma mark - UI
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if( [[self placeholder] length] > 0 ){
        [self addSubview:self.placeHolderLabel];
        [self.placeHolderLabel sizeToFit];
        self.placeHolderLabel.text = self.placeholder;
        [self sendSubviewToBack:self.placeHolderLabel];
    }
    
    if( self.text.length == 0 && self.attributedText.length == 0 && self.placeholder.length > 0 ){
        [self.placeHolderLabel setAlpha:1];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

/** 设置InputAccessoryView, 用于点击"完成"撤销键盘 */
-(void)setDoneInputAccessoryView {
    
    //1.btn
    UIButton *doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:self.tintColor forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(closeKeyboard) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:doneBtn];
    
    //2.fixItem
    UIBarButtonItem *fixItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    fixItem.width = 1;
    
    //3.spaceItem
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    //4.toolBar
    CGFloat toolBarH = 44;
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenW, toolBarH)];
    toolBar.items = @[flexibleItem, btnItem, fixItem];
    self.inputAccessoryView = toolBar;
}


-(void)closeKeyboard {
    [self resignFirstResponder];
}

#pragma mark - caret插入符
/** 改变光标大小
 *  textField和textView改变光标颜色: tintColor (同时复制粘贴的颜色也变了)
 */
-(CGRect)caretRectForPosition:(UITextPosition *)position {
    CGRect rect = [super caretRectForPosition:position];
    rect.size.height = self.font.lineHeight + 2;
    rect.size.width = 2;
    return rect;
}

#pragma mark - notification
- (void)textChanged:(NSNotification *)notification{
    if(self.placeholder.length == 0){
        return;
    }
    [UIView animateWithDuration:DGTextViewDuration animations:^{
        if(self.text.length == 0 && self.attributedText.length == 0){
            [self.placeHolderLabel setAlpha:1];
        }else{
            [self.placeHolderLabel setAlpha:0];
        }
    }];
}

#pragma mark - setter
- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}

- (void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self textChanged:nil];
}

-(void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.placeHolderLabel.text = placeholder;
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    self.placeHolderLabel.textColor = placeholderColor;
}

-(void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    [self setNeedsDisplay];
}

-(void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeHolderLabel.font = font;
}

@end
