//
//  DGNavigationBar.m
//  DGTool
//
//  Created by david on 2018/12/26.
//  Copyright © 2018 david. All rights reserved.
//

#import "DGNavigationBar.h"

@interface DGNavigationBar ()
@property (nonatomic,weak) UIImageView *bgImageView;
@end

@implementation DGNavigationBar

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI
- (void)setupUI {
    
    self.frame = CGRectMake(0, 0, SCREEN_W,STATUS_AND_NAV_BAR_H);
    self.backgroundColor = COLOR_NAVI_BG;
    
    //1.bgImage
    UIImageView *bgImageV = [[UIImageView alloc] initWithFrame:self.bounds];
    self.bgImageView  = bgImageV;
    bgImageV.image = [self imageWithColor:UIColor.grayColor];
    bgImageV.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:bgImageV];
    bgImageV.hidden = YES;
    
    //2.titleLabel
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(80, STATUS_BAR_H, SCREEN_W-160, 44)];
    self.titleLabel = titleL;
    titleL.textColor = UIColor.whiteColor;
    titleL.backgroundColor = UIColor.clearColor;
    titleL.font = [UIFont systemFontOfSize:19];
    titleL.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleL];
    
    //3.backBtn
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton = backBtn;
    UIImage *backImage = [UIImage imageNamed:@"navi_arrowLeft_white"];
    [backBtn setImage:backImage forState:UIControlStateNormal];
    backBtn.frame=CGRectMake(10, STATUS_BAR_H, 50, 44);
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self addSubview:backBtn];
}

#pragma mark - setter
-(void)setBgImage:(UIImage *)bgImage {
    _bgImageView.image = bgImage;
    _bgImageView.hidden = NO;
}

-(void)setNaviBarBackgroundColor:(UIColor *)bgColor{
    _bgImageView.hidden = YES;
    self.backgroundColor = bgColor;
}

#pragma mark - tool
/** 纯色转图片 */
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
