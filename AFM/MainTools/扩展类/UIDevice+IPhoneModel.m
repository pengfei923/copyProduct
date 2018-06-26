//
//  UIDevice+IPhoneModel.m
//  BabyProject
//
//  Created by 张凡 on 15/12/29.
//  Copyright © 2015年 zhangfan. All rights reserved.
//

#import "UIDevice+IPhoneModel.h"

@implementation UIDevice (IPhoneModel)


/**
 *  return current running iPhone model
 *
 *  @return iPhone model
 */
+ (iPhoneModel)iPhonesModel {
    //设备的尺寸
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    
    //设备的方向
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    
    //未知
    if (UIInterfaceOrientationUnknown == orientation) {
        return UnKnown;
        
    //竖屏
    } else if (UIInterfaceOrientationPortrait == orientation) {
        if (width ==  320.0f) {
            if (height == 480.0f) {
                return iPhone4;
            } else {
                return iPhone5;
            }
        } else if (width == 375.0f) {
            return iPhone6;
        } else if (width == 414.0f) {
            return iPhone6Plus;
        }
        
        
    //横屏
    } else if (UIInterfaceOrientationLandscapeLeft == orientation ||
              UIInterfaceOrientationLandscapeRight == orientation) {
        if (height == 320.0) {
            if (width == 480.0f) {
                return iPhone4;
            } else {
                return iPhone5;
            }
        } else if (height == 375.0f) {
            return iPhone6;
        } else if (height == 414.0f) {
            return iPhone6Plus;
        }
    }
    return UnKnown;
}


/**
 *  获取系统版本号码
 *
 *  @return 版本号
 */
+ (float)getSystemVersion {
    
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

@end
