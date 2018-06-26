//
//  StoreTableHeaderView.h
//  AFM
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFADScrollView.h"

@class CarouselModel;
@class CarouselModelCell;


@interface StoreTableHeaderView : UIView
@property (nonatomic,strong) UIViewController *controller;
@property (nonatomic,strong) NSMutableArray *ad_array;

@end

@interface CarouselModel : NSObject
@property (nonatomic, strong) NSArray<CarouselModelCell *> *data;
@end

@interface CarouselModelCell : NSObject
@property (nonatomic, strong) NSString *add_time;          //时间
@property (nonatomic, strong) NSString *img;               //图片
@property (nonatomic, strong) NSString *Id;                //13
@property (nonatomic, strong) NSString *title;             //文字
@property (nonatomic, strong) NSString *type;              //1:首页 2:微信商城 3:APP商城
@property (nonatomic, strong) NSString *url;               //
@property (nonatomic, strong) NSString *introduce;         //
@property (nonatomic, strong) NSString *sort;              //
@property (nonatomic, strong) NSString *url_type;          // 1商品 2赛事 3新闻(此时的url字段是http链接)
@end

