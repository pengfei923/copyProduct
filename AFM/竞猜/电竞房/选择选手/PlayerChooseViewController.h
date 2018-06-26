//
//  PlayerChooseViewController.h
//  AFM
//
//  Created by admin on 2017/9/14.
//  Copyright © 2017年 sgamer. All rights reserved.
//

@class Player_ListModel;
@class Player_ListModelCell;
@class Player_MatchModelCell;

@class DJModel1;
@class DJModel1Cell;
@class DJModel2;
@class DJModel2Cell;
@class DJModel3;
@class DJModel3Cell;
@class DJModel4;
@class DJModel4Cell;
@class DJModel5;
@class DJModel5Cell;
@class DJModel6;
@class DJModel6Cell;
@class DJModel7;
@class DJModel7Cell;
@class DJModel8;
@class DJModel8Cell;

#import "BaseViewController.h"

typedef void (^DJmodel1Block) (DJModel1Cell  *model1,DJModel2Cell  *model2,DJModel3Cell  *model3,DJModel4Cell  *model4,DJModel5Cell  *model5,DJModel6Cell  *model6,DJModel7Cell  *model7,DJModel8Cell  *model8);

@interface PlayerChooseViewController : BaseViewController

@property(nonatomic, copy) DJmodel1Block returnDJModel1;

@property (nonatomic , strong) NSString *typeOder_num;   //左边View编号
@property (nonatomic , strong) NSString *roomId;         //房间id号
@property (nonatomic , strong) NSString *type_Ren;       //(lol,dota.nba)
@property (nonatomic , strong) NSNumber *allGZ;          //

@property (nonatomic , strong) NSMutableArray *block_Arr;               //


@property (nonatomic , strong) DJModel1Cell *model1;              //model1
@property (nonatomic , strong) DJModel2Cell *model2;              //model2
@property (nonatomic , strong) DJModel3Cell *model3;              //model3
@property (nonatomic , strong) DJModel4Cell *model4;              //model4
@property (nonatomic , strong) DJModel5Cell *model5;              //model5
@property (nonatomic , strong) DJModel6Cell *model6;              //model6
@property (nonatomic , strong) DJModel7Cell *model7;              //model7
@property (nonatomic , strong) DJModel8Cell *model8;              //model8







//-----------------TopView----------------
@property (weak, nonatomic) IBOutlet UIButton *topButton1;
@property (weak, nonatomic) IBOutlet UIButton *topButton2;
@property (weak, nonatomic) IBOutlet UIButton *topButton3;

//-----------------TableView---------------
@property (weak, nonatomic) IBOutlet UITableView *tableView;


//-----------------LeftView---------------
//视图
@property (weak, nonatomic) IBOutlet UIView *LeftView1;
@property (weak, nonatomic) IBOutlet UIView *LeftView2;
@property (weak, nonatomic) IBOutlet UIView *LeftView3;
@property (weak, nonatomic) IBOutlet UIView *LeftView4;
@property (weak, nonatomic) IBOutlet UIView *LeftView5;
@property (weak, nonatomic) IBOutlet UIView *LeftView6;
@property (weak, nonatomic) IBOutlet UIView *LeftView7;
@property (weak, nonatomic) IBOutlet UIView *LeftView8;
//名称lable
@property (weak, nonatomic) IBOutlet UILabel *name1_lab;
@property (weak, nonatomic) IBOutlet UILabel *name2_lab;
@property (weak, nonatomic) IBOutlet UILabel *name3_lab;
@property (weak, nonatomic) IBOutlet UILabel *name4_lab;
@property (weak, nonatomic) IBOutlet UILabel *name5_lab;
@property (weak, nonatomic) IBOutlet UILabel *name6_lab;
@property (weak, nonatomic) IBOutlet UILabel *name7_lab;
@property (weak, nonatomic) IBOutlet UILabel *name8_lab;
//数字lable
@property (weak, nonatomic) IBOutlet UILabel *num1_lab;
@property (weak, nonatomic) IBOutlet UILabel *num2_lab;
@property (weak, nonatomic) IBOutlet UILabel *num3_lab;
@property (weak, nonatomic) IBOutlet UILabel *num4_lab;
@property (weak, nonatomic) IBOutlet UILabel *num5_lab;
@property (weak, nonatomic) IBOutlet UILabel *num6_lab;
@property (weak, nonatomic) IBOutlet UILabel *num7_lab;
@property (weak, nonatomic) IBOutlet UILabel *num8_lab;
//按钮
@property (weak, nonatomic) IBOutlet UIButton *left_Btn1;
@property (weak, nonatomic) IBOutlet UIButton *left_Btn2;
@property (weak, nonatomic) IBOutlet UIButton *left_Btn3;
@property (weak, nonatomic) IBOutlet UIButton *left_Btn4;
@property (weak, nonatomic) IBOutlet UIButton *left_Btn5;
@property (weak, nonatomic) IBOutlet UIButton *left_Btn6;
@property (weak, nonatomic) IBOutlet UIButton *left_Btn7;
@property (weak, nonatomic) IBOutlet UIButton *left_Btn8;


//-----------------downView----------------
@property (weak, nonatomic) IBOutlet UILabel *PJ_Lab;
@property (weak, nonatomic) IBOutlet UILabel *GZ_Lab;
@property (weak, nonatomic) IBOutlet UIButton *next_Btn;


@end


@interface Player_ListModel : NSObject
@property (nonatomic, strong) NSArray<Player_ListModelCell *> *data;


@end


@interface Player_ListModelCell : NSObject
@property (nonatomic , strong) NSString *Id;               //id号
@property (nonatomic , strong) NSString *salary;           //工资
@property (nonatomic , assign) double average;             //平均分
@property (nonatomic , assign) double KDA;                  //KDA
@property (nonatomic , assign) double play_time;           //出场时间

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

@property (nonatomic , strong) Player_MatchModelCell *match_data;
@property (nonatomic , assign) BOOL isDisplay;  //选中
@property (nonatomic , assign) BOOL isNO;       //替补页面显示选中
@end

@interface Player_MatchModelCell : NSObject
@property (nonatomic , strong) NSString *Id;                   //id号"
@property (nonatomic , strong) NSString *team_a;                   //房间id号"
@property (nonatomic , strong) NSString *team_b;                   //房间id号"
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


//----------------------------------------------------------------------------------------
@interface DJModel1 : NSObject
@property (nonatomic, strong) NSArray<DJModel1Cell *> *data;
@end
@interface DJModel1Cell : NSObject
@property (nonatomic , strong) NSString *Id;               //房间id号
@property (nonatomic , strong) NSString *salary;           //工资
@property (nonatomic , assign) double average;             //平均分
@property (nonatomic , assign) double KDA;                 //出场时间
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

@interface DJModel2 : NSObject
@property (nonatomic, strong) NSArray<DJModel2Cell *> *data;
@end
@interface DJModel2Cell : NSObject
@property (nonatomic , strong) NSString *Id;               //房间id号
@property (nonatomic , strong) NSString *salary;           //工资
@property (nonatomic , assign) double average;             //平均分
@property (nonatomic , assign) double KDA;                 //出场时间
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

@interface DJModel3 : NSObject
@property (nonatomic, strong) NSArray<DJModel3Cell *> *data;
@end
@interface DJModel3Cell : NSObject
@property (nonatomic , strong) NSString *Id;               //房间id号
@property (nonatomic , strong) NSString *salary;           //工资
@property (nonatomic , assign) double average;             //平均分
@property (nonatomic , assign) double KDA;                 //出场时间
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

@interface DJModel4 : NSObject
@property (nonatomic, strong) NSArray<DJModel4Cell *> *data;
@end
@interface DJModel4Cell : NSObject
@property (nonatomic , strong) NSString *Id;               //房间id号
@property (nonatomic , strong) NSString *salary;           //工资
@property (nonatomic , assign) double average;             //平均分
@property (nonatomic , assign) double KDA;                 //出场时间
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

@interface DJModel5 : NSObject
@property (nonatomic, strong) NSArray<DJModel5Cell *> *data;
@end
@interface DJModel5Cell : NSObject
@property (nonatomic , strong) NSString *Id;               //房间id号
@property (nonatomic , strong) NSString *salary;           //工资
@property (nonatomic , assign) double average;             //平均分
@property (nonatomic , assign) double KDA;                 //出场时间
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

@interface DJModel6 : NSObject
@property (nonatomic, strong) NSArray<DJModel6Cell *> *data;
@end
@interface DJModel6Cell : NSObject
@property (nonatomic , strong) NSString *Id;               //房间id号
@property (nonatomic , strong) NSString *salary;           //工资
@property (nonatomic , assign) double average;             //平均分
@property (nonatomic , assign) double KDA;                 //出场时间
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

@interface DJModel7 : NSObject
@property (nonatomic, strong) NSArray<DJModel7Cell *> *data;
@end
@interface DJModel7Cell : NSObject
@property (nonatomic , strong) NSString *Id;               //房间id号
@property (nonatomic , strong) NSString *salary;           //工资
@property (nonatomic , assign) double average;             //平均分
@property (nonatomic , assign) double KDA;                 //出场时间
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

@interface DJModel8 : NSObject
@property (nonatomic, strong) NSArray<DJModel8Cell *> *data;
@end
@interface DJModel8Cell : NSObject
@property (nonatomic , strong) NSString *Id;               //房间id号
@property (nonatomic , strong) NSString *salary;           //工资
@property (nonatomic , assign) double average;             //平均分
@property (nonatomic , assign) double KDA;                 //出场时间
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




