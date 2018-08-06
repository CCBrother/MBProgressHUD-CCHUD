//
//  MBProgressHUD+CCHUD.m
//  
//
//  Created by ZhangCc on 2017/11/2.
//  Copyright © 2017年 Zemiao. All rights reserved.
//

#import "MBProgressHUD+CCHUD.h"
#import "AppDelegate.h"

//设置RGB颜色
#define ZKRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]//用10进制表示颜色，例如（255,255,255）黑色

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation MBProgressHUD (CCHUD)

//window显示文字
+ (void)showInWindowMessage:(NSString *)message {
    [self showMessage:message delayTime:1.5 isWindow:YES];
}

//window显示文字延时
+ (void)showInWindowMessage:(NSString *)message delayTime:(NSInteger)time {
    [self showMessage:message delayTime:time isWindow:YES];
}

//window加载
+ (void)showInWindowActivityWithMessage:(NSString *)message {
    [self showActivityMessage:message isWindow:YES delayTime:1.0];
}

//window加载延时
+ (void)showInWindowActivityWithMessage:(NSString *)message delayTime:(NSInteger)time {
    [self showActivityMessage:message isWindow:YES delayTime:time];
}

//window自定义图片
+ (void)showInWindowCustomImage:(NSString *)imageName message:(NSString *)message {
    [self showCustomImage:imageName message:message isWindow:YES];
}

#pragma mark - 显示在view
//view显示文字
+ (void)showInViewMessage:(NSString *)message {
    [self showMessage:message delayTime:1.5 isWindow:NO];
}

//view显示文字延时
+ (void)showInViewMessage:(NSString *)message delayTime:(NSInteger)time {
    [self showMessage:message delayTime:time isWindow:NO];
}

//view加载
+ (void)showInViewActivityWithMessage:(NSString *)message {
    [self showActivityMessage:message isWindow:NO delayTime:1.0];
}

//view加载延时
+ (void)showInViewActivityWithMessage:(NSString *)message delayTime:(NSInteger)time {
    [self showActivityMessage:message isWindow:NO delayTime:time];
}

//view自定义图片
+ (void)showInViewCustomImage:(NSString *)imageName message:(NSString *)message {
    [self showCustomImage:imageName message:message isWindow:NO];
}

#pragma mark - 操作结果提示
//成功提示
+ (void)showSuccessMessage:(NSString *)message {
    [self showCustomImage:@"MBHUD_Success" message:message];
}

//失败提示
+ (void)showFailMessage:(NSString *)message {
    [self showCustomImage:@"MBHUD_Error" message:message];
}

//警告提示
+ (void)showWarnMessage:(NSString *)message {
    [self showCustomImage:@"MBHUD_Warn" message:message];
}

//信息提示
+ (void)showInfoMessage:(NSString *)message {
    [self showCustomImage:@"MBHUD_Info" message:message];
}

//默认显示在window
+ (void)showCustomImage:(NSString *)imageName message:(NSString *)message {
    [self showCustomImage:imageName message:message isWindow:YES];
}

+ (void)showProgressHudWithMessage:(NSString *)message {
    MBProgressHUD *hud = [self createMBProgerssHUDWithMessage:message isWindow:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.bezelView.color = [UIColor  blackColor];
    hud.contentColor = [UIColor whiteColor];
}

#pragma mark - 隐藏
//隐藏
+ (void)hideHUD {
    UIView *windowView = (UIView *)[UIApplication sharedApplication].delegate.window;
    [self hideHUDForView:windowView animated:YES];
    [self hideHUDForView:[self currentUIViewController].view animated:YES];
}

#pragma mark - Private
/**
 加载动态图片
 */
+ (void)showActivityMessage:(NSString*)message
                   isWindow:(BOOL)isWindow
                  delayTime:(NSInteger)delayTime {
    
    MBProgressHUD *hud  = [self createMBProgerssHUDWithMessage:message isWindow:isWindow];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.activityIndicatorColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor  blackColor];
    hud.square = YES;
    if (delayTime > 0) {
        [hud hideAnimated:YES afterDelay:delayTime];
    }
}

/**
 自定义图片
 */
+ (void)showCustomImage:(NSString *)imageName
                message:(NSString *)message
               isWindow:(BOOL)isWindow {
    
    MBProgressHUD *hud = [self createMBProgerssHUDWithMessage:message isWindow:isWindow];
    hud.mode = MBProgressHUDModeCustomView;
    hud.square = YES;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = ZKRGBColor(30, 30, 30);
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    [hud hideAnimated:YES afterDelay:1.5];
}

/**
 显示信息延时
 */
+ (void)showMessage:(NSString *)message
          delayTime:(NSInteger)delayTime
           isWindow:(BOOL)isWindow {
    
    MBProgressHUD *hud = [self createMBProgerssHUDWithMessage:message isWindow:isWindow];
    hud.mode = MBProgressHUDModeText;
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = ZKRGBColor(30, 30, 30);
    hud.label.font = [UIFont systemFontOfSize:12.0f];
    [hud hideAnimated:YES afterDelay:delayTime];
}

/**
 显示信息
 */
+ (MBProgressHUD *)createMBProgerssHUDWithMessage:(NSString *)message
                                         isWindow:(BOOL)isWindow {
    
    UIView *view = isWindow ? (UIView *)[UIApplication sharedApplication].delegate.window : [self currentUIViewController].view;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.textColor = ZKRGBColor(255, 255, 255);
    hud.label.font = [UIFont systemFontOfSize:12.0f];
    hud.label.text = message;
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

//获取屏幕当前显示的ViewController
+ (UIViewController *)currentUIViewController {
    UIViewController *superViewController = [[self class] currentWindowViewController];
    if ([superViewController isKindOfClass:[UITabBarController class]]) {
        
        UIViewController *tabSelectVC = ((UITabBarController *)superViewController).selectedViewController;
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            return ((UINavigationController *)tabSelectVC).viewControllers.lastObject;
        }
        
    }else if ([superViewController isKindOfClass:[UINavigationController class]]) {
        return ((UINavigationController *)superViewController).viewControllers.lastObject;
    }
    return superViewController;
}

+ (UIViewController *)currentWindowViewController {
    UIViewController *viewController = nil;
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (appDelegate.window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *tempWindow in windows) {
            if (tempWindow.windowLevel == UIWindowLevelNormal) {
                appDelegate.window = tempWindow;
                break;
            }
        }
    }
    UIView *frontView = [[appDelegate.window subviews]objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        viewController = nextResponder;
    }else {
        viewController = appDelegate.window.rootViewController;
    }
    return viewController;
}



@end
