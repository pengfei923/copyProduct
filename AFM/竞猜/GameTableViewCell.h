//
//  GameTableViewCell.h
//  AFM
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;              //底部
@property (weak, nonatomic) IBOutlet UILabel *name_Lab;
@property (weak, nonatomic) IBOutlet UIImageView *icon_LImgView;     //左上角图标
@property (weak, nonatomic) IBOutlet UIImageView *icon_backImageView;//标题背景
@property (weak, nonatomic) IBOutlet UILabel *mengP_Lab;            //门票lab
@property (weak, nonatomic) IBOutlet UILabel *jiangL_Lab;           //奖励lab
@property (weak, nonatomic) IBOutlet UILabel *canY_Lab;             //参与lab
@property (weak, nonatomic) IBOutlet UILabel *canN_Lab;             //未参与lab
@property (weak, nonatomic) IBOutlet UILabel *isCanyu;              //参与

@property (weak, nonatomic) IBOutlet UIImageView *JL_inageView;      //奖励图标
@property (weak, nonatomic) IBOutlet UILabel *time_Lab;             //时间

@property (weak, nonatomic) IBOutlet UIImageView *biao_image1;       //标签
@property (weak, nonatomic) IBOutlet UIImageView *biao_image2;       //标签
@property (weak, nonatomic) IBOutlet UIImageView *biao_image3;       //标签

@end
