//
//  ZFRefreshGif.m
//  BabyProject
//
//  Created by 张凡 on 15/7/23.
//  Copyright (c) 2015年 zhangfan. All rights reserved.
//

#import "ZFRefreshGifHeader.h"

@implementation ZFRefreshGifHeader

#pragma mark - 重写方法
#pragma mark 基本设置

- (void)prepare {
    [super prepare];
    
    UIImage *img0 = [UIImage imageNamed:@"LodingImage-0"];
    UIImage *img1 = [UIImage imageNamed:@"LodingImage-1"];
    UIImage *img2 = [UIImage imageNamed:@"LodingImage-2"];
    UIImage *img3 = [UIImage imageNamed:@"LodingImage-3"];
    UIImage *img4 = [UIImage imageNamed:@"LodingImage-4"];
    UIImage *img5 = [UIImage imageNamed:@"LodingImage-5"];
    UIImage *img6 = [UIImage imageNamed:@"LodingImage-6"];
    
    NSMutableArray *idleImages = [NSMutableArray arrayWithObjects:img0,img1,img2,img3,img4,img5,img6, nil];
    NSMutableArray *pullingImages = [NSMutableArray arrayWithObjects:img0,img1,img2,img3,img4,img5,img6,img5,img4,img3,img2,img1,img0, nil];
    NSMutableArray *refreshingImages = [NSMutableArray arrayWithObjects:img0,img1,img2,img3,img4,img5,img6,img5,img4,img3,img2,img1,img0, nil];
    
    [self setImages:idleImages forState:MJRefreshStateIdle];
    [self setImages:pullingImages forState:MJRefreshStatePulling];
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    self.lastUpdatedTimeLabel.hidden = YES;// 隐藏时间
    self.stateLabel.hidden = YES;// 隐藏状态
}

@end
