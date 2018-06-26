//
//  SaveZRViewController.h
//  AFM
//
//  Created by admin on 2017/9/15.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BaseViewController.h"


@class ZR_ModelData;
@class ZR_ModelDataCell;
@class lineup_ModelInfo;

typedef void (^numZRblock) (NSString *zr_NUM);//阵容个数
typedef void (^chooseZRblock) (ZR_ModelDataCell *Model);

@interface SaveZRViewController : BaseViewController
@property(nonatomic, copy) numZRblock numZRblock;//阵容个数
@property(nonatomic, copy) chooseZRblock chooseZRblock;

@property (nonatomic , strong) NSString *type_TT;    //获取阵容类型2已存1推荐
@property (nonatomic , strong) NSString *ID;    //
@property (nonatomic , strong) NSString *NUM;      //已存阵容个数
@property (nonatomic , strong) NSString *nba_lol_data;      //竞猜类型

@end



@interface ZR_ModelData : NSObject
@property (nonatomic, strong) NSArray<ZR_ModelData *> *data;

@end

@interface ZR_ModelDataCell : NSObject
@property (nonatomic , strong) NSString *Id;                   //id号"
@property (nonatomic , strong) NSString *lineup_id;                        //
@property (nonatomic , strong) NSString *type;                      //
@property (nonatomic , strong) NSString *join_room_num;                      //
@property (nonatomic , strong) NSString *salary_sum;                        //工资总和
@property (nonatomic , assign) double   lineup_score;                        //阵容得分
@property (nonatomic , strong) NSString *project_id;                        //


@property (nonatomic, strong) NSDictionary *lineup;
@property (nonatomic, strong) NSDictionary *lineup_info;

@end



@interface lineup_ModelInfo : NSObject
@property (nonatomic , assign) double   average;             //平均分
@property (nonatomic , strong) NSString *Id;      //
@property (nonatomic , strong) NSString *img;      //
@property (nonatomic , strong) NSString *name;      //
@property (nonatomic , assign) NSInteger *KDA;      //
@property (nonatomic , strong) NSString *position;      //
@property (nonatomic , strong) NSString *result;      //
@property (nonatomic , strong) NSString *team_id;      //
@property (nonatomic , strong) NSString *salary;      // 工资
@property (nonatomic , strong) NSString *number;         //


@end





