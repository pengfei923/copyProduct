//
//  NSString+MainBundle.h
//  LepeiLeshu
//
//  Created by 张凡 on 16/3/22.
//  Copyright © 2016年 Mondeo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MainBundle)


/**
 *  获取外部版本号 (Version)
 *
 */
+ (NSString *)getVersion;



/**
 *  获取内部版本号 (Build)
 *
 */
+ (NSString *)getBuild;


/**
 *  获取APP名字
 *
 */
+ (NSString *)getAppName;


/**
 *  判断设备类型
 *
 *  @return 设备类型名称
 */
+ (NSString *)deviceString;

@end
