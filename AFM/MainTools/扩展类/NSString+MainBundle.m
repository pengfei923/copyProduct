//
//  NSString+MainBundle.m
//  LepeiLeshu
//
//  Created by 张凡 on 16/3/22.
//  Copyright © 2016年 Mondeo. All rights reserved.
//

#import "NSString+MainBundle.h"
#import "sys/utsname.h"

@implementation NSString (MainBundle)



/**
 *  获取外部版本号 (Version)
 *
 *  @return
 */
+ (NSString *)getVersion {
    
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    
    NSString *version = info[@"CFBundleShortVersionString"];
    
    return version;
}



/**
 *  获取内部版本号 (Build)
 *
 *  @return
 */
+ (NSString *)getBuild {
    
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    
    NSString *Build = info[@"CFBundleVersion"];
    
    return Build;
}



/**
 *  获取APP名字
 *
 *  @return
 */
+ (NSString *)getAppName {

    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    
    NSString *name = info[@"CFBundleName"];
    
    return name;
}





/**
 *  判断设备类型
 *
 *  @return 设备类型名称
 */
+ (NSString*)deviceString{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone1,1"])return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,2"])return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone3,2"])return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPod1,1"])return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"i386"]) return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"]) return @"Simulator";
    NSLog(@"NOTE: Unknown device type: %@", deviceString);
    return deviceString;
}


@end
