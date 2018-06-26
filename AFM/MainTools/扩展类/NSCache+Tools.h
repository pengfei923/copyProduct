//
//  NSCache+Tools.h
//  JiaJiaProject
//
//  Created by 张凡 on 16/1/30.
//  Copyright © 2016年 Kiwaro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCache (Tools)

- (void)write:(NSData *)data forKey:(NSString *)key;

- (NSData *)readForKey:(NSString *)key;

@end
