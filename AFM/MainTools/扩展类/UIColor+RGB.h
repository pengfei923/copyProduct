//
//  UIColor+RGB.h
//  BabyProject
//
//  Created by 张凡 on 15/4/28.
//  Copyright (c) 2015年 zhangfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RGB)

/**
 *  主题色
 *
 *  @return 颜色
 */
+ (UIColor *)getColorWithTheme;
+ (UIColor *)getColorWithNva;


/**
 *  字体颜色
 *
 *  @return 颜色
 */
+ (UIColor *)getColorWithTextTheme;

+ (UIColor *)getColorWithTexts;

+ (UIColor *)getColorWithTextLight; 

/**
 *  背景颜色
 *
 *  @return 颜色
 */
+ (UIColor *)getColorWithdown;

+ (UIColor *)getColorWithBackground;

/**
 *  颜色自定义
 *
 *  @param r 红色域
 *  @param g 绿色域
 *  @param b 蓝色域
 *  @param a 透明度
 *
 *  @return 颜色
 */
+ (UIColor *)getColorWithR:(CGFloat )r G:(CGFloat )g B:(CGFloat )b A:(CGFloat )a;




/**
 *  16进制转color
 *
 *  @param color #ffffff
 *
 *  @return UIColor
 */
+(UIColor *)getColorWith_16: (NSString *) color;

@end
