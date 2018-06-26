//
//  SJPlayer_NBATableViewCell.h
//  AFM
//
//  Created by admin on 2017/11/14.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerInfoViewController.h"

@interface SJPlayer_NBATableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *downView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic , strong) UITableView *tableView2;

@property (weak, nonatomic) IBOutlet UIButton *JinS_Btn;
@property (weak, nonatomic) IBOutlet UIButton *All_Btn;
@property (weak, nonatomic) IBOutlet UIButton *ZhuC_Btn;
@property (weak, nonatomic) IBOutlet UIButton *KeC_Btn;

@property (nonatomic , strong) NSString *deF;    //
@property (nonatomic , strong) NSString *sanF;    //
@property (nonatomic , strong) NSString *lanB;    //
@property (nonatomic , strong) NSString *zhuG;    //
@property (nonatomic , strong) NSString *qiangD;    //
@property (nonatomic , strong) NSString *fengG;    //
@property (nonatomic , strong) NSString *shiW;    //
@property (nonatomic , strong) NSString *play_num;    //
@property (nonatomic , strong) NSString *play_time;    //
@property (nonatomic , strong) NSString *jiF;    //
@property (nonatomic , strong) NSString *time;    //

@property (nonatomic , strong) Player_ModelCell  *model;

@end
