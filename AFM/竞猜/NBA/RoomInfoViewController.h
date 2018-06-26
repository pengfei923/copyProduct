//
//  RoomInfoViewController.h
//  AFM
//
//  Created by admin on 2017/9/12.
//  Copyright © 2017年 sgamer. All rights reserved.
//

@class RoomNew_listData;
@class RoomNew_listDataCell;

#import "BaseViewController.h"

@interface RoomInfoViewController : BaseViewController
@property (nonatomic , strong) NSString *Id;                    //房间id号
@property (nonatomic , strong) NSString *price;                 //门票数
@property (nonatomic , strong) NSString *allow_uguess_num;      //允许用户投注总数
@property (nonatomic , strong) NSString *join_num;              //自己已经投注了的总数
@property (nonatomic , strong) NSString *name;                  //房间名
@property (nonatomic , strong) NSString *iconImg;               //房间图标
@property (nonatomic , strong) NSString *lol_dota_nba;          //lol/dota/nba


@property (nonatomic , strong) NSNumber *GZall;               //房间允许工资总数



@end



@interface RoomNew_listData : NSObject
@property (nonatomic, strong) NSArray<RoomNew_listDataCell *> *data;
@end

@interface RoomNew_listDataCell : NSObject
@property (nonatomic , strong) NSString *Id;                         //新闻id号"
@property (nonatomic , strong) NSString *img;                        //新闻图片"
@property (nonatomic , strong) NSString *title;                      //新闻内容
@property (nonatomic , strong) NSString *views;                      //阅读量
@property (nonatomic , strong) NSString *href;                       //详情地址

@end

