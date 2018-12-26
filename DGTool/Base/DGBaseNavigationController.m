//
//  DGBaseNavigationController.m
//  DGTool
//
//  Created by david on 2018/12/26.
//  Copyright © 2018 david. All rights reserved.
//

#import "DGBaseNavigationController.h"

@interface DGBaseNavigationController ()

@end

@implementation DGBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //只有设为UIBarStyleBlack时,子VC的preferredStatusBarStyle才会被调用
    self.navigationBar.barStyle = UIBarStyleBlack;
}

#pragma mark rotate
//-(BOOL)shouldAutorotate{
//    return self.topViewController.shouldAutorotate;
//}
//
//-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return self.topViewController.supportedInterfaceOrientations;
//}

#pragma mark - StatusBar
//-(UIViewController *)childViewControllerForStatusBarStyle{
//    return self.visibleViewController;
//}
//
//-(UIViewController *)childViewControllerForStatusBarHidden{
//    return self.visibleViewController;
//}

#pragma mark - push
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count != 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
