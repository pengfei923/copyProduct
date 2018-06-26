//
//  DJ1_ChooseViewController.h
//  AFM
//
//  Created by admin on 2017/10/17.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BaseViewController.h"
#import "DJ_ChooseViewController.h"

@class DJ1_PlayerListModel;
@class DJ1_PlayerListModelCell;

@interface DJ1_ChooseViewController : BaseViewController

@property (nonatomic , strong) NSString *Id;                  //房间id号
@property (nonatomic , strong) NSString *type;                //lol..dota
@property (nonatomic , strong) NSString *name;                //房间名
@property (nonatomic , strong) NSString *iconImg;             //房间图标
@property (nonatomic , strong) NSString *price;               //门票数
@property (nonatomic , strong) NSString *guess_num;           //自己投注数
@property (nonatomic , strong) NSString *allow_uguess_num;    //允许用户投注总数
@property (nonatomic , strong) NSString *allow_guess_num;
@property (nonatomic , strong) NSString *now_guess_num;
@property (nonatomic , strong) NSString *join_num;            // 自己参加次数
@property (nonatomic , strong) NSString *SY_num;              // 自己参加剩余次数
@property (nonatomic , strong) NSArray *IdArr;                //选手id数组
@property (nonatomic , strong) NSDictionary *IdDic;            //选手id数组

@property (nonatomic , strong) NSString *C_lineup_ID;         //清除阵容时需要

@property (nonatomic , strong) NSString *num;                 //已存阵容个数
@property (nonatomic , strong) NSMutableArray *playerArr;       //回调选手信息
@property (nonatomic , assign) NSInteger TIME_mast;           //距离开始的时间
@property (nonatomic , assign) NSNumber *allGZ;                  //可用的总工资

//-----------------传值----------------
@property (nonatomic , strong) NSMutableDictionary *ZR_dic;
@property (nonatomic , strong) NSString *ZR_Type;
@property (nonatomic , strong) NSString *GZ_;
@property (nonatomic , strong) NSString *PJ_;





//-----------------上部----------------
@property (weak, nonatomic) IBOutlet UILabel *tome_Lab;
@property (weak, nonatomic) IBOutlet UILabel *PJ_Lab;
@property (weak, nonatomic) IBOutlet UILabel *Price_Lab;


//-----------------中间----------------
@property (weak, nonatomic) IBOutlet UIButton *icon_Btn1;
@property (weak, nonatomic) IBOutlet UIView *zhong_View1;
@property (weak, nonatomic) IBOutlet UIView *SELView1;
@property (weak, nonatomic) IBOutlet UIView *OView1;
@property (weak, nonatomic) IBOutlet UILabel *name1;
@property (weak, nonatomic) IBOutlet UILabel *PJ_Lab1;
@property (weak, nonatomic) IBOutlet UILabel *price1;


@property (weak, nonatomic) IBOutlet UIButton *icon_Btn2;
@property (weak, nonatomic) IBOutlet UIView *zhong_View2;
@property (weak, nonatomic) IBOutlet UIView *SELView2;
@property (weak, nonatomic) IBOutlet UIView *OView2;
@property (weak, nonatomic) IBOutlet UILabel *name2;
@property (weak, nonatomic) IBOutlet UILabel *PJ_Lab2;
@property (weak, nonatomic) IBOutlet UILabel *price2;


@property (weak, nonatomic) IBOutlet UIButton *icon_Btn3;
@property (weak, nonatomic) IBOutlet UIView *zhong_View3;
@property (weak, nonatomic) IBOutlet UIView *SELView3;
@property (weak, nonatomic) IBOutlet UIView *OView3;
@property (weak, nonatomic) IBOutlet UILabel *name3;
@property (weak, nonatomic) IBOutlet UILabel *PJ_Lab3;
@property (weak, nonatomic) IBOutlet UILabel *price3;



@property (weak, nonatomic) IBOutlet UIButton *icon_Btn4;
@property (weak, nonatomic) IBOutlet UIView *zhong_View4;
@property (weak, nonatomic) IBOutlet UIView *SELView4;
@property (weak, nonatomic) IBOutlet UIView *OView4;
@property (weak, nonatomic) IBOutlet UILabel *name4;
@property (weak, nonatomic) IBOutlet UILabel *PJ_Lab4;
@property (weak, nonatomic) IBOutlet UILabel *price4;



@property (weak, nonatomic) IBOutlet UIButton *icon_Btn5;
@property (weak, nonatomic) IBOutlet UIView *zhong_View5;
@property (weak, nonatomic) IBOutlet UIView *SELView5;
@property (weak, nonatomic) IBOutlet UIView *OView5;
@property (weak, nonatomic) IBOutlet UILabel *name5;
@property (weak, nonatomic) IBOutlet UILabel *PJ_Lab5;
@property (weak, nonatomic) IBOutlet UILabel *price5;



@property (weak, nonatomic) IBOutlet UIButton *icon_Btn6;
@property (weak, nonatomic) IBOutlet UIView *zhong_View6;
@property (weak, nonatomic) IBOutlet UIView *SELView6;
@property (weak, nonatomic) IBOutlet UIView *OView6;
@property (weak, nonatomic) IBOutlet UILabel *name6;
@property (weak, nonatomic) IBOutlet UILabel *PJ_Lab6;
@property (weak, nonatomic) IBOutlet UILabel *price6;



@property (weak, nonatomic) IBOutlet UIButton *icon_Btn7;
@property (weak, nonatomic) IBOutlet UIView *zhong_View7;
@property (weak, nonatomic) IBOutlet UIView *SELView7;
@property (weak, nonatomic) IBOutlet UIView *OView7;
@property (weak, nonatomic) IBOutlet UILabel *name7;
@property (weak, nonatomic) IBOutlet UILabel *PJ_Lab7;
@property (weak, nonatomic) IBOutlet UILabel *price7;



@property (weak, nonatomic) IBOutlet UIButton *icon_Btn8;
@property (weak, nonatomic) IBOutlet UIView *zhong_View8;
@property (weak, nonatomic) IBOutlet UIView *SELView8;
@property (weak, nonatomic) IBOutlet UIView *OView8;
@property (weak, nonatomic) IBOutlet UILabel *name8;
@property (weak, nonatomic) IBOutlet UILabel *PJ_Lab8;
@property (weak, nonatomic) IBOutlet UILabel *price8;

//-----------------底部----------------
@property (weak, nonatomic) IBOutlet UILabel *ZR_num;

@end


@interface DJ1_PlayerListModel : NSObject
@property (nonatomic, strong) NSArray<DJ1_PlayerListModelCell *> *data;


@end


@interface DJ1_PlayerListModelCell : NSObject
@property (nonatomic , strong) NSString *Id;               //房间id号
@property (nonatomic , strong) NSString *salary;           //工资
@property (nonatomic , assign) double average;             //平均分
@property (nonatomic , assign) double KDA;                  //KDA
@property (nonatomic , strong) NSString *team_id;//
@property (nonatomic , strong) NSString *name;  //
@property (nonatomic , strong) NSString *project_id;  //
@property (nonatomic , strong) NSString *img;          //
@property (nonatomic , strong) NSString *e_name;          //
@property (nonatomic , strong) NSString *nationality;          //国籍
@property (nonatomic , strong) NSString *position;          //位置
@property (nonatomic , strong) NSString *result;          //
@property (nonatomic , strong) NSString *is_undetermined;     //是否待定1是2否
@property (nonatomic , strong) NSString *is_illness;          //
@property (nonatomic , strong) NSString *is_ban;          //是否禁赛1是2否
@property (nonatomic , strong) NSString *is_out;          //是否离队1是2否
@property (nonatomic , strong) NSString *match_id;          //比赛的id"
@property (nonatomic , strong) NSString *state;          //球员的锁定状态1是2否"
@property (nonatomic , strong) NSMutableArray *last_ten_score;          //
@property (nonatomic , assign) BOOL isDisplay;  //选中
@property (nonatomic , assign) BOOL isNO;       //替补页面显示选中
@end




