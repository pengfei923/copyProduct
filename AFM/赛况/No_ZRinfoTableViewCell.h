//
//  No_ZRinfoTableViewCell.h
//  AFM
//
//  Created by admin on 2017/9/26.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SK_WeiModel.h"


@interface No_ZRinfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *downView;
@property (weak, nonatomic) IBOutlet UIImageView *icon_Img;
@property (weak, nonatomic) IBOutlet UILabel *name_Lab;



@property (weak, nonatomic) IBOutlet UILabel *DQPM_Lab;
@property (weak, nonatomic) IBOutlet UILabel *JL_Lab;
@property (weak, nonatomic) IBOutlet UILabel *Znum_Lab;

@property (weak, nonatomic) IBOutlet UIImageView *myIcon_Img; //头像
@property (weak, nonatomic) IBOutlet UILabel *my_Lab;
@property (weak, nonatomic) IBOutlet UILabel *jiang_lab;
@property (weak, nonatomic) IBOutlet UILabel *mostJ_lab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *jindu_Constraint;

@property (nonatomic , strong) SK_Wei_RoomInfoData *model;


@end
