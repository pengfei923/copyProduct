//
//  OpenShareComponent.h
//  CarServiceTrafficViolator
//
//  Created by 张凡 on 2017/3/20.
//  Copyright © 2017年 张凡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenShare.h"

@interface OpenShareComponent : NSObject
+ (void)registered;//分享及登入
+ (void)goShareMessage:(NSString *)message Url:(NSString *)url Img:(NSString *)image;
+ (void)goShareWEB:(NSString *)message Url:(NSString *)url Img:(UIImage *)image ;//分享网页
@end
