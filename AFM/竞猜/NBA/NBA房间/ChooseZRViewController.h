//
//  ChooseZRViewController.h
//  AFM
//
//  Created by admin on 2017/9/13.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BaseViewController.h"
#import "PNChart.h"

@class NBA_PlayerListModel;
@class NBA_PlayerListModelCell;



@interface ChooseZRViewController : BaseViewController

@property (nonatomic , strong) NSString *Id;                  //房间id号
@property (nonatomic , strong) NSString *name;                //房间名
@property (nonatomic , strong) NSString *iconImg;             //房间图标
@property (nonatomic , strong) NSString *price;               //门票数
@property (nonatomic , strong) NSString *guess_num;           //自己投注数
@property (nonatomic , strong) NSString *allow_uguess_num;    //允许用户投注总数
@property (nonatomic , strong) NSString *allow_guess_num;     //允许投注总数
@property (nonatomic , strong) NSString *now_guess_num;       //现在投注数
@property (nonatomic , strong) NSString *join_num;            //自己参加次数
@property (nonatomic , strong) NSString *SY_num;              //自己参加剩余次数
@property (nonatomic , strong) NSString *type_num;             //5人房-1/8人房-4

@property (nonatomic , strong) NSArray *IdArr;             //选手id数组
@property (nonatomic , strong) NSDictionary *IdDic;         //选手id数组

@property (nonatomic , strong) NSString *C_lineup_ID;      //清除阵容时需要

@property (nonatomic , strong) NSString *num;              //已存阵容个数
@property (nonatomic , strong) NSMutableArray *playerArr;   //回调选手信息
@property (nonatomic , assign) NSInteger TIME_mast;        //距离开始的时间
@property (nonatomic , assign) NSNumber *allGZ;            //可用的总工资


//根据屏幕调整中间球场的位置
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *Center_Lay;

//-------------------上----------------

@property (weak, nonatomic) IBOutlet UILabel *tome_Lab;
@property (weak, nonatomic) IBOutlet UILabel *PJLab;
@property (weak, nonatomic) IBOutlet UILabel *Price_Lab;


//-------------------中间----------------
@property (weak, nonatomic) IBOutlet UIView *OView1;
@property (weak, nonatomic) IBOutlet UIView *SEL_View1;
@property (weak, nonatomic) IBOutlet UIView *SliderView1;
@property (weak, nonatomic) IBOutlet UIView *C_View1;
@property (weak, nonatomic) IBOutlet UIView *S_View1;
@property (weak, nonatomic) IBOutlet UILabel *name1;
@property (weak, nonatomic) IBOutlet UIImageView *Player_Icon1;
@property (weak, nonatomic) IBOutlet UILabel *wei_Lab1;
@property (weak, nonatomic) IBOutlet UILabel *gz_Lab1;

@property (weak, nonatomic) IBOutlet UIView *OView2;
@property (weak, nonatomic) IBOutlet UIView *SEL_View2;
@property (weak, nonatomic) IBOutlet UIView *SliderView2;
@property (weak, nonatomic) IBOutlet UIView *C_View2;
@property (weak, nonatomic) IBOutlet UIView *S_View2;
@property (weak, nonatomic) IBOutlet UILabel *name2;
@property (weak, nonatomic) IBOutlet UIImageView *Player_Icon2;
@property (weak, nonatomic) IBOutlet UILabel *wei_Lab2;
@property (weak, nonatomic) IBOutlet UILabel *gz_Lab2;

@property (weak, nonatomic) IBOutlet UIView *OView3;
@property (weak, nonatomic) IBOutlet UIView *SEL_View3;
@property (weak, nonatomic) IBOutlet UIView *SliderView3;
@property (weak, nonatomic) IBOutlet UIView *C_View3;
@property (weak, nonatomic) IBOutlet UIView *S_View3;
@property (weak, nonatomic) IBOutlet UILabel *name3;
@property (weak, nonatomic) IBOutlet UIImageView *Player_Icon3;
@property (weak, nonatomic) IBOutlet UILabel *wei_Lab3;
@property (weak, nonatomic) IBOutlet UILabel *gz_Lab3;

@property (weak, nonatomic) IBOutlet UIView *OView4;
@property (weak, nonatomic) IBOutlet UIView *SEL_View4;
@property (weak, nonatomic) IBOutlet UIView *SliderView4;
@property (weak, nonatomic) IBOutlet UIView *C_View4;
@property (weak, nonatomic) IBOutlet UIView *S_View4;
@property (weak, nonatomic) IBOutlet UILabel *name4;
@property (weak, nonatomic) IBOutlet UIImageView *Player_Icon4;
@property (weak, nonatomic) IBOutlet UILabel *wei_Lab4;
@property (weak, nonatomic) IBOutlet UILabel *gz_Lab4;

@property (weak, nonatomic) IBOutlet UIView *OView5;
@property (weak, nonatomic) IBOutlet UIView *SEL_View5;
@property (weak, nonatomic) IBOutlet UIView *SliderView5;
@property (weak, nonatomic) IBOutlet UIView *C_View5;
@property (weak, nonatomic) IBOutlet UIView *S_View5;
@property (weak, nonatomic) IBOutlet UILabel *name5;
@property (weak, nonatomic) IBOutlet UIImageView *Player_Icon5;
@property (weak, nonatomic) IBOutlet UILabel *wei_Lab5;
@property (weak, nonatomic) IBOutlet UILabel *gz_Lab5;

@property (weak, nonatomic) IBOutlet UIView *OView6;
@property (weak, nonatomic) IBOutlet UIView *SEL_View6;
@property (weak, nonatomic) IBOutlet UIView *SliderView6;
@property (weak, nonatomic) IBOutlet UIView *C_View6;
@property (weak, nonatomic) IBOutlet UIView *S_View6;
@property (weak, nonatomic) IBOutlet UILabel *name6;
@property (weak, nonatomic) IBOutlet UIImageView *Player_Icon6;
@property (weak, nonatomic) IBOutlet UILabel *wei_Lab6;
@property (weak, nonatomic) IBOutlet UILabel *gz_Lab6;

@property (weak, nonatomic) IBOutlet UIView *OView7;
@property (weak, nonatomic) IBOutlet UIView *SEL_View7;
@property (weak, nonatomic) IBOutlet UIView *SliderView7;
@property (weak, nonatomic) IBOutlet UIView *C_View7;
@property (weak, nonatomic) IBOutlet UIView *S_View7;
@property (weak, nonatomic) IBOutlet UILabel *name7;
@property (weak, nonatomic) IBOutlet UIImageView *Player_Icon7;
@property (weak, nonatomic) IBOutlet UILabel *wei_Lab7;
@property (weak, nonatomic) IBOutlet UILabel *gz_Lab7;

@property (weak, nonatomic) IBOutlet UIView *OView8;
@property (weak, nonatomic) IBOutlet UIView *SEL_View8;
@property (weak, nonatomic) IBOutlet UIView *SliderView8;
@property (weak, nonatomic) IBOutlet UIView *C_View8;
@property (weak, nonatomic) IBOutlet UIView *S_View8;
@property (weak, nonatomic) IBOutlet UILabel *name8;
@property (weak, nonatomic) IBOutlet UIImageView *Player_Icon8;
@property (weak, nonatomic) IBOutlet UILabel *wei_Lab8;
@property (weak, nonatomic) IBOutlet UILabel *gz_Lab8;



@property (weak, nonatomic) IBOutlet UIView *down3View; //5人房间隐藏下面三个替补


//-------------------下----------------
@property (weak, nonatomic) IBOutlet UILabel *D_numLab;  // 底部已存阵容   数字角标




@property (strong, nonatomic) PNCircleChart *chart1;
@property (strong, nonatomic) PNCircleChart *chart2;
@property (strong, nonatomic) PNCircleChart *chart3;
@property (strong, nonatomic) PNCircleChart *chart4;
@property (strong, nonatomic) PNCircleChart *chart5;
@property (strong, nonatomic) PNCircleChart *chart6;
@property (strong, nonatomic) PNCircleChart *chart7;
@property (strong, nonatomic) PNCircleChart *chart8;

@end





@interface NBA_PlayerListModel : NSObject
@property (nonatomic, strong) NSArray<NBA_PlayerListModelCell *> *data;


@end


@interface NBA_PlayerListModelCell : NSObject
@property (nonatomic , strong) NSString *Id;               //房间id号
@property (nonatomic , strong) NSString *salary;           //工资
@property (nonatomic , assign) double average;             //平均分
@property (nonatomic , assign) double play_time;           //出场时间
@property (nonatomic , strong) NSString *play_num;         //出场次数
@property (nonatomic , strong) NSString *position;         //位置

@property (nonatomic , strong) NSString *team_id;       //
@property (nonatomic , strong) NSString *name;          //
@property (nonatomic , strong) NSString *project_id;    //
@property (nonatomic , strong) NSString *img;           //
@property (nonatomic , strong) NSString *nationality;         //国籍
@property (nonatomic , strong) NSString *match_id;            //比赛的id"
@property (nonatomic , strong) NSString *is_undetermined;     //是否待定1是2否
@property (nonatomic , strong) NSString *is_illness;          //是否伤病1是2否",
@property (nonatomic , strong) NSString *is_ban;              //是否禁赛1是2否
@property (nonatomic , strong) NSString *is_out;              //是否离队1是2否
@property (nonatomic , strong) NSString *state;               //球员的锁定状态1是2否"
@property (nonatomic , strong) NSMutableArray *last_ten_score; //球员最后10场得分
@property (nonatomic , assign) BOOL isDisplay;  //选中
@property (nonatomic , assign) BOOL isNO;       //替补页面显示选中


@end



