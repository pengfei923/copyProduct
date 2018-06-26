//
//  WNo_ZRinfoTableViewCell.h
//  AFM
//
//  Created by 年少 on 2017/9/30.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SK_WeiModel.h"

@interface WNo_ZRinfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *downView;
@property (weak, nonatomic) IBOutlet UIImageView *icon_Img;
@property (weak, nonatomic) IBOutlet UILabel *name_Lab;
//-----------
@property (weak, nonatomic) IBOutlet UILabel *menp_Lab;
@property (weak, nonatomic) IBOutlet UILabel *JL_Lab;
@property (weak, nonatomic) IBOutlet UILabel *Znum_Lab;
@property (weak, nonatomic) IBOutlet UIView *addZ_View;
@property (weak, nonatomic) IBOutlet UILabel *addZ_Lab;
@property (weak, nonatomic) IBOutlet UILabel *add_Lable;

@property (weak, nonatomic) IBOutlet UIButton *add_Btn;


//---------
@property (weak, nonatomic) IBOutlet UILabel *time_Lab;

@property (weak, nonatomic) IBOutlet UIImageView *biao_image1;
@property (weak, nonatomic) IBOutlet UIImageView *biao_image2;
@property (weak, nonatomic) IBOutlet UIImageView *biao_image3;


@property (nonatomic , strong) SK_Wei_RoomInfoData *model;




@end
