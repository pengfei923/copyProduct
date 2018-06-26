//
//  UIDevice+IPhoneModel.h
//  BabyProject
//
//  Created by 张凡 on 15/12/29.
//  Copyright © 2015年 zhangfan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(char, iPhoneModel){//0~3
    iPhone4,    //320*480
    iPhone5,    //320*568
    iPhone6,    //375*667
    iPhone6Plus,//414*736
    UnKnown     //未知
};

@interface UIDevice (IPhoneModel)

/**
 *  return current running iPhone model
 *
 *  @return iPhone model
 */
+ (iPhoneModel)iPhonesModel;



/**
 *  获取系统版本号码
 *
 *  @return 版本号
 */
+ (float)getSystemVersion;

@end
