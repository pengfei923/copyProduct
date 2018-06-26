//
//  AppDelegate.h
//  AFM
//
//  Created by admin on 2017/8/28.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (void)notificationRequestStart:(NSString *)data;              //开始请求
+ (void)notificationRequestStartWithStatus:(NSString *)data;    //开始请求并提示
+ (void)notificationRequestSuccessWithStatus:(NSString *)data;  //请求完成并提示
+ (void)notificationRequestComplete:(NSString *)data;           //请求完成并解散
+ (void)notificationRequestInfoWithStatus:(NSString *)data;     //请求警告
+ (void)notificationRequestError:(NSString *)data;              //请求错误
+ (void)notificationRequestShowProgress:(float)data;            //上传进度

@end

