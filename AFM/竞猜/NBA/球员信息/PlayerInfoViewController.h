//
//  PlayerInfoViewController.h
//  AFM
//
//  Created by admin on 2017/9/14.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BaseViewController.h"
#import "SK_InfoModel.h"
#import "PlayerChooseViewController.h"

@class Player_Model;
@class Player_ModelCell;
@class Player_Data_ModelCell;

@class Player_Info_ModelCell;
@class PlayerModel_All_Cell;
@class PlayerModel_Ten_Cell;
@class Player_avg10_ModelCell;


@interface PlayerInfoViewController : BaseViewController
@property (nonatomic , strong) SK_InfoLineup_PlayerData  *Player;

@property (nonatomic , strong) NSString *lol_data_nba;    //
@property (nonatomic , strong) Player_ListModelCell  *JCPlayer;
@property (nonatomic , strong) Player_ModelCell *listModel;

@property (nonatomic , strong) NSString *next_Time;    //
@property (nonatomic , strong) NSString *next_opponents;    //对手
@property (nonatomic , strong) NSString *team_name;         //所属队伍
@property (nonatomic , strong) NSString *position;
@property (nonatomic , strong) NSString *player_id;
@property (nonatomic , strong) NSString *deF;    //
@property (nonatomic , strong) NSString *sanF;    //
@property (nonatomic , strong) NSString *lanB;    //
@property (nonatomic , strong) NSString *zhuG;    //
@property (nonatomic , strong) NSString *qiangD;    //
@property (nonatomic , strong) NSString *fengG;    //
@property (nonatomic , strong) NSString *shiW;    //
@property (nonatomic , strong) NSString *jiF;    //
@property (nonatomic , strong) NSString *time;    //

@property (nonatomic , strong) NSString *play_num;    //
@property (nonatomic , strong) NSString *play_time;    //


@property (nonatomic , strong) NSString *IMG;
@property (nonatomic , strong) NSString *NAME;
@property (nonatomic , strong) NSString *SALARY;
@property (nonatomic , strong) NSString *POIN;

@end



@interface Player_Model : NSObject
@property (nonatomic , strong) Player_ModelCell *data;


@end


@interface Player_ModelCell : NSObject
@property (nonatomic , strong) Player_Data_ModelCell               *player_data;
@property (nonatomic , strong) NSMutableArray<Player_Info_ModelCell   *>*match_info;
@property (nonatomic , strong) NSMutableArray<PlayerModel_All_Cell    *>*all_match_info;
@property (nonatomic , strong) NSMutableArray<PlayerModel_Ten_Cell    *>*ten_match_info;
@property (nonatomic , strong) Player_avg10_ModelCell               *season_avg_10; // 赛季10场平均值
@property (nonatomic , strong) NSDictionary   *season_avg;             // 赛季平均值
@property (nonatomic , strong) NSMutableArray *last_ten_score;
@end


@interface Player_avg10_ModelCell : NSObject
@property (nonatomic , assign) double  backboard;      //篮板
@property (nonatomic , assign) double  cover_score;    //盖帽
@property (nonatomic , assign) double  mistake_score;  //失误
@property (nonatomic , assign) double  play_time;      //出场
@property (nonatomic , assign) double  three_point;    //三分
@property (nonatomic , assign) double  score;          //积分
@property (nonatomic , assign) double  get_score;      //得分
@property (nonatomic , assign) double  help_score;     //助攻
@property (nonatomic , assign) double  hinder_score;   //抢断
@end

@interface Player_Data_ModelCell : NSObject
@property (nonatomic , strong) NSString *team_id;
@property (nonatomic , strong) NSString *name;  //
@property (nonatomic , strong) NSString *e_name;          //
@property (nonatomic , strong) NSString *project_id;  //
@property (nonatomic , strong) NSString *img;          //
@property (nonatomic , strong) NSString *position;           //位置
@property (nonatomic , assign) double average;              //平均分
@property (nonatomic , strong) NSString *salary;             //工资
@property (nonatomic , strong) NSString *play_num;           //
@property (nonatomic , strong) NSString *play_time;          //
@end



@interface Player_Info_ModelCell : NSObject
@property (nonatomic , strong) NSString *Id;               //id号
@property (nonatomic , strong) NSString *salary;           //工资
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

@end

@interface PlayerModel_All_Cell : NSObject
@property (nonatomic , strong) NSString *Id;// = 432;
@property (nonatomic , strong) NSString *is_join;//" = 2;
@property (nonatomic , strong) NSString *match_id;//" = 12164;
@property (nonatomic , strong) NSString *match_time;//" = 1511136000;
@property (nonatomic , strong) NSString *match_time_data;//" = "11/20 08:00";

@property (nonatomic , strong) NSString *add_time;      //时间
@property (nonatomic , assign) double  backboard;      //篮板
@property (nonatomic , assign) double  cover_score;    //盖帽
@property (nonatomic , assign) double  mistake_score;  //失误
@property (nonatomic , assign) double  play_time;      //出场
@property (nonatomic , assign) double  three_point;    //三分
@property (nonatomic , assign) double  score;          //积分
@property (nonatomic , assign) double  get_score;      //得分
@property (nonatomic , assign) double  help_score;     //助攻
@property (nonatomic , assign) double  hinder_score;   //抢断

@property (nonatomic , strong) NSString *player_id;//" = 203952;
@property (nonatomic , strong) NSString *season; //= 2017
@property (nonatomic , strong) NSString *team_a_id;//" = 6;
@property (nonatomic , strong) NSString *team_a_score;//" = 0;
@property (nonatomic , strong) NSString *team_b_id;//" = 21;
@property (nonatomic , strong) NSString *team_b_score;//" = 0;
@property (nonatomic , strong) NSString *team_id;//" = 6;

@property (nonatomic , strong) NSDictionary   *match_info;
@property (nonatomic , strong) NSDictionary   *team_a_info;//
@property (nonatomic , strong) NSDictionary   *team_b_info;//
@end

@interface PlayerModel_Ten_Cell : NSObject
@property (nonatomic , strong) NSString *Id;// = 432;
@property (nonatomic , strong) NSString *is_join;//" = 2;
@property (nonatomic , strong) NSString *match_id;//" = 12164;
@property (nonatomic , strong) NSString *match_time;//" = 1511136000;
@property (nonatomic , strong) NSString *match_time_data;//" = "11/20 08:00";

@property (nonatomic , strong) NSString *add_time;      //时间
@property (nonatomic , assign) double  backboard;      //篮板
@property (nonatomic , assign) double  cover_score;    //盖帽
@property (nonatomic , assign) double  mistake_score;  //失误
@property (nonatomic , assign) double  play_time;      //出场
@property (nonatomic , assign) double  three_point;    //三分
@property (nonatomic , assign) double  score;          //积分
@property (nonatomic , assign) double  get_score;      //得分
@property (nonatomic , assign) double  help_score;     //助攻
@property (nonatomic , assign) double  hinder_score;   //抢断

@property (nonatomic , strong) NSString *player_id;//" = 203952;
@property (nonatomic , strong) NSString *season; //= 2017
@property (nonatomic , strong) NSString *team_a_id;//" = 6;
@property (nonatomic , strong) NSString *team_a_score;//" = 0;
@property (nonatomic , strong) NSString *team_b_id;//" = 21;
@property (nonatomic , strong) NSString *team_b_score;//" = 0;
@property (nonatomic , strong) NSString *team_id;//" = 6;

@property (nonatomic , strong) NSDictionary   *match_info;             //
@property (nonatomic , strong) NSDictionary   *team_a_info;//
@property (nonatomic , strong) NSDictionary   *team_b_info;//

@end



