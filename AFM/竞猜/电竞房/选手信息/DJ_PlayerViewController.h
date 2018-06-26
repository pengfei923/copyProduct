//
//  DJ_PlayerViewController.h
//  AFM
//
//  Created by admin on 2017/10/30.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BaseViewController.h"
#import "PlayerChooseViewController.h"
#import "Player_teamModel.h"
#import "SK_InfoModel.h"

@class DJ_PlayerModel;
@class DJ_PlayerModelCell;
@class DJ_Player_DataModelCell;

@class DJ_PlayerModel_All_Cell;
@class DJ_PlayerModel_Ten_Cell;
@class DJ_PlayerModel_Season_Cell;




@interface DJ_PlayerViewController : BaseViewController
@property (nonatomic , strong) SK_InfoLineup_PlayerData  *Player;

@property (nonatomic , strong) Player_ListModelCell     *JCPlayer;
@property (nonatomic , strong) DJ_PlayerModelCell       *PlayerCell;

@property (nonatomic , strong) NSString *ID_;         //ID
@property (nonatomic , strong) NSString *team_name;         //所属队伍
@property (nonatomic , strong) NSString *lol_data_nba;      //
@property (nonatomic , strong) NSString *next_Time;         //时间
@property (nonatomic , strong) NSString *next_opponents;    //对手

@property (nonatomic , strong) NSString *jiS;      //
@property (nonatomic , strong) NSString *zhuG;      //
@property (nonatomic , strong) NSString *dail;      //
@property (nonatomic , strong) NSString *buD;      //

@property (nonatomic , strong) NSString *zhanJ;      //
@property (nonatomic , strong) NSString *chaiT;      //
@property (nonatomic , strong) NSString *yiX;      //
@property (nonatomic , strong) NSString *rouS;      //
@property (nonatomic , strong) NSString *daL;      //
@property (nonatomic , strong) NSString *xiaoL;      //

@property (nonatomic , strong) NSString *salary;
@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSString *img;
@property (nonatomic , strong) NSString *player_id;


@end


@interface DJ_PlayerModel : NSObject
@property (nonatomic, strong) DJ_PlayerModelCell *data;

@end


@interface DJ_PlayerModelCell : NSObject
@property (nonatomic , strong) DJ_Player_DataModelCell  *player_data;       //个人详情
@property (nonatomic , strong) NSMutableArray *last_ten_score;            //十场数据

@property (nonatomic , strong) NSMutableArray<DJ_PlayerModel_All_Cell *>*all;
@property (nonatomic , strong) NSMutableArray<DJ_PlayerModel_Ten_Cell *>*ten;
@property (nonatomic , strong) NSMutableArray<DJ_PlayerModel_Season_Cell *>*season;

@property (nonatomic , strong) NSDictionary *ten_avg;            //十场
@property (nonatomic , strong) NSDictionary *all_avg;            //全部
@property (nonatomic , strong) NSDictionary *season_avg;         //赛季


@end


@interface DJ_Player_DataModelCell : NSObject
@property (nonatomic , strong) NSString *team_id;         //
@property (nonatomic , strong) NSString *e_name;         //
@property (nonatomic , strong) NSString *name;         //
@property (nonatomic , strong) NSString *project_id;         //
@property (nonatomic , strong) NSString *img;         //
@property (nonatomic , strong) NSString *position;         //
@property (nonatomic , strong) NSString *salary;         //
@property (nonatomic , strong) NSString *result;         //
@property (nonatomic , assign) double average;         //
@property (nonatomic , assign) double KDA;         //

@end


@interface DJ_PlayerModel_All_Cell : NSObject
@property (nonatomic , assign) double  KDA;
@property (nonatomic , assign) double  assists;
@property (nonatomic , assign) double  barons;
@property (nonatomic , assign) double  death;
@property (nonatomic , assign) double  dragons;
@property (nonatomic , assign) double  jungle;
@property (nonatomic , assign) double  kill;
@property (nonatomic , assign) double  scores;
@property (nonatomic , assign) double  ten_kill;

@property (nonatomic , strong) NSString *score;//比分
@property (nonatomic , strong) NSString *time;// = "11/04";
@property (nonatomic , strong) NSString *opponents;//对手
@property (nonatomic , strong) NSString *first_blood;
@property (nonatomic , strong) NSString *is_fast;
@property (nonatomic , strong) NSString *is_join;
@property (nonatomic , strong) NSString *is_win;
@property (nonatomic , strong) NSString *match_id;
@property (nonatomic , strong) NSString *player_id;
@property (nonatomic , strong) NSString *remain;
@property (nonatomic , strong) NSString *season; // = 2017
@property (nonatomic , strong) NSString *times;// = 3;
@property (nonatomic , strong) NSString *tower;// = 0;


@end
@interface DJ_PlayerModel_Ten_Cell : NSObject
@property (nonatomic , assign) double  KDA;
@property (nonatomic , assign) double  assists;
@property (nonatomic , assign) double  barons;
@property (nonatomic , assign) double  death;
@property (nonatomic , assign) double  dragons;
@property (nonatomic , assign) double  jungle;
@property (nonatomic , assign) double  kill;
@property (nonatomic , assign) double  scores;
@property (nonatomic , assign) double  ten_kill;

@property (nonatomic , strong) NSString *score;//比分
@property (nonatomic , strong) NSString *time;// = "11/04";
@property (nonatomic , strong) NSString *opponents;//对手
@property (nonatomic , strong) NSString *first_blood;
@property (nonatomic , strong) NSString *is_fast;
@property (nonatomic , strong) NSString *is_join;
@property (nonatomic , strong) NSString *is_win;
@property (nonatomic , strong) NSString *match_id;
@property (nonatomic , strong) NSString *player_id;
@property (nonatomic , strong) NSString *remain;
@property (nonatomic , strong) NSString *season; // = 2017
@property (nonatomic , strong) NSString *times;// = 3;
@property (nonatomic , strong) NSString *tower;// = 0;

@end
@interface DJ_PlayerModel_Season_Cell : NSObject
@property (nonatomic , assign) double  KDA;
@property (nonatomic , assign) double  assists;
@property (nonatomic , assign) double  barons;
@property (nonatomic , assign) double  death;
@property (nonatomic , assign) double  dragons;
@property (nonatomic , assign) double  jungle;
@property (nonatomic , assign) double  kill;
@property (nonatomic , assign) double  scores;
@property (nonatomic , assign) double  ten_kill;

@property (nonatomic , strong) NSString *score;//比分
@property (nonatomic , strong) NSString *time;// = "11/04";
@property (nonatomic , strong) NSString *opponents;//对手
@property (nonatomic , strong) NSString *first_blood;
@property (nonatomic , strong) NSString *is_fast;
@property (nonatomic , strong) NSString *is_join;
@property (nonatomic , strong) NSString *is_win;
@property (nonatomic , strong) NSString *match_id;
@property (nonatomic , strong) NSString *player_id;
@property (nonatomic , strong) NSString *remain;
@property (nonatomic , strong) NSString *season; // = 2017
@property (nonatomic , strong) NSString *times;// = 3;
@property (nonatomic , strong) NSString *tower;// = 0;

@end








