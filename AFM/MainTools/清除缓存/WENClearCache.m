//
//  WENClearCache.m
//  CarServiceO2O
//
//  Created by HS001 on 16/8/26.
//  Copyright © 2016年 华四MAC. All rights reserved.
//

#import "WENClearCache.h"

#define fileManager [NSFileManager defaultManager]

@implementation WENClearCache
//获取path路径下文件夹大小
+ (NSString *)getCacheSizeWithFilePath:(NSString *)path {
    //调试
#ifdef DEBUG
    //如果文件夹不存在或者不是一个文件夹那么就抛出一个异常
    //抛出异常会导致程序闪退，所以只在调试阶段抛出，发布阶段不要再抛了,不然极度影响用户体验
    BOOL isDirectory = NO;
    BOOL isExist = [fileManager fileExistsAtPath:path isDirectory:&isDirectory];
    if (!isExist || !isDirectory) {
        NSException *exception = [NSException exceptionWithName:@"fileError" reason:@"please check your filePath!" userInfo:nil];
        [exception raise];
        
    }
    //发布
#else
    NSLog(@"post");
#endif
    
    NSArray *subPathArr = [fileManager subpathsAtPath:path];

    NSString *filePath  = nil;
    NSInteger totleSize = 0;
    
    for (NSString *subPath in subPathArr){
        
        // 1. 拼接每一个文件的全路径
        filePath =[path stringByAppendingPathComponent:subPath];
        // 2. 是否是文件夹，默认不是
        BOOL isDirectory = NO;
        // 3. 判断文件是否存在
        BOOL isExist = [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
        
        // 4. 以上判断目的是忽略不需要计算的文件
        if (!isExist || isDirectory || [filePath containsString:@".DS"]){
            // 过滤: 1. 文件夹不存在  2. 过滤文件夹  3. 隐藏文件
            continue;
        }
        
        // 5. 指定路径，获取这个路径的属性
        NSDictionary *dict = [fileManager attributesOfItemAtPath:filePath error:nil];
        /**
         attributesOfItemAtPath: 文件夹路径
         该方法只能获取文件的属性, 无法获取文件夹属性, 所以也是需要遍历文件夹的每一个文件的原因
         */
        
        // 6. 获取每一个文件的大小
        NSInteger size = [dict[@"NSFileSize"] integerValue];
        
        // 7. 计算总大小
        totleSize += size;
    }
   
    //将文件夹大小转换为 M/KB/B
    NSString *totleStr = nil;
    
    if (totleSize > 1000 * 1000) {
        totleStr = [NSString stringWithFormat:@"%.1fM",totleSize / 1000.0f /1000.0f];
    }else if (totleSize > 1000) {
        totleStr = [NSString stringWithFormat:@"%.1fKB",totleSize / 1000.0f ];
        
    }else {
        totleStr = [NSString stringWithFormat:@"%.1fB",totleSize / 1.0f];
    }
    
    return totleStr;
    
    
}


//清除path文件夹下缓存大小
+ (BOOL)clearCacheWithFilePath:(NSString *)path {
    
    //拿到path路径的下一级目录的子文件夹
    NSArray *subpathArray = [fileManager contentsOfDirectoryAtPath:path error:nil];
    NSString *message = nil;
    NSError *error = nil;
    NSString *filePath = nil;
    
    for (NSString *subpath in subpathArray){
        filePath =[path stringByAppendingPathComponent:subpath];
        //删除子文件夹
        [fileManager removeItemAtPath:filePath error:&error];
        if (error) {
            message = [NSString stringWithFormat:@"%@这个路径的文件夹删除失败了，请检查后重新再试",filePath];
            return NO;
            
        }else {
            message = @"成功了";
        }
        
    }
    NSLog(@"%@",message);
    
    return YES;
    
}



@end
