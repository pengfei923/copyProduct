//
//  ZRTableViewCell.h
//  AFM
//
//  Created by admin on 2017/9/15.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaveZRViewController.h"

@class RoomInfoReward_ruleData;

@interface ZRTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *ZR_lab;
@property (weak, nonatomic) IBOutlet UIButton *ZR_Btn;
@property (weak, nonatomic) IBOutlet UILabel *XZ_Lab;
@property (weak, nonatomic) IBOutlet UILabel *ZRJF_Lab;
@property (weak, nonatomic) IBOutlet UILabel *GZ_Lab;

@property (nonatomic, strong) ZR_ModelDataCell *model;


@property (nonatomic , strong) NSString *nba_lol_data;      //竞猜类型


@end


@interface ZR_MyPlayer_Info : NSObject
@property (nonatomic , strong) NSString *Id;      //
@property (nonatomic , assign) double *KDA;      //
@property (nonatomic , assign) double average;          //平均分
@property (nonatomic , strong) NSString *img;      //
@property (nonatomic , strong) NSString *name;      //
@property (nonatomic , strong) NSString *position;      //
@property (nonatomic , strong) NSString *result;      //
@property (nonatomic , strong) NSString *salary;      //
@property (nonatomic , strong) NSString *team_id;      //



@end

