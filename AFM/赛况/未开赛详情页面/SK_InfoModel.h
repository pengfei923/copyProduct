//
//  SK_InfoModel.h
//  AFM
//
//  Created by admin on 2017/9/26.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SK_InfoModelCell;

@class SK_InfoUser_RankData;
@class SK_InfoLineup_PlayerData;
@class SK_InfoLineupInfoData;
@class SK_InfoUser_RData;//用户排名信息
@class SK_InfoRoomData;

@class SK_RoomInfolineup_Data;   //
@class SK_RoomInfoMatch_listData; //赛事对阵列表
@class SK_RoomInfoJoin_userData;  //参与选手列表

@class SK_LupP_MatchData;
@interface SK_InfoModel : NSObject
@property (nonatomic, strong) SK_InfoModelCell *data;

@end


@interface SK_InfoModelCell : NSObject
@property (nonatomic , strong) NSMutableArray<SK_InfoUser_RankData    *>*all_user_rank;   //排名
@property (nonatomic , strong) NSMutableArray<SK_InfoLineup_PlayerData *>*lineup_player;  //阵容详情

@property (nonatomic , strong) SK_InfoLineupInfoData *lineup_info;//123456
@property (nonatomic , strong) SK_InfoRoomData   *room_info;    //房间详情
@property (nonatomic , strong) SK_InfoUser_RData *user_rank;          //用户排名信息

@property (nonatomic , strong) NSString *usable_salary_sum;           //
@property (nonatomic , strong) NSString *lineup_average;           //
@property (nonatomic , strong) NSString *play_time_sum;           //
@property (nonatomic , strong) NSString *sum_score;              //
@property (nonatomic , strong) NSString *is_enter;              //


@end
//-----玩家排名
@interface SK_InfoUser_RankData : NSObject
@property (nonatomic , strong) NSString *Id;                   //------------------------
@property (nonatomic , strong) NSString *avatar_img;           //
@property (nonatomic , strong) NSString *lineup_id;            //
@property (nonatomic , assign) double   lineup_score;          //阵容得分
@property (nonatomic , strong) NSString *rank_img;             //
@property (nonatomic , strong) NSString *rank_name;            //
@property (nonatomic , strong) NSString *ranking;              //
@property (nonatomic , strong) NSString *total_play_time;      //
@property (nonatomic , strong) NSString *uid;                  //
@property (nonatomic , strong) NSString *username;             //
@property (nonatomic , strong) NSString *is_reward;            //获得奖励数量

@end
//-----
@interface SK_InfoLineup_PlayerData : NSObject
@property (nonatomic , strong) NSString *player_id;        //
@property (nonatomic , assign) double   average;          //
@property (nonatomic , strong) NSString *img;              //
@property (nonatomic , strong) NSString *match_id;         //
@property (nonatomic , strong) NSString *name;             //
@property (nonatomic , strong) NSString *position;            //
@property (nonatomic , strong) NSString *salary;              //
@property (nonatomic , strong) NSString *team_id;
@property (nonatomic , assign) double   KDA;
@property (nonatomic , assign) double   play_time;
@property (nonatomic , strong) NSString *result;          //"13W-11L";
@property (nonatomic , strong) NSString *team_name;

@property (nonatomic , strong) SK_LupP_MatchData  *match_data;          //

@end


//-----
@interface SK_LupP_MatchData : NSObject
@property (nonatomic , strong) NSString *Id;        //
@property (nonatomic , strong) NSString *player_id;//
@property (nonatomic , strong) NSString *match_id;

@property (nonatomic , strong) NSString *kill;   //击杀
@property (nonatomic , strong) NSString *death;  //死亡
@property (nonatomic , strong) NSString *assists; //助攻
@property (nonatomic , strong) NSString *jungle;
@property (nonatomic , strong) NSString *ten_kill;
@property (nonatomic , assign) double   score;   //defen
@property (nonatomic , strong) NSString *times;
@property (nonatomic , strong) NSString *opp;
@property (nonatomic , assign) double   scores;
@property (nonatomic , strong) NSString *tower;
@property (nonatomic , strong) NSString *dragons;
@property (nonatomic , strong) NSString *barons;
@property (nonatomic , strong) NSString *first_blood;

@property (nonatomic , strong) NSString *is_win;
@property (nonatomic , strong) NSString *is_join;
@property (nonatomic , strong) NSString *is_fast;
@property (nonatomic , strong) NSString *remain;
@property (nonatomic , strong) NSString *season;
@property (nonatomic , strong) NSString *date;
@property (nonatomic , strong) NSString *addtime;


@property (nonatomic , strong) NSString *backboard;    //篮板
@property (nonatomic , strong) NSString *cover_score;   //盖帽
@property (nonatomic , strong) NSString *get_score;     //得分
@property (nonatomic , strong) NSString *help_score;    //助攻
@property (nonatomic , strong) NSString *hinder_score;   //抢断
@property (nonatomic , strong) NSString *mistake_score;   //失误
@property (nonatomic , strong) NSString *three_point;    //三分
@property (nonatomic , strong) NSString *play_time;
@property (nonatomic , strong) NSString *team_a_id;    //" = 21;
@property (nonatomic , strong) NSString *team_a_score;   //" = 87;
@property (nonatomic , strong) NSString *team_b_id;     //" = 14;
@property (nonatomic , strong) NSString *team_b_score;   //" = 95;
@property (nonatomic , strong) NSString *team_id;       //" = 14;

@property (nonatomic , strong) NSMutableDictionary *team_a_name;
@property (nonatomic , strong) NSMutableDictionary *team_b_name;

@property (nonatomic , strong) NSString *score_color;      //// 1为我方得分大于对方，2为我方得分小于对方，3为等分

@end


//-----
@interface SK_InfoLineupInfoData : NSObject
@end


//-----
@interface SK_InfoUser_RData : NSObject
@property (nonatomic , strong) NSString *Id;        //
@property (nonatomic , strong) NSString *uid;//":"230",
@property (nonatomic , strong) NSString *is_reward;
@property (nonatomic , strong) NSString *ranking;//":"108",
@property (nonatomic , assign) double   lineup_score;//":320.5,  zong
@property (nonatomic , strong) NSString *my_score;//":320.5,
@property (nonatomic , strong) NSString *player_ranking;//":"108",
@property (nonatomic , strong) NSString *max_socre;//":519.4,
@property (nonatomic , strong) NSString *max_rank;//":1,
@property (nonatomic , strong) NSString *door_socre;//":373.2,
@property (nonatomic , strong) NSString *door_rank;//":"47"
@end



//-----房间详情
@interface SK_InfoRoomData : NSObject
@property (nonatomic , strong) NSString *Id;                   //房间id号"
@property (nonatomic , strong) NSString *name;                        //房间名称"
@property (nonatomic , strong) NSString *type_id;                      //房间类型(新手房/5人房)"
@property (nonatomic , strong) NSString *tag_img;                      //房间类型图标
@property (nonatomic , strong) NSString *reward_id;                        //奖励规则id",
@property (nonatomic , strong) NSString *reward_num;                  //奖池数量
@property (nonatomic , strong) NSString *prize_num;                   //
@property (nonatomic , strong) NSString *prize_type;                        //奖品类型(门票或者点券)",
@property (nonatomic , strong) NSString *prize_name;                      //奖品名称
@property (nonatomic , strong) NSString *is_hot;                      //是否推荐",
@property (nonatomic , strong) NSString *price;                        //进入房间门票价格
@property (nonatomic , assign) NSInteger match_start_time;                  //比赛开始时间  1507446000
@property (nonatomic , assign) NSInteger match_end_time;                   //比赛结束时间 ",1507442400
@property (nonatomic , strong) NSString *now_guess_num;                        //已经投注了的总数"
@property (nonatomic , strong) NSString *allow_guess_num;                      //房间允许投注总数
@property (nonatomic , strong) NSString *join_num;     //用户参加这场比赛次数
@property (nonatomic , strong) NSString *isnew_hand;     //是否是新手1是2否
@property (nonatomic , strong) NSString *more_guess;     //是否是多注1是2否
@property (nonatomic , strong) NSString *open_id;        //房间规则id(1必开其他满开
@property (nonatomic , strong) NSString *open_num;       //当open_id不为1时此数据才有用
@property (nonatomic , strong) NSString *allow_uguess_num;//允许用户投注总数
@property (nonatomic , strong) NSString *author;//":"kangjincuo",
@property (nonatomic , strong) NSString *project_id;//":"5",
@property (nonatomic , strong) NSString *img;//":"",
@property (nonatomic , strong) NSString *end_time;//":"1501639200",
@property (nonatomic , strong) NSString *lineup_id;//":"3",
@property (nonatomic , strong) NSString *prize_goods_id;//":"0",
@property (nonatomic , strong) NSString *status;//":"1",
@property (nonatomic , strong) NSString *add_time;//":"1501231209",
@property (nonatomic , strong) NSString *settlement_status;//":"2",
@property (nonatomic , strong) NSString *is_special;//":"2",
@property (nonatomic , strong) NSString *special_uid;//":"0",
@property (nonatomic , strong) NSString *special_name;//":"",
@property (nonatomic , strong) NSString *type_name;//":"八人房",
@property (nonatomic , strong) NSString *type_img;//"
@property (nonatomic , strong) NSString *SKnew_hand;//":2,
@property (nonatomic , strong) NSString *project_name;//":"LOL",
@property (nonatomic , strong) NSString *match_start_date;//":"08-01 16:00",
@property (nonatomic , strong) NSString *open_tag;//":"必开",
@property (nonatomic , strong) NSString *reward_tag;//":"前50有奖",
@property (nonatomic , strong) NSString *goods_name;//":"",
@property (nonatomic , strong) NSString *team_tags;//":"SSG:ROX:KT:LZ",
@property (nonatomic , strong) NSString *join_user_info;//":"显示最新投注的前50名用户",

@property (nonatomic, strong) SK_RoomInfolineup_Data *lineup;

@property (nonatomic , strong) NSMutableArray<SK_RoomInfoMatch_listData   *>*match_list;
@property (nonatomic , strong) NSMutableArray<SK_RoomInfoJoin_userData    *>*join_user;

@end


//---------------------------------------room_info------------------------------

//-----
@interface SK_RoomInfolineup_Data : NSObject

@end

//-----赛事对针
@interface SK_RoomInfoMatch_listData : NSObject
@property (nonatomic , strong) NSString *Id;                   //房间id号"
@property (nonatomic , strong) NSString *team_a;                   //
@property (nonatomic , strong) NSString *team_b;                   // 
@property (nonatomic , strong) NSString *match_time_date;            //比赛的时间"
@property (nonatomic , strong) NSString *match_name;                   //比赛的名称
@property (nonatomic , strong) NSString *team_address;                   //比赛地点"
@property (nonatomic , strong) NSString *match_id;                   //赛事的id
@property (nonatomic , strong) NSString *img_a;  //
@property (nonatomic , strong) NSString *img_b;  //
@property (nonatomic , strong) NSString *score_a;    //
@property (nonatomic , strong) NSString *score_b;   //
@property (nonatomic , strong) NSString *name_a;     //
@property (nonatomic , strong) NSString *name_b;      //
@property (nonatomic , strong) NSString *match_status;    //比赛的状态1未开始2比赛中3已结束"
@property (nonatomic , strong) NSString *project_id;      //
@property (nonatomic , strong) NSString *score_color;      //// 1为我方得分大于对方，2为我方得分小于对方，3为等分


@end

//-----参与玩家
@interface SK_RoomInfoJoin_userData : NSObject
@property (nonatomic , strong) NSString *username;     //用户昵称
@property (nonatomic , strong) NSString *rank_name;     //用户头衔
@property (nonatomic , strong) NSString *guess_num;     //本场比赛的竞猜次数"
@property (nonatomic , strong) NSString *avatar_img;    //用户头像
@property (nonatomic , strong) NSString *rank_img;
@end





//-----
//@interface SK_InfoMatchData : NSObject
//@property (nonatomic , strong) NSString *addtime;
//@property (nonatomic , strong) NSString *assists;
//@property (nonatomic , strong) NSString *barons;
//@property (nonatomic , strong) NSString *date;
//@property (nonatomic , strong) NSString *death;
//@property (nonatomic , strong) NSString *dragons;
//@property (nonatomic , strong) NSString *first_blood;
//@property (nonatomic , strong) NSString *Id;//------------------------
//@property (nonatomic , strong) NSString *is_fast;
//@property (nonatomic , strong) NSString *is_join;
//@property (nonatomic , strong) NSString *is_win;
//@property (nonatomic , strong) NSString *jungle;
//@property (nonatomic , strong) NSString *kill;
//@property (nonatomic , strong) NSString *match_id;
//@property (nonatomic , strong) NSString *opp;
//@property (nonatomic , strong) NSString *player_id;
//@property (nonatomic , strong) NSString *remain;
//@property (nonatomic , strong) NSString *score;
//@property (nonatomic , strong) NSString *scores;
//@property (nonatomic , strong) NSString *season;
//@property (nonatomic , strong) NSString *ten_kill;
//@property (nonatomic , strong) NSString *times;
//@property (nonatomic , strong) NSString *tower;
//@end










