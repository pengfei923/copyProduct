//
//  SK_WeiModel.h
//  AFM
//
//  Created by admin on 2017/9/28.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SK_WeiModelCell;

@class SK_Wei_RoomInfoData;
@class SK_Wei_LineupData;
@class SK_Wei_PlayerInfoData;
@class SK_Wei_TeamInfoData;
//@class SK_Wei_RoomMatchData;

@interface SK_WeiModel : NSObject
@property (nonatomic, strong) NSArray<SK_WeiModelCell *> *data;

@end


//------
@interface SK_WeiModelCell : NSObject

@property (nonatomic , strong) NSString *lineup_id;               //1
@property (nonatomic , assign) double  lineup_score;              //阵容得分 106.7
@property (nonatomic , strong) NSString *usable_salary_sum;       //可用工资
@property (nonatomic , strong) NSString *join_room_num;           //1
@property (nonatomic , strong) NSString *match_start_date;        //时间  06-01 08:53
@property (nonatomic , strong) NSString *project_id;              //4
@property (nonatomic , strong) NSMutableDictionary *lineup_info;     //选手位置号码

@property (nonatomic , strong) SK_Wei_LineupData                *lineup;      //123456位置
@property (nonatomic , strong) NSMutableArray<SK_Wei_RoomInfoData *>*room_info;  //房间详情
@property (nonatomic , strong) NSDictionary *player_lineup_info;             //选手信息
@property (nonatomic , strong) NSDictionary *team_info;                      //比赛选手信息


@end



//------房间详情
@interface SK_Wei_RoomInfoData : NSObject
@property (nonatomic , strong) NSString *Id;       //39",
@property (nonatomic , strong) NSString *name;  //【主播】5月26日NBA测试 胜者均分5W木头",
@property (nonatomic , strong) NSString *tag_img; //":"0",
@property (nonatomic , strong) NSString *type_id; //":"5",
@property (nonatomic , strong) NSString *reward_id;//"3",
@property (nonatomic , strong) NSString *reward_num;  //"50000",
@property (nonatomic , strong) NSString *prize_num;   //100",
@property (nonatomic , strong) NSString *is_hot;  //":"2",
@property (nonatomic , strong) NSString *author;   //lzhkk01",
@property (nonatomic , strong) NSString *project_id;  //"4",
@property (nonatomic , strong) NSString *img; //
@property (nonatomic , strong) NSString *price;   //"50",
@property (nonatomic , assign) NSInteger match_start_time;                  //比赛开始时间  1507446000
@property (nonatomic , assign) NSInteger match_end_time;                   //比赛结束时间 ",1507442400
@property (nonatomic , strong) NSString *end_time;  //1495781400",
@property (nonatomic , strong) NSString *allow_uguess_num;  //"5",
@property (nonatomic , strong) NSString *now_guess_num;   //"12",
@property (nonatomic , strong) NSString *allow_guess_num;  //"50",
@property (nonatomic , strong) NSString *open_id;   //1",
@property (nonatomic , strong) NSString *open_num;  //0",
@property (nonatomic , strong) NSString *lineup_id;   //"1",
@property (nonatomic , strong) NSString *prize_type;  //1",
@property (nonatomic , strong) NSString *prize_goods_id;  //0",
@property (nonatomic , strong) NSString *status;  //1",
@property (nonatomic , strong) NSString *add_time;  //1495677139",
@property (nonatomic , strong) NSString *settlement_status;  //"2",
@property (nonatomic , strong) NSString *is_special;  //1",
@property (nonatomic , strong) NSString *special_uid;  //43",
@property (nonatomic , strong) NSString *special_name;  //老字号",
@property (nonatomic , strong) NSString *type_name;  //"主播房",
@property (nonatomic , strong) NSString *type_img;  //http://static.aifamu.co
@property (nonatomic , strong) NSString *isnew_hand;  //new_hand
@property (nonatomic , strong) NSString *more_guess;  //1,
@property (nonatomic , strong) NSString *project_name;  //NBA",
@property (nonatomic , strong) NSString *match_start_date;  //06-01 08:53",
@property (nonatomic , strong) NSString *open_tag;   //必开",
@property (nonatomic , strong) NSString *reward_tag;  // //获胜均分",
@property (nonatomic , strong) NSString *prize_name;  //门票",
@property (nonatomic , strong) NSString *goods_name;  //
@property (nonatomic , strong) NSString *join_num; ///5",//自己参加
@property (nonatomic , strong) NSString *guess_id;   //22"

@property (nonatomic , strong) NSString *player_ranking;  //自己排名
@property (nonatomic , strong) NSString *max_socre;
@property (nonatomic , strong) NSString *my_score;
@property (nonatomic , strong) NSString *door_socre; //房间积分
@end




//------123456位置
@interface SK_Wei_LineupData : NSObject
@property (nonatomic , strong) NSString *num;     //5,
@property (nonatomic , strong) NSString *pay;     //125,
@property (nonatomic , strong) NSMutableDictionary *position;     //
@end





//------12345
@interface SK_Wei_PlayerInfoData : NSObject
@property (nonatomic , strong) NSString *Id;       //1626179",
@property (nonatomic , strong) NSString *team_id;  //26",
@property (nonatomic , strong) NSString *name;     //特里-罗齐尔",
@property (nonatomic , strong) NSString *salary;   //29",
@property (nonatomic , strong) NSString *number;   //12",
@property (nonatomic , strong) NSString *position; //1",
@property (nonatomic , assign) double average;             //平均分
@property (nonatomic , strong) NSString *img;      //http://api.aifamu.com/img/playerimg/1626179.png"
@property (nonatomic , strong) NSString *KAD;      //27.2,
@end


//-----team_info
@interface SK_Wei_TeamInfoData : NSObject
@property (nonatomic , strong) NSString *score;   //当前分
@property (nonatomic , strong) NSString *state;   //状态

@end









