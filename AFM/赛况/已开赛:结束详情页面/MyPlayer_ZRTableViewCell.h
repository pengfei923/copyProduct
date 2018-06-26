//
//  MyPlayer_ZRTableViewCell.h
//  AFM
//
//  Created by admin on 2017/9/21.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SK_InfoModel.h"

@interface MyPlayer_ZRTableViewCell : UITableViewCell




@property (nonatomic , strong) SK_InfoLineup_PlayerData *Model;        //
@property (nonatomic , strong) NSString *nba_lol_dota;          //


@property (weak, nonatomic) IBOutlet UIButton *icon_Btn;
@property (weak, nonatomic) IBOutlet UIImageView *icon_IMG;

@property (weak, nonatomic) IBOutlet UILabel *biao_lab;
@property (weak, nonatomic) IBOutlet UILabel *name_Lab;
@property (weak, nonatomic) IBOutlet UILabel *GZ_Lab;
@property (weak, nonatomic) IBOutlet UILabel *JF_Lab;
@property (weak, nonatomic) IBOutlet UILabel *dui1_lab;
@property (weak, nonatomic) IBOutlet UILabel *dui2_lab;
@property (weak, nonatomic) IBOutlet UILabel *num1_lab;
@property (weak, nonatomic) IBOutlet UILabel *num2_lab;

@property (weak, nonatomic) IBOutlet UILabel *state_M;


//nba-----
@property (weak, nonatomic) IBOutlet UIView *nbaView;
@property (weak, nonatomic) IBOutlet UILabel *deF_L;
@property (weak, nonatomic) IBOutlet UILabel *sanF_Lab;
@property (weak, nonatomic) IBOutlet UILabel *lanB_Lab;
@property (weak, nonatomic) IBOutlet UILabel *zhuG_Lab;
@property (weak, nonatomic) IBOutlet UILabel *qiangD_Lab;
@property (weak, nonatomic) IBOutlet UILabel *fengG_Lab;
@property (weak, nonatomic) IBOutlet UILabel *shiW_Lab;

//lol_dota-----
@property (weak, nonatomic) IBOutlet UIView *lol_dotaView;
@property (weak, nonatomic) IBOutlet UILabel *jiS_Lab;
@property (weak, nonatomic) IBOutlet UILabel *zhuG_lab;
@property (weak, nonatomic) IBOutlet UILabel *siW_Lab;
@property (weak, nonatomic) IBOutlet UILabel *BuD_lab;
@property (weak, nonatomic) IBOutlet UILabel *kda_Lab;
@property (weak, nonatomic) IBOutlet UIButton *is_join;

@end
