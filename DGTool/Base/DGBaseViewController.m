//
//  DGBaseViewController.m
//  DGTool
//
//  Created by david on 2018/12/26.
//  Copyright © 2018 david. All rights reserved.
//

#import "DGBaseViewController.h"
#import "DGSingleImagePreviewVC.h"
#import "DGImagePreviewVC.h"

@interface DGBaseViewController ()
@property(nonatomic,weak,readwrite) DGNavigationBar *naviBar;
@property (nonatomic,weak,readwrite) UIView *displayView;
@end

@implementation DGBaseViewController

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
    self.view.backgroundColor = COLOR_BG;
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
        DGNavigationBarType barType = [self naviBarType];
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

-(void)setNaviBarDefault{
    [self setNaviBarWithType:DGNavigationBarTypeDefault];
}

-(void)setNaviBarClear{
    [self setNaviBarWithType:DGNavigationBarTypeClear];
}

-(void)setNaviBarWhite{
    [self setNaviBarWithType:DGNavigationBarTypeWhite];
}

-(void)setNaviBarGray{
    [self setNaviBarWithType:DGNavigationBarTypeGray];
}

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
    
    //1.2 barType
    switch (barType) {
        case DGNavigationBarTypeDefault:{
            //naviBarV.bgImageView.image = [UIImage imageNamed:@""];
        }break;
            
        case DGNavigationBarTypeWhite:{
            [naviBarV setNaviBarBackgroundColor:UIColor.whiteColor];
            naviBarV.titleLabel.textColor = COLOR_HEX(0x333333);
            
            UIImage *backBtnImg = [UIImage imageNamed:@"navi_arrowLeft_gray"];
            [naviBarV.backButton setImage:backBtnImg forState:UIControlStateNormal];
        }break;
            
        case DGNavigationBarTypeClear:{
            [naviBarV setNaviBarBackgroundColor:UIColor.clearColor];
            naviBarV.titleLabel.textColor = COLOR_HEX(0x333333);
        }break;
            
        case DGNavigationBarTypeGray:{
            [naviBarV setNaviBarBackgroundColor:COLOR_HEX(0xf2f2f2)];
            naviBarV.titleLabel.textColor = COLOR_HEX(0x333333);
            
            UIImage *backBtnImg = [UIImage imageNamed:@"navi_arrowLeft_gray"];
            [naviBarV.backButton setImage:backBtnImg forState:UIControlStateNormal];
        }break;
            
        default:
            break;
    }
    
    //2. 更新statusBar
    [self setNeedsStatusBarAppearanceUpdate];
}

/** 获取导航栏类型 */
- (DGNavigationBarType)naviBarType{
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

/** 延迟点击backBtn */
-(void)clickBackButtonWithDelay:(CGFloat)delay {
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [self clickBackButton];
    });
}

#pragma mark - 查看图片
- (void)previewImages:(NSArray <UIImage *>*)images defaultIndex:(NSInteger)index {
    DGImagePreviewVC *vc = [[DGImagePreviewVC alloc]init];
    [vc setPreviewImages:images defaultIndex:index];
    vc.isAssetPreview = NO;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)previewImage:(UIImage *)image {
    DGSingleImagePreviewVC *imageViewController = [[DGSingleImagePreviewVC alloc]initWithImage:image];
    [self presentViewController:imageViewController animated:YES completion:nil];
}

- (void)previewImageWithUrl:(NSURL *)imageUrl {
    DGSingleImagePreviewVC *imageViewController = [[DGSingleImagePreviewVC alloc]initWithImageURL:imageUrl];
    [self presentViewController:imageViewController animated:YES completion:nil];
}

@end
