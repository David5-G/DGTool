//
//  DGFullScreenPopView.m
//  DGTool
//
//  Created by david on 2018/11/13.
//  Copyright © 2018 david. All rights reserved.
//

#import "DGFullScreenPopView.h"
#import "DGButton.h"

@interface DGFullScreenPopView ()
@property (nonatomic,copy) void(^block)(NSInteger index);
@end

@implementation DGFullScreenPopView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark - UI
/** 展示popView */
-(void)showPopViewWithBlock:(void(^)(NSInteger index))block {
    
    self.block = block;
    
    //1.全屏背景
    UIView * screenBgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication].keyWindow addSubview:screenBgView];
    
    //2.add
    [screenBgView addSubview:self];
    [self setupSubViews];
    
    //3.animate
    screenBgView.backgroundColor = RGBA(0, 0, 0, 0);
    [UIView animateWithDuration:0.2 animations:^{
        screenBgView.backgroundColor = RGBA(0, 0, 0, 0.25);
    }];
    
    //4.tap
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [screenBgView addGestureRecognizer:tap];
}

-(void)tapAction:(UITapGestureRecognizer *)gr {
    [gr.view removeFromSuperview];
}

-(void)setupSubViews {
    
    //1.self的高
    CGFloat btnOrighY = 5;
    CGFloat btnH = 40;
    CGRect frame = self.frame;
    CGFloat btnW = frame.size.width;
    frame.size.height = btnH * self.titleArr.count + btnOrighY;
    self.frame = frame;
    
    //2.bgImgV
    UIImageView *bgImgV = [[UIImageView alloc]initWithFrame:self.bounds];
    bgImgV.image = [UIImage imageNamed:@"club_bg_screenPop"];
    [self addSubview:bgImgV];
    
    //3.btns
    for (NSInteger i=0; i<self.titleArr.count; i++) {
        NSString *title = self.titleArr[i];
        NSString *imgName = self.imageNameArr[i];
        
        DGButton *btn = [self createButtonWithTitle:title imgName:imgName];
        btn.frame = CGRectMake(0, btnOrighY+i*btnH, btnW, btnH);
        btn.tag = i;
        [self addSubview:btn];
        
        
        WeakS(weakSelf);
        [btn addClickBlock:^(DGButton *btn) {
            weakSelf.block(btn.tag);
            [self.superview removeFromSuperview];
        }];
    }
}

/** 创建button */
-(DGButton *)createButtonWithTitle:(NSString *)title imgName:(NSString *)imgName {
    
    DGButton *btn = [DGButton btnWithFontSize:14 title:title  titleColor:COLOR_BLACK_TEXT];
    [btn setImage:Img(imgName) forState:UIControlStateNormal];
    
    btn.adjustsImageWhenHighlighted = NO;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    btn.imageEdgeInsets = UIEdgeInsetsMake(5, 12, 5, 50);
    btn.titleEdgeInsets= UIEdgeInsetsMake(5, 20, 5, 2);
    
    return btn;
}

@end
