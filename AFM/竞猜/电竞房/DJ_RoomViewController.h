//
//  DJ_RoomViewController.h
//  AFM
//
//  Created by admin on 2017/10/20.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BaseViewController.h"
@class DJListModel;
@class DJListModelCell;

@interface DJ_RoomViewController : BaseViewController

@property (nonatomic , strong) NSString *Btn_tag;   //top回调参数
@property (nonatomic , strong) NSString *projectId;   //peo
@property (nonatomic , strong) NSString *typeId;   //type


@property (weak, nonatomic) IBOutlet UILabel *men_numLab;
@property (weak, nonatomic) IBOutlet UILabel *join_Lab;
@property (weak, nonatomic) IBOutlet UIView *top_View;
@end

@interface DJListModel : NSObject
@property (nonatomic, strong) NSArray<DJListModelCell *> *data;
@end


@interface DJListModelCell : NSObject
@property (nonatomic , strong) NSString *allow_uguess_num;//允许用户投注总数
@property (nonatomic , strong) NSString *now_guess_num;  //已经投注了的总数
@property (nonatomic , strong) NSString *allow_guess_num;  //房间允许投注总数
@property (nonatomic , strong) NSString *Id;               //房间id号
@property (nonatomic , strong) NSString *name;          //房间名称
@property (nonatomic , strong) NSString *type_id;    //房间类型(新手房/5人房)
@property (nonatomic , strong) NSString *type_name;     //房间类型名称
@property (nonatomic , strong) NSString *type_img;     //房间类型图标
@property (nonatomic , strong) NSString *rule_id;     //房间规则id(开奖奖励规则id)
@property (nonatomic , strong) NSString *project_id;     //项目id
@property (nonatomic , strong) NSString *protect_name;     //项目名称
@property (nonatomic , strong) NSString *is_host;     //是否推荐
@property (nonatomic , strong) NSString *price;     //进入房间门票价格
@property (nonatomic , assign) NSInteger match_start_time;                  //比赛开始时间  1507446000
@property (nonatomic , assign) NSInteger match_end_time;                   //比赛结束时间 ",1507442400
@property (nonatomic , strong) NSString *prize_type;     //奖品类型(门票或者木头1门票2木头 4实物)"
@property (nonatomic , strong) NSString *prize_name;     //奖品名称

@property (nonatomic , strong) NSString *reward_num;     //奖池数量
@property (nonatomic , strong) NSString *reward_id;     //奖励规则id

@property (nonatomic , strong) NSString *prize_num;     //中奖人数当reward为1和2时此处为百分比数其他为人数
@property (nonatomic , strong) NSString *join_num;     //用户参加这场比赛次数
@property (nonatomic , strong) NSString *open_tag;     //满4人开",
@property (nonatomic , strong) NSString *reward_tag;     //前10%各得
@property (nonatomic , strong) NSString *match_start_date;     //"比赛开始的日期
@property (nonatomic , strong) NSString *is_special;     //是否是主播房1是2否
@property (nonatomic , strong) NSString *special_name;     //特殊主播房的名称
@property (nonatomic , strong) NSString *special_uid;     //主播的uid
@property (nonatomic , strong) NSString *isnew_hand;     //是否是新手1是2否
@property (nonatomic , strong) NSString *more_guess;     //是否是多注1是2否
@property (nonatomic , strong) NSString *open_id;        //房间规则id(1必开其他满开
@property (nonatomic , strong) NSString *open_num;       //当open_id不为1时此数据才有用


@end

