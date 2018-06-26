//
//  UIImage+ImageWithColor.h
//  JiaJiaProject
//
//  Created by 张凡 on 16/1/19.
//  Copyright © 2016年 Kiwaro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageWithColor)

/**
 *  用颜色创建图片
 *
 *  @param color  颜色
 *  @param height 高度
 *
 *  @return 图片对象
 */
+ (UIImage*) imageWithColor:(UIColor*)color andHeight:(CGFloat)height;








@end
