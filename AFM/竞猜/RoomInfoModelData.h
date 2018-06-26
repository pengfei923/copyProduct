//
//  RoomInfoModelData.h
//  AFM
//
//  Created by admin on 2017/9/18.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RoomInfoModelDataCell;

@class RoomInfoJoin_userData;
@class RoomInfoMatch_listData;
@class RoomInfoLineupData;
@class RoomInfoReward_ruleData;

@interface RoomInfoModelData : NSObject
@property (nonatomic, strong) RoomInfoModelDataCell *data;

@end

@interface RoomInfoModelDataCell : NSObject
@property (nonatomic , strong) NSMutableArray<RoomInfoJoin_userData    *>*join_user;
@property (nonatomic , strong) NSMutableArray<RoomInfoMatch_listData   *>*match_list;
@property (nonatomic , strong) NSMutableArray<RoomInfoReward_ruleData   *>*reward_rule_k;

@property (nonatomic, strong) RoomInfoLineupData *lineup;

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
@property (nonatomic , strong) NSString *join_num;       //用户参加这场比赛次数
@property (nonatomic , strong) NSString *isnew_hand;     //是否是新手1是2否
@property (nonatomic , strong) NSString *more_guess;     //是否是多注1是2否
@property (nonatomic , strong) NSString *open_id;        //房间规则id(1必开其他满开
@property (nonatomic , strong) NSString *open_num;       //当open_id不为1时此数据才有用
@property (nonatomic , strong) NSString *allow_uguess_num;//允许用户投注总数
@property (nonatomic , strong) NSString *team_tags;        //":"SSG:ROX:KT:LZ"----新闻

@end


@interface RoomInfoJoin_userData : NSObject
@property (nonatomic , strong) NSString *username;     //用户昵称
@property (nonatomic , strong) NSString *rank_name;     //用户头衔
@property (nonatomic , strong) NSString *guess_num;     //本场比赛的竞猜次数"
@property (nonatomic , strong) NSString *avatar_img;        //用户头像
@property (nonatomic , strong) NSString *rank_img;
@end


@interface RoomInfoMatch_listData : NSObject
@property (nonatomic , strong) NSString *Id;                   //房间id号"
@property (nonatomic , strong) NSString *team_a;                   //房间id号"
@property (nonatomic , strong) NSString *team_b;                   //房间id号"
@property (nonatomic , strong) NSString *match_time_date;
@property (nonatomic , strong) NSString *match_time;                   //比赛的时间"
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
@property (nonatomic , strong) NSString *score_color;      //
@end


@interface RoomInfoLineupData : NSObject
@property (nonatomic , strong) NSString *num;     //
@property (nonatomic , strong) NSNumber *pay;     //
@property (nonatomic , strong) NSMutableDictionary *position;     //
@end


@interface RoomInfoReward_ruleData : NSObject
@property (nonatomic , strong) NSString *name;      //
@property (nonatomic , strong) NSString *content;      //
@end

