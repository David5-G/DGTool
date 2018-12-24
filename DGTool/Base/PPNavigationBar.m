//
//  PPNavigationBar.m
//  PaPa
//
//  Created by david on 2018/10/24.
//  Copyright © 2018 万耀辉. All rights reserved.
//

#import "PPNavigationBar.h"

@interface PPNavigationBar()

@property (nonatomic,weak) UIImageView *bgImageView;
@end


@implementation PPNavigationBar

#pragma mark - init
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
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
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/2-110, STATUS_BAR_H, 220, 44)];
    self.titleLabel = titleL;
    titleL.textColor = UIColor.whiteColor;
    titleL.backgroundColor = UIColor.clearColor;
    titleL.font = [UIFont systemFontOfSize:19];
    titleL.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleL];
    
    //3.backBtn
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton = backBtn;
    UIImage *backImage = [UIImage imageNamed:@"backArrow_white"];
    [backBtn setImage:backImage forState:UIControlStateNormal];
    backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    backBtn.frame=CGRectMake(10, STATUS_BAR_H+10, backImage.size.width*24/backImage.size.height, 24);
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
