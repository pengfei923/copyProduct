//
//  SK_Ing_EdInfoViewController.h
//  AFM
//
//  Created by admin on 2017/9/22.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BaseViewController.h"


@interface SK_Ing_EdInfoViewController : BaseViewController


@property (nonatomic , strong) NSString *ronmName;          //房间名
@property (nonatomic , strong) NSString *ID;          //ID
@property (nonatomic , strong) NSString *roomID;      //roomID
@property (nonatomic , strong) NSString *ZHUnum;      //注数
@property (nonatomic , strong) NSString *myPM;        //我的排名
@property (nonatomic , strong) NSString *zPM;         //总排名
@property (nonatomic , strong) NSString *project_id;  // 区分nba、lol、DOTA


@property (nonatomic , strong) NSString *IMG;           //我的头像
@property (nonatomic , strong) NSString *GJ_num;        //冠军积分
@property (nonatomic , strong) NSString *my_num;        //我的积分
@property (nonatomic , strong) NSString *HJ_num;        //获奖积分



//----------TOP---------------
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIView *line3;
@property (weak, nonatomic) IBOutlet UIView *line4;



//------------tableview----------




@end
