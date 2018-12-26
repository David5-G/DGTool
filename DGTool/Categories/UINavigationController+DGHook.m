//
//  UINavigationController+DGHook.m
//  DGTool
//
//  Created by david on 2018/10/12.
//  Copyright © 2018 david. All rights reserved.
//

#import "UINavigationController+DGHook.h"
#import <objc/message.h>
#import "DGHookTrack.h"
#import "DGShare.h"


@implementation UINavigationController (DGHook)

#pragma mark - public

+ (void)dg_hookPush{
    Method pushMethod = class_getInstanceMethod([self class], @selector(pushViewController:animated:));
    Method hookMethod = class_getInstanceMethod([self class], @selector(hook_pushViewController:animated:));
    method_exchangeImplementations(pushMethod, hookMethod);
}

+ (void)dg_hookPop {
    Method popMethod = class_getInstanceMethod([self class], @selector(popViewControllerAnimated:));
    Method hookMethod = class_getInstanceMethod([self class], @selector(hook_popViewControllerAnimated:));
    method_exchangeImplementations(popMethod, hookMethod);
    
    Method popMethod2 = class_getInstanceMethod([self class], @selector(popToViewController:animated:));
    Method hookMethod2 = class_getInstanceMethod([self class], @selector(hook_popToViewController:animated:));
    method_exchangeImplementations(popMethod2, hookMethod2);

}

#pragma mark - push
- (void)hook_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    NSString *pushToVC = NSStringFromClass([viewController class]);
    NSString *pushFromVC = [self updateLastPushVCs:pushToVC];
    
    NSString *actionStr = [NSString stringWithFormat: @"%@-%@-%@", pushFromVC, @"pushTo", pushToVC];
    [DGHookTrack getInstance].currentVCStr = pushToVC;
    [DGHookTrack getInstance].pushPopActionStr = actionStr;
    if ([DGHookTrack getInstance].debug) {
        DGHttpLog(@"###%@###", actionStr);
    }
    [self hook_pushViewController:viewController animated:animated];
}

#pragma mark - pop
- (UIViewController *)hook_popViewControllerAnimated:(BOOL)animated{
    
    NSUInteger count = self.viewControllers.count;
    if (count<2) {
        return [self hook_popViewControllerAnimated:animated];
    }
    
    NSString *popToVC = [self updateLastPopVCs];
    NSString *actionStr = [NSString stringWithFormat:@"%@-%@-%@",[DGHookTrack getInstance].currentVCStr,@"popTo",popToVC];
    if ([DGHookTrack getInstance].debug) {
        DGHttpLog(@"###%@###", actionStr);
    }
    [DGHookTrack getInstance].pushPopActionStr = actionStr;
    actionStr = nil;
    [DGHookTrack getInstance].currentVCStr = popToVC;
    return [self hook_popViewControllerAnimated:animated];
}

- (NSArray *)hook_popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    NSString *popToVC = [self updateLastPopVCs];
    NSString *actionStr = [NSString stringWithFormat:@"%@-%@-%@",[DGHookTrack getInstance].currentVCStr,@"popTo",NSStringFromClass([viewController class])];
    if ([DGHookTrack getInstance].debug) {
        DGHttpLog(@"###%@###", actionStr);
    }
    [DGHookTrack getInstance].pushPopActionStr = actionStr;
    actionStr = nil;
    [DGHookTrack getInstance].currentVCStr = popToVC;
    return [self hook_popToViewController:viewController animated:animated];
}

#pragma mark -
- (NSString *)updateLastPushVCs:(NSString *)toVC{
    NSArray *vcs = self.viewControllers;
    if (vcs.count < 1) {
        return nil;
    }
    NSMutableArray *vcNames = [[NSMutableArray alloc]init];
    for (int i=0; i<vcs.count; i++) {
        NSString *lastVC = NSStringFromClass([self.viewControllers[i] class]);
        [vcNames addObject:lastVC];
    }
    [vcNames addObject:toVC];
    [DGHookTrack getInstance].lastVCs = vcNames;
    return vcNames[vcNames.count-1];
}

- (NSString *)updateLastPopVCs{
    NSArray *vcs = self.viewControllers;
    if (vcs.count<2) {
        return nil;
    }
    NSMutableArray *vcNames = [[NSMutableArray alloc]init];
    for (int i=0; i<vcs.count; i++) {
        NSString *lastVC = NSStringFromClass([self.viewControllers[i] class]);
        [vcNames addObject:lastVC];
    }
    [DGHookTrack getInstance].lastVCs = vcNames;
    return vcNames[vcNames.count-2];
}

@end
