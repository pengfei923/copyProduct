//
//  Top_PlayerTableViewCell.h
//  AFM
//
//  Created by admin on 2017/9/14.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNChart.h"
#import "PlayerInfoViewController.h"

@interface Top_PlayerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon_ImgV;
@property (weak, nonatomic) IBOutlet UILabel *name_Lab;
@property (weak, nonatomic) IBOutlet UILabel *money_Lab;
@property (weak, nonatomic) IBOutlet UILabel *work_Lab;
@property (weak, nonatomic) IBOutlet UILabel *time_Lab;
@property (weak, nonatomic) IBOutlet UILabel *vs_Lab;


@property (weak, nonatomic) IBOutlet UILabel *defen_Lab;
@property (weak, nonatomic) IBOutlet UILabel *sanfen_Lab;
@property (weak, nonatomic) IBOutlet UILabel *lanban_Lab;
@property (weak, nonatomic) IBOutlet UILabel *zhugong_Lab;
@property (weak, nonatomic) IBOutlet UILabel *qiangd_Lab;
@property (weak, nonatomic) IBOutlet UILabel *fengg_Lab;
@property (weak, nonatomic) IBOutlet UILabel *shiwu_Lab;


//进度圈
@property (weak, nonatomic) IBOutlet UIView *lableview;
@property (weak, nonatomic) IBOutlet UIView *Lableview1;
@property (weak, nonatomic) IBOutlet UIView *Lableview2;

@property (strong, nonatomic) PNCircleChart *chart;
@property (strong, nonatomic) PNCircleChart *chart1;
@property (strong, nonatomic) PNCircleChart *chart2;


//曲线图
@property (weak, nonatomic) IBOutlet UIView *quView;

@property (nonatomic , strong) Player_ModelCell *Model;

@property (nonatomic , strong) Player_ListModelCell  *JCPlayer;
@property (nonatomic , strong) NSString *play_num;    //
@property (nonatomic , strong) NSString *play_time;    //
@property (nonatomic , strong) NSString *pjfen;    //

@end
