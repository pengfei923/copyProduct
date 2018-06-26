//
//  NSCache+Tools.m
//  JiaJiaProject
//
//  Created by 张凡 on 16/1/30.
//  Copyright © 2016年 Kiwaro. All rights reserved.
//

#import "NSCache+Tools.h"

@implementation NSCache (Tools)


- (void)write:(NSData *)data forKey:(NSString *)key {
    
    NSString *filepath  = [self filePathForKey:key];
    
    [self setObject:data forKey:key];
    
    //    dispatch_async(fileQueue, ^{
    
    [[NSFileManager defaultManager] createFileAtPath:filepath contents:data attributes:nil];
    
    //    });
    
}



- (NSData *)readForKey:(NSString*)key {
    
    if(key == nil){
        return nil;
    }
    
    NSData *cacheData = [self objectForKey:key];
    
    if(cacheData){
        NSLog(@"cache 中获取数据:%@",key);
        return cacheData;
        
    }else{
        
        NSLog(@"cache 中没有数据:%@ 在数据库中取",key);
        NSString *filepath =[self filePathForKey:key];
        NSData *fileData =  [[NSFileManager defaultManager] contentsAtPath:filepath];
        
        if(fileData){
            [self setObject:fileData forKey:key];
        }
        return fileData;
    }
}


- (NSString *)filePathForKey:(NSString *)key {
    
    //获得文档路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    documentDirectory = [documentDirectory stringByAppendingPathComponent:key];
    
    //NSLog(@"**Path : %@",documentDirectory);

    return documentDirectory;
}

@end
