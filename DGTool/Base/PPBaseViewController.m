//
//  PPBaseViewController.m
//  PaPa
//
//  Created by david on 2018/10/24.
//  Copyright © 2018 万耀辉. All rights reserved.
//

#import "PPBaseViewController.h"

@interface PPBaseViewController ()
@property(nonatomic,weak,readwrite) PPNavigationBar *naviBar;
@property (nonatomic,weak,readwrite) UIView *displayView;
@end

@implementation PPBaseViewController

#pragma mark - lazy load
-(UIView *)displayView {
    if (!_displayView && _naviBar) {
        CGRect rect = self.view.frame;
        rect.origin.y = self.naviBarHeight;
        rect.size.height = rect.size.height - self.naviBarHeight;
        
        UIView *displayV = [[UIView alloc]initWithFrame:rect];
        [self.view addSubview:displayV];
        
        _displayView = displayV;
        displayV.backgroundColor = self.view.backgroundColor;
    }
    return _displayView;
}

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - statusBar
-(UIStatusBarStyle)preferredStatusBarStyle{
    return [self getStatusBarStyle];
}

-(UIStatusBarStyle)getStatusBarStyle {
    //1.如果有navigationBarView
    if (self.naviBar) {
        PPNavigationBarType barType = [self naviBarType];
        switch (barType) {
            case PPNavigationBarTypeDefault:
                return UIStatusBarStyleLightContent;
                break;
            case PPNavigationBarTypeWhite:
            case PPNavigationBarTypeGray:
            case PPNavigationBarTypeClear:
                return  UIStatusBarStyleDefault;
                break;
            default:
                return UIStatusBarStyleLightContent;
                break;
        }
    }
    
    //2.没有navigationBarView
    return UIStatusBarStyleLightContent;
}

#pragma mark - navi

-(void)setNaviBarDefault{
    [self setNaviBarWithType:PPNavigationBarTypeDefault];
}

-(void)setNaviBarClear{
    [self setNaviBarWithType:PPNavigationBarTypeClear];
}


-(void)setNaviBarWhite{
    [self setNaviBarWithType:PPNavigationBarTypeWhite];
}

-(void)setNaviBarGray{
    [self setNaviBarWithType:PPNavigationBarTypeGray];
}

/** 设置自定义的navigationBar */
-(void)setNaviBarWithType:(PPNavigationBarType)barType{
    //1.隐藏系统的navigationBar
    self.navigationController.navigationBarHidden = YES;
    
    //2.创建自定义的navigationBarView
    PPNavigationBar *naviBarV = [[PPNavigationBar alloc]init];
    self.naviBar = naviBarV;
    [self.view addSubview:naviBarV];
    
    //2.1 backButton相关
    [naviBarV.backButton addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.navigationController.viewControllers.count > 1) {
        naviBarV.backButton.hidden = NO;
    }else{
        naviBarV.backButton.hidden = YES;
    }

    //2.2 barType
    naviBarV.barType = barType;
    switch (barType) {
        case PPNavigationBarTypeDefault:{
            //naviBarV.bgImageView.image = [UIImage imageNamed:@""];
        }break;
            
        case PPNavigationBarTypeWhite:{
            [naviBarV setNaviBarBackgroundColor:UIColor.whiteColor];
            naviBarV.titleLabel.textColor = COLOR_HEX(0x333333);
            
            UIImage *backBtnImg = [UIImage imageNamed:@"backArrow_gray"];
            [naviBarV.backButton setImage:backBtnImg forState:UIControlStateNormal];
        }break;
            
        case PPNavigationBarTypeClear:{
            [naviBarV setNaviBarBackgroundColor:UIColor.clearColor];
            naviBarV.titleLabel.textColor = COLOR_HEX(0x333333);
        }break;
            
        case PPNavigationBarTypeGray:{
            [naviBarV setNaviBarBackgroundColor:COLOR_HEX(0xf2f2f2)];
            naviBarV.titleLabel.textColor = COLOR_HEX(0x333333);
            
            UIImage *backBtnImg = [UIImage imageNamed:@"backArrow_gray"];
            [naviBarV.backButton setImage:backBtnImg forState:UIControlStateNormal];
        }break;
            
        default:
            break;
    }
    
    //
}

/** 获取导航栏类型 */
- (PPNavigationBarType)naviBarType{
    return self.naviBar.barType;
}

#pragma mark
/** 自定义导航栏的高度 */
- (CGFloat)naviBarHeight{
    return self.naviBar.frame.size.height;
}

/** 设置导航栏的背景图 */
-(void)setNavigBarBackgroundImage:(UIImage *)image{
    self.naviBar.bgImage = image;
}

/** 设置导航栏背景色,此方法会隐藏导航栏背景图 */
-(void)setNaviBarBackgroundColor:(UIColor *)color{
    self.naviBar.backgroundColor = color;
}

#pragma mark title
/** 自定义navigationBar的title */
- (NSString *)naviBarTitle{
    return self.naviBar.titleLabel.text;
}

/** 设置自定义navigationBar的title */
- (void)setNaviBarTitle:(NSString *)title{
    self.naviBar.titleLabel.text = title;
}

/** 设置title颜色 */
- (void)setNaviBarTitleColor:(UIColor *)color{
    self.naviBar.titleLabel.textColor = color;
}

/** 设置title字体大小 */
- (void)setNaviBarTitleFont:(UIFont *)font{
    self.naviBar.titleLabel.font = font;
}

#pragma mark backButton
/** 隐藏backBtn */
- (void)hiddenBackButton{
    self.naviBar.backButton.hidden = YES;  
}

/** 点击backBtn */
-(void)clickBackButton {
    if(self.navigationController.viewControllers.count>1){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
