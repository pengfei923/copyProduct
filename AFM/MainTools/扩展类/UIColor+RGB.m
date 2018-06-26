//
//  UIColor+RGB.m
//  BabyProject
//
//  Created by 张凡 on 15/4/28.
//  Copyright (c) 2015年 zhangfan. All rights reserved.
//

#import "UIColor+RGB.h"

@implementation UIColor (RGB)


/**
 *  主题色
 *
 *  @return 颜色
 */
+ (UIColor *)getColorWithTheme {
    
    UIColor *colortheme = [UIColor getColorWithR:225 G:80 B:80 A:1];
    
    return colortheme;
}

/**
 *  导航色
 *
 *  @return 颜色
 */

+ (UIColor *)getColorWithNva{
    
    UIColor *colortheme = [UIColor getColorWithR:29 G:29 B:29 A:1];
    
    return colortheme;
}

/**
 *  字体颜色
 *
 *  @return 颜色
 */
+ (UIColor *)getColorWithTextTheme {

    UIColor *colortheme = [UIColor getColorWithR:62 G:70 B:81 A:1];
    
    return colortheme;
}

/**
 *  字体颜色2
 *
 *  @return 颜色
 */
+ (UIColor *)getColorWithTexts {
    
    UIColor *colortheme = [UIColor getColorWithR:102 G:102 B:102 A:1];
    
    return colortheme;
}
/**
 *  字体颜色3
 *
 *  @return 颜色
 */
+ (UIColor *)getColorWithTextLight {
    
    UIColor *colortheme = [UIColor getColorWithR:178 G:178 B:178 A:1];
    
    return colortheme;
}
/**
 *  底部颜色
 *
 *  @return 颜色
 */
+ (UIColor *)getColorWithdown {
    
    UIColor *colortheme = [UIColor getColorWithR:242 G:242 B:242 A:1];
    
    return colortheme;
}

/**
 *  背景颜色
 *
 *  @return 颜色
 */
+ (UIColor *)getColorWithBackground {
    
    UIColor *colortheme = [UIColor getColorWithR:247 G:247 B:247 A:1];//
    
    return colortheme;
}


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
+ (UIColor *)getColorWithR:(CGFloat )r G:(CGFloat )g B:(CGFloat )b A:(CGFloat )a {
    
    UIColor *colorRGB = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
    
    return colorRGB;
}



/**
 *  16进制转color
 *
 *  @param color #ffffff
 *
 *  @return UIColor
 */
+(UIColor *)getColorWith_16: (NSString *) color {
    
    //清除空格和换行
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]uppercaseString];
    
    //判断字符串长度
    if ([cString length] < 6) return [UIColor blackColor];
    //如果出现0X
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    //如果是#
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    //什么都不是
    if ([cString length] != 6) return [UIColor blackColor];
    
    //范围
    NSRange range;
    
    //R
    range.location = 0;//位置
    range.length = 2;//范围
    NSString *rString = [cString substringWithRange:range];
    
    //G
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //B
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];

    //无符号的整形变量
    unsigned int r, g, b;
    
    //转换
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    //返回颜色
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}





@end
