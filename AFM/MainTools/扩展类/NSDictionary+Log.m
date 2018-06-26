//
//  NSDictionary+Log.m
//  BabyProject
//
//  Created by 张凡 on 15/10/13.
//  Copyright © 2015年 zhangfan. All rights reserved.
//

#import "NSDictionary+Log.h"

@implementation NSDictionary (Log)

- (NSString *)description {
    
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
     
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}

@end
