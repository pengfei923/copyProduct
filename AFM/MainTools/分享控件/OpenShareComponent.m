//
//  OpenShareComponent.m
//  CarServiceTrafficViolator
//
//  Created by 张凡 on 2017/3/20.
//  Copyright © 2017年 张凡. All rights reserved.
//

#import "OpenShareComponent.h"
#import "OpenShareHeader.h"
#import "TRZXShareManager.h"
#import "AppDelegate.h"


//微信
static NSString *const kWeiXinAppId         = @"wxe43bb7bc7cb3367d";
static NSString *const kWeiXinAppSecret     = @"c7e44ed43c2394173d072e2056f333bd";

//QQ
static NSString *const kQQAppID             = @"101420897";
static NSString *const kQQAppSecret         = @"9e1a1933917c3d93e109315e23871d29";

//微博
static NSString *const kSinaAppID           = @"1037790589";
static NSString *const kSinaAppSecret       = @"820a6717fe84830a6f0e97696947355e";

@implementation OpenShareComponent
    
//注册友盟分享及登入
+ (void)registered {
    [OpenShare connectQQWithAppId:kQQAppID];
    [OpenShare connectWeixinWithAppId:kWeiXinAppId];
    [OpenShare connectWeiboWithAppKey:kSinaAppID];
}
    
    
//分享APP
+ (void)goShareMessage:(NSString *)message Url:(NSString *)url Img:(NSString *)image {
    [[self class] goShareWEB:message Url:url Img:[UIImage imageNamed:image]];
}
    
    
    
//分享网页
+ (void)goShareWEB:(NSString *)message Url:(NSString *)url Img:(UIImage *)image {

    OSMessage *msg = [[OSMessage alloc]init];
    msg.title = message;
    msg.desc = [NSString getAppName];
    msg.link = url;
    msg.image = image;//缩略图
    
    [[TRZXShareManager sharedManager]showTRZXShareViewMessage:msg handler:^(TRZXShareType type) {
        if (type == TRZXShareTypeToCopy) {
            [AppDelegate notificationRequestSuccessWithStatus:@"复制链接成功"];
        }
    }];
}
@end
