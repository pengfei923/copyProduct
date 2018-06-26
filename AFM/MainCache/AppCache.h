//
//  AppCache.h
//  LepeiLeshu
//
//  Created by 王恩年 on 17/8/28.
//  Copyright © 2017年 Mondeo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYCache/YYCache.h>
#import "BaseModel.h"
#import "UserInfoModel.h"
//----------------------------
#import "HomeTableHeaderView.h"

@interface AppCache : NSObject
+(AppCache *)sharedInstance;
@property(nonatomic , strong) YYDiskCache *yycache;
@property(nonatomic , strong) NSString *bundleName;                 //苹果商店显示名称
@property(nonatomic , strong) NSString *bundleShortVersion;         //苹果商店显示版本号
@property(nonatomic , strong) NSString *bundleVersion;              //开发版本号
@property(nonatomic , strong) NSString *registrationID;             //极光推送
@property(nonatomic , strong) NSString *token;                      //验证秘钥
@property(nonatomic , strong) NSString *menPiao;                    //门票总数
@property(nonatomic , strong) NSString *Zuanshi;                    //钻石总数
@property(nonatomic , strong) NSString *Status;                     //是否商城
@property(nonatomic , strong) NSString *gold;                       //木头总数
@property(nonatomic , assign) NSInteger userMsgNoReadCount;         //个人信息未读数量
@property(nonatomic , assign) NSInteger systemMsgNoReadCount;       //系统消息未读数量

#pragma mark - 登录信息
@property(nonatomic) bool deviceFirst;                            //用户是不是第一次登陆
@property(nonatomic , strong) NSString *accountPhone;               //账号(手机号)
@property(nonatomic , strong) UserInfoModel *loginViewModel;         //用户登录信息



@property(nonatomic , strong) HeaderModel *homeAdmodel;  //轮播

@end
