//
//  DGBaseViewController.m
//  DGTool
//
//  Created by david on 2018/12/26.
//  Copyright © 2018 david. All rights reserved.
//

#import "DGBaseViewController.h"
//#import "DGSingleImagePreviewVC.h"
//#import "DGImagePreviewVC.h"

@interface DGBaseViewController ()
@property(nonatomic,weak,readwrite) DGNavigationBar *naviBar;
@property (nonatomic,weak,readwrite) UIView *displayView;
@end

@implementation DGBaseViewController

#pragma mark - lazy load
-(UIView *)displayView {
    if (!_displayView && _naviBar) {
        CGRect rect = self.view.frame;
        CGFloat naviH = self.naviBar.frame.size.height;
        rect.origin.y = naviH;
        rect.size.height -= naviH;
        
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
    
    self.view.backgroundColor = COLOR_BG;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - statusBar
-(BOOL)prefersStatusBarHidden {
    return NO;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return [self getStatusBarStyle];
}

- (UIStatusBarStyle)getStatusBarStyle {
    //1.如果有navigationBarView
    if (self.naviBar) {
        DGNavigationBarType barType = self.naviBar.barType;
        switch (barType) {
            case DGNavigationBarTypeDefault:
            case DGNavigationBarTypeClear:
                return UIStatusBarStyleLightContent;
                break;
            case DGNavigationBarTypeWhite:
            case DGNavigationBarTypeGray:
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

/** 设置自定义的navigationBar */
-(void)setNaviBarWithType:(DGNavigationBarType)barType{
    
    //1.创建自定义的navigationBarView
    DGNavigationBar *naviBarV = [[DGNavigationBar alloc]init];
    self.naviBar = naviBarV;
    naviBarV.barType = barType;
    [self.view addSubview:naviBarV];
    
    //1.1 backButton相关
    [naviBarV.backButton addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.navigationController.viewControllers.count > 1) {
        naviBarV.backButton.hidden = NO;
    }else{
        naviBarV.backButton.hidden = YES;
    }
    
    //2. 更新statusBar
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark title
/** 获取NaviBarTitle */
- (NSString *)naviBarTitle {
    return self.naviBar.titleLabel.text;
}

/** 设置NaviBarTitle */
- (void)setNaviBarTitle:(NSString *)title {
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
//隐藏backBtn
- (void)hideBackButton:(BOOL)hide {
    self.naviBar.backButton.hidden = hide;
}

/** 点击backBtn */
-(void)clickBackButton {
    
    if(self.navigationController.viewControllers.count>1){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/** 延迟点击backBtn */
-(void)clickBackButtonWithDelay:(CGFloat)delay {
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [self clickBackButton];
    });
}

@end
