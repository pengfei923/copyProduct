//
//  PlayerTableViewCell.h
//  AFM
//
//  Created by admin on 2017/9/14.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerChooseViewController.h"
@interface PlayerTableViewCell : UITableViewCell

@property (nonatomic , strong) Player_ListModelCell *Model;          //



@property (weak, nonatomic) IBOutlet UILabel *biao_Lab;
@property (weak, nonatomic) IBOutlet UIButton *icon_Btn;
@property (weak, nonatomic) IBOutlet UILabel *daiD_Lab;  //待定
@property (weak, nonatomic) IBOutlet UILabel *name_Lab;
@property (weak, nonatomic) IBOutlet UILabel *price_Lab;
@property (weak, nonatomic) IBOutlet UILabel *pingJ_Lab;
@property (weak, nonatomic) IBOutlet UILabel *time_Lab;
@property (weak, nonatomic) IBOutlet UILabel *leftD_Lab;
@property (weak, nonatomic) IBOutlet UILabel *vsD_Lab;
@property (weak, nonatomic) IBOutlet UIImageView *icon_Img;

//曲线
@property (weak, nonatomic) IBOutlet UIView *qulineView;
@property (weak, nonatomic) IBOutlet UIView *NOview;



@property (weak, nonatomic) IBOutlet UILabel *weizhi_lab;//大前（已选）
@property (weak, nonatomic) IBOutlet UIButton *add_Btn;

@end
