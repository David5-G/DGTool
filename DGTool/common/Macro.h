//
//  Macro.h
//  kt_user
//
//  Created by david on 2018/9/10.
//  Copyright © 2018 杭州鼎代. All rights reserved.
//

#ifndef Macro_h
#define Macro_h


//---------------------------------------------------
#ifdef TARGET_IPHONE_SIMULATOR
//XXXXX  模拟器时会编译的代码
#else
//XXXXX  不是模拟器才会编译的代码
#endif


//---------------------------------------------------
#pragma mark - color
/** 二进制颜色*/
#define COLOR_HEX(hex) [UIColor colorWithRed:((float)((hex & 0x00FF0000) >> 16)) / 255.0     \
green:((float)((hex & 0x0000FF00) >>  8)) / 255.0     \
blue:((float)((hex & 0x000000FF) >>  0)) / 255.0     \
alpha:1.0]

#define COLOR_HexStr(hexStr) ({NSString *colorHexStr = [hexStr stringByReplacingOccurrencesOfString:@"#" withString:@"0x"]; \
unsigned colorHex = 0; \
[[NSScanner scannerWithString:colorHexStr] scanHexInt:&colorHex];\
UIColorFromRGB(colorHex);})

#pragma mark rgb
/** rgb颜色*/
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b)    RGBA(r,g,b,1.0f)

/** 常用颜色 */
#define COLOR_BLACK_TEXT        RGBA(51,51,51,1.0)
#define COLOR_DARK_GRAY_TEXT    RGBA(102,102,102,1.0)
#define COLOR_GRAY_TEXT         RGBA(153,153,153,1.0)
#define COLOR_NAVI_BG   RGB(83, 181, 233)


//---------------------------------------------------
#pragma mark - 尺寸(宽高)
#define KEY_WINDOW [UIApplication sharedApplication].keyWindow

/** 获取屏幕 宽度、高度*/
#define SCREEN_BOUNDS  ([UIScreen mainScreen].bounds)
#define SCREEN_W       ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_H       ([UIScreen mainScreen].bounds.size.height)


#define STATUS_BAR_H (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))

#define NAV_BAR_H             (44.f)
#define STATUS_AND_NAV_BAR_H  (STATUS_BAR_H + NAV_BAR_H)
#define TAB_BAR_H             (iPhoneX ? (49.f+34.f) : 49.f)
#define HOME_INDICATOR_H      (iPhoneX ? 34.f : 0.f)

// 设备相关
#define GREATER_iPhone5_W      (MIN(SCREEN_W, SCREEN_H) > 320)
#define GREATER_iPhone6_W      (MIN(SCREEN_W, SCREEN_H) > 375)


//---------------------------------------------------
#pragma mark - scale

#define SCALE_W_6       (MIN(SCREEN_W,SCREEN_H)/375.0)
#define SCALE_W_6P      (MIN(SCREEN_W,SCREEN_H)/414)

#define SCALE_W_5_D     (MIN(SCREEN_W,SCREEN_H)/320.0*0.8+0.2)
#define SCALE_W_6P_D    (MIN(SCREEN_W,SCREEN_H)/414.0*0.8+0.2)
#define SCALE_H_6P_D    (MAX(SCREEN_W,SCREEN_H)/736.0*0.8+0.2)
#define SCALE_W_D(a)    (a/414.0*0.8+0.2)

//---------------------------------------------------
#pragma mark - 设备/版本
/** 获取系统版本*/
#define VERSION_iOS      [[[UIDevice currentDevice] systemVersion] floatValue]
#define VERSION_SYSTEM   [[UIDevice currentDevice] systemVersion]
#define VERSION_APP      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

// 判断iPhone
#define iPhone4  (MAX(SCREEN_W, SCREEN_H) == 480)
#define iPhone5  (MAX(SCREEN_W, SCREEN_H) == 568)
#define iPhone6  (MAX(SCREEN_W, SCREEN_H) == 667)
#define iPhone6P (MAX(SCREEN_W, SCREEN_H) == 736)
#define iPhoneX  (MAX(SCREEN_W, SCREEN_H) >= 812)


//---------------------------------------------------
#pragma mark - strong/weak
#define WS(weakSelf)    __weak __typeof(&*self)weakSelf = self;
#define SS(strongSelf)  __strong __typeof(&*weakSelf)strongSelf = weakSelf;

#define weak(v)         __weak typeof(v) weak_##v = v;
#define strong(v)       __strong typeof(v) strong_##v = weak_##v;


//---------------------------------------------------
#pragma mark - notification
#define NOTIFICATION_PRESENT_LOGINVC @"notificationPresentLoginVC"///<通知弹出登录页
#define NOTIFICATION_PRESENT_LOGINVC_LOGIN_ELSE @"notificationLoginElse"///在其他地方登录
#define NOTIFICATION_PRESENT_APP_UPDATE @"notificationAppUpdate"///弹出强制更新
#define NOTIFICATION_PRESENT_LOGINVC_ACCOUNT_ABNORMAL @"notificationAccountAbnormal"///账号异常
#define NOTIFICATION_LOGIN_SUCCESS @"notificationLoginSuccess"///<登录成功通知
#define NOTIFICATION_LOGOUT_SUCCESS @"notificationLogoutSuccess"///<退出登录通知
#define NOTIFICATION_DEVICE_ORIENTATION_CHANGED @"notificationDeviceOrientationChanged"///<横竖屏切换通知


//---------------------------------------------------
#pragma mark - log
#ifdef DEBUG
#   define DGLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DGLog(...)
#endif



//---------------------------------------------------
#pragma mark - other
#define IGNORE_ERROR @"a"    // 回调的时候,忽略掉的错误提示

/** 简写*/
#define New(T)   [[T alloc] init]
#define Font(T)  [UIFont systemFontOfSize:T]
#define Img(T)   [UIImage imageNamed:T]


/** 最大最小值 */
#define MAXValue(A,B) ({__typeof(A) __a = (A);__typeof(B) __b = (B);__a > __b ? __a : __b;})
#define MINValue(A,B) ({__typeof(A) __a = (A);__typeof(B) __b = (B);__a > __b ? __b : __a;})


#endif /* Macro_h */
