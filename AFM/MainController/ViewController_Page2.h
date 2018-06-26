//
//  ViewController_Page2.h
//  CarServiceO2O
//
//  Created by 华四MAC on 16/7/18.
//  Copyright © 2016年 华四MAC. All rights reserved.
//

#import "BaseViewController.h"
#import "SK_WeiModel.h"

@class Home2_ENDListModel;
@class Home2_ENDListModelCell;
@class Home2_ENDRoom_ListModelCell;


@interface ViewController_Page2 : BaseViewController

@end



@interface Home2_ENDListModel : NSObject
@property (nonatomic, strong) NSArray<Home2_ENDListModelCell *> *data;


@end


@interface Home2_ENDListModelCell : NSObject
@property (nonatomic , strong) NSString *Id;               //房间id号
@property (nonatomic , strong) NSString *date;  // = "2017-09-28";
@property (nonatomic , strong) NSString *get_reward_id;//" = 1187;领取奖励的id
@property (nonatomic , strong) NSString *get_status;//" = 0; //领奖状态 0未领取 1已领取 2未获奖
@property (nonatomic , strong) NSString *guess_num;//" = 1;
@property (nonatomic , strong) NSString *is_reward;//" = 20;       奖品-----赛睿机械鼠标",
@property (nonatomic , strong) NSString *lineup_id;//" = 13107;
@property (nonatomic , assign)  float   lineup_score;//" = "404.4";阵容积分"
@property (nonatomic , strong) NSString *project_id;//" = 5;
@property (nonatomic , strong) NSString *ranking;;// = 36;排名
@property (nonatomic , strong) NSString *room_id;//" = 195;
@property (nonatomic , strong) NSString *settlement_status;//2

@property (nonatomic , strong) Home2_ENDRoom_ListModelCell    *room_info;           //


@end

//room_info
@interface Home2_ENDRoom_ListModelCell : NSObject
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
@property (nonatomic , strong) NSString *join_num; ///5",
@property (nonatomic , strong) NSString *guess_id;   //22"



@end










