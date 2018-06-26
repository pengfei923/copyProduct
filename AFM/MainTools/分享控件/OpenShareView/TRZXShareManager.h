//
//  TRZXShareManager.h
//  TRZXShare
//
//  Created by N年後 on 2017/3/14.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenShareHeader.h"

/**
 第三方分享类型
 */
typedef enum : NSUInteger {
    TRZXShareTypeToCopy,            // 复制
    TRZXShareTypeToWeixin,          // 微信好友
    TRZXShareTypeToWeixinTimeline,  // 微信时间线
    TRZXShareTypeToQQFriends,       // QQ好友
    TRZXShareTypeToQQZone,          // QQ空间
    TRZXShareTypeToSina             // 新浪微博
} TRZXShareType;

@interface TRZXShareManager : NSObject
+ (instancetype)sharedManager;

- (void)showTRZXShareViewMessage:(OSMessage*)message handler:(void (^)(TRZXShareType type))handler;
- (void)hideTRZXShareViewMessage;
@end
