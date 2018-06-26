//
//  UIImage+Tools.h
//  BabyProject
//
//  Created by 张凡 on 15/11/5.
//  Copyright © 2015年 zhangfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tools)

/**
 *  压缩图片
 *
 *  @param image 图片
 *  @param newSize 尺寸
 *
 *  @return 图片对象
 */
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

/**
 *  压缩图片
 *
 *  @param newSize 尺寸
 *
 *  @return 图片对象
 */
- (UIImage *)imageWithImageSimpleScaledToSize:(CGSize)newSize;



#pragma mark - 保存图片到文档(文件夹)

/**
 *  保存图片到document
 *
 *  @param imageName 图片名称
 */
- (void)saveImageToDocumentsWithName:(NSString *)imageName;


#pragma mark - 保存图片到相册
/**
 *  保存图片到系统相册
 */
- (void)saveImageToPhotos;




/**
 *  图片转string
 *
 */
+ (NSString *)getImgtoString:(UIImage *)img ;




/**
 *  string转图片
 *
 */
+ (UIImage *)getStringtoImg:(NSString *)requestString;

@end
