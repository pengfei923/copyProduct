//
//  BaseViewController.h
//  CarServiceO2O
//
//  Created by admin on 2017/8/28.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabBarController.h"


@interface BaseViewController : UIViewController
//缓存对象
@property (nonatomic , strong) AppCache *appCache;
//view的宽度
@property (nonatomic) float mainWidth;
//view的高度
@property (nonatomic) float mainHeight;


//返回
-(void)BackViewAction:(UIButton *)sender;
//判断是否登录
-(BOOL)getUpLoginBool;



@end
