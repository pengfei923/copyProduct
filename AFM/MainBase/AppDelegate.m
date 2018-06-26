//
//  AppDelegate.m
//  AFM
//
//  Created by admin on 2017/8/28.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "LoginViewController.h"
#import <UMSocialCore/UMSocialCore.h>


#define UMKey @"5987c0c145297d50d8000a6d"
#define QQAPPID @"101330904"
#define QQKEY @"41ebce53a80c6713b420b1f17093a942"
#define WXAPPID @"wxe43bb7bc7cb3367d"
#define WXAPPSECRET @"c7e44ed43c2394173d072e2056f333bd"
#define SINAAPPID @"1037790589"
#define SINASECRET @"820a6717fe84830a6f0e97696947355e"


NSString * const SVProgressHUDshow                  = @"SVProgressHUDshow";
NSString * const SVProgressHUDdismiss               = @"SVProgressHUDdismiss";
NSString * const SVProgressHUDshowWithStatus        = @"SVProgressHUDshowWithStatus";
NSString * const SVProgressHUDshowInfoWithStatus    = @"SVProgressHUDshowInfoWithStatus";
NSString * const SVProgressHUDshowErrorWithStatus   = @"SVProgressHUDshowErrorWithStatus";
NSString * const SVProgressHUDshowSuccessWithStatus = @"SVProgressHUDshowSuccessWithStatus";
NSString * const SVProgressHUDShowProgress          = @"SVProgressHUDShowProgress";

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self addAction];
    [self createView];
    [self createComponent];
    [self createShare];
    [self createUMMobClick];
    [self createDiSan];  //三方登录
    [self createANPS:launchOptions];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}

- (void)applicationDidEnterBackground:(UIApplication *)application {}

- (void)applicationWillEnterForeground:(UIApplication *)application {}

- (void)applicationDidBecomeActive:(UIApplication *)application {}

- (void)applicationWillTerminate:(UIApplication *)application {
//    [self removeAction];
}




#pragma mark - =========================视图对象=========================
-(void)createView {
    BaseTabBarController *baseTabbar = [[BaseTabBarController alloc]init];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = baseTabbar;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}


#pragma mark - =========================其他组件=========================
- (void)createComponent {
//    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
//    manager.enable = YES;//是否激活
//    manager.enableAutoToolbar = YES;//控制是否显示键盘上的工具条
//    manager.shouldResignOnTouchOutside = YES;//控制点击背景是否收起键盘
}

#pragma mark - =========================第三方登录=========================
- (void)createDiSan{
    
    
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5987c0c145297d50d8000a6d"];
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAPPID appSecret:WXAPPSECRET redirectURL:@"http://mobile.umeng.com/social"];
    
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAPPID  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SINAAPPID  appSecret:SINASECRET redirectURL:@"http://passport1.sgamer.com/connect/wb_connect.php"];


}




#pragma mark - =========================分享组件=========================
- (void)createShare{
    [OpenShareComponent registered];
   

}


#pragma mark - =========================友盟统计=========================
- (void)createUMMobClick {
    
}

#pragma mark - =========================推送组件=========================
//注册推送
-(void)createANPS:(NSDictionary *)launchOptions {

}




#pragma mark - ============================================================
#pragma mark - =======================注册广播/移除广播=======================
#pragma mark - ============================================================



#pragma mark - 发送广播

//开始请求
+ (void)notificationRequestStart:(NSString *)data {
    if (!data) {
        data = @"";
    }
    
    // 主线程执行：
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter]postNotificationName:SVProgressHUDshow object:nil userInfo:[NSDictionary dictionaryWithObject:data forKey:@"data"]];
    });
}

//开始请求并提示
+ (void)notificationRequestStartWithStatus:(NSString *)data {
    if (!data) {
        data = @"";
    }
    
    // 主线程执行：
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter]postNotificationName:SVProgressHUDshowWithStatus object:nil userInfo:[NSDictionary dictionaryWithObject:data forKey:@"data"]];
    });
}

//请求完成并提示
+ (void)notificationRequestSuccessWithStatus:(NSString *)data {
    if (!data) {
        data = @"";
    }
    
    // 主线程执行：
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter]postNotificationName:SVProgressHUDshowSuccessWithStatus object:nil userInfo:[NSDictionary dictionaryWithObject:data forKey:@"data"]];
    });
}

//请求完成并解散
+ (void)notificationRequestComplete:(NSString *)data {
    if (!data) {
        data = @"";
    }
    // 主线程执行：
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter]postNotificationName:SVProgressHUDdismiss object:nil userInfo:[NSDictionary dictionaryWithObject:data forKey:@"data"]];
    });
}

//请求警告
+ (void)notificationRequestInfoWithStatus:(NSString *)data {
    if (!data) {
        data = @"";
    }
    
    // 主线程执行：
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter]postNotificationName:SVProgressHUDshowInfoWithStatus object:nil userInfo:[NSDictionary dictionaryWithObject:data forKey:@"data"]];
    });
}

//请求错误
+ (void)notificationRequestError:(NSString *)data {
    if (!data) {
        data = @"";
    }
    
    // 主线程执行：
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter]postNotificationName:SVProgressHUDshowErrorWithStatus object:nil userInfo:[NSDictionary dictionaryWithObject:data forKey:@"data"]];
    });
}

//上传进度
+ (void)notificationRequestShowProgress:(float)data {
    if (data < 0) {
        data = 0;
    }
    
    // 主线程执行：
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter]postNotificationName:SVProgressHUDShowProgress object:nil userInfo:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%f",data] forKey:@"data"]];
    });
}


//注册接口列表广播
- (void) addAction {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SVProgressHUDshow:) name:SVProgressHUDshow object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SVProgressHUDdismiss:) name:SVProgressHUDdismiss object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SVProgressHUDshowErrorWithStatus:) name:SVProgressHUDshowErrorWithStatus object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SVProgressHUDshowWithStatus:) name:SVProgressHUDshowWithStatus object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SVProgressHUDshowSuccessWithStatus:) name:SVProgressHUDshowSuccessWithStatus object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SVProgressHUDshowInfoWithStatus:) name:SVProgressHUDshowInfoWithStatus object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SVProgressHUDShowProgress:) name:SVProgressHUDShowProgress object:nil];
    
}


//移除接口列表广播
- (void) removeAction{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SVProgressHUDshow object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SVProgressHUDdismiss object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SVProgressHUDshowErrorWithStatus object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SVProgressHUDshowWithStatus object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SVProgressHUDshowSuccessWithStatus object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SVProgressHUDshowInfoWithStatus object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SVProgressHUDShowProgress object:nil];
    
}




//开始显示
- (void)SVProgressHUDshow:(NSNotification *)notification {
    [SVProgressHUD show];
}


//开始显示并提示
- (void)SVProgressHUDshowWithStatus:(NSNotification *)notification {
    [SVProgressHUD showWithStatus:[notification.userInfo objectForKey:@"data"]];
}


//完成
- (void)SVProgressHUDshowSuccessWithStatus:(NSNotification *)notification  {
    [SVProgressHUD showSuccessWithStatus:[notification.userInfo objectForKey:@"data"]];
}


//警告
- (void)SVProgressHUDshowInfoWithStatus:(NSNotification *)notification{
    [SVProgressHUD showInfoWithStatus:[notification.userInfo objectForKey:@"data"]];
}


//错误
- (void)SVProgressHUDshowErrorWithStatus:(NSNotification *)notification {
    [SVProgressHUD showErrorWithStatus:[notification.userInfo objectForKey:@"data"]];
}


//解散
- (void)SVProgressHUDdismiss:(NSNotification *)notification {
    [SVProgressHUD dismiss];
}


//上传进度
- (void)SVProgressHUDShowProgress:(NSNotification *)notification {
    [SVProgressHUD showProgress:[[notification.userInfo objectForKey:@"data"] floatValue]];
}

@end
