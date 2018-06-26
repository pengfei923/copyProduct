//
//  NBA_ChooPlayerViewController.h
//  AFM
//
//  Created by admin on 2017/10/23.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BaseViewController.h"

@class NBAModel1;
@class NBAModel1Cell;
@class NBAModel2;
@class NBAModel2Cell;
@class NBAModel3;
@class NBAModel3Cell;
@class NBAModel4;
@class NBAModel4Cell;
@class NBAModel5;
@class NBAModel5Cell;
@class NBAModel6;
@class NBAModel6Cell;
@class NBAModel7;
@class NBAModel7Cell;
@class NBAModel8;
@class NBAModel8Cell;



typedef void (^NBAmodel1Block) (NBAModel1Cell  *model1,NBAModel2Cell  *model2,NBAModel3Cell  *model3,NBAModel4Cell  *model4,NBAModel5Cell  *model5,NBAModel6Cell  *model6,NBAModel7Cell  *model7,NBAModel8Cell  *model8);

@interface NBA_ChooPlayerViewController : BaseViewController

@property(nonatomic, copy) NBAmodel1Block returnNbaModel1;


@property (nonatomic , strong) NSString *typeOder_num;   //左边View编号
@property (nonatomic , strong) NSString *roomId;         //房间id号
@property (nonatomic , strong) NSNumber *allGZ;          //
@property (nonatomic , strong) NSString *type_id;        //5人房/8人房

@property (nonatomic , strong) NSMutableArray *block_Arr;               //

@property (nonatomic , strong) NBAModel1Cell *model1;              //model1
@property (nonatomic , strong) NBAModel2Cell *model2;              //model2
@property (nonatomic , strong) NBAModel3Cell *model3;              //model3
@property (nonatomic , strong) NBAModel4Cell *model4;              //model4
@property (nonatomic , strong) NBAModel5Cell *model5;              //model5
@property (nonatomic , strong) NBAModel6Cell *model6;              //model6
@property (nonatomic , strong) NBAModel7Cell *model7;              //model7
@property (nonatomic , strong) NBAModel8Cell *model8;              //model8

//-----------------TopView----------------
@property (weak, nonatomic) IBOutlet UIButton *topButton1;
@property (weak, nonatomic) IBOutlet UIButton *topButton2;
@property (weak, nonatomic) IBOutlet UIButton *topButton3;

//-----------------TableView---------------
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//-----------------LeftView---------------
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
//5/8人显示
@property (weak, nonatomic) IBOutlet UIView *down3View;


//-----------------downView----------------
@property (weak, nonatomic) IBOutlet UILabel *PJ_Lab;
@property (weak, nonatomic) IBOutlet UILabel *GZ_Lab;
@property (weak, nonatomic) IBOutlet UIButton *next_Btn;


@end





//----------------------------------------------------------------------------------------
@interface NBAModel1 : NSObject
@property (nonatomic, strong) NSArray<NBAModel1Cell *> *data;
@end
@interface NBAModel1Cell : NSObject
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

@interface NBAModel2 : NSObject
@property (nonatomic, strong) NSArray<NBAModel2Cell *> *data;
@end
@interface NBAModel2Cell : NSObject
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

@interface NBAModel3 : NSObject
@property (nonatomic, strong) NSArray<NBAModel3Cell *> *data;
@end
@interface NBAModel3Cell : NSObject
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

@interface NBAModel4 : NSObject
@property (nonatomic, strong) NSArray<NBAModel4Cell *> *data;
@end
@interface NBAModel4Cell : NSObject
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

@interface NBAModel5 : NSObject
@property (nonatomic, strong) NSArray<NBAModel5Cell *> *data;
@end
@interface NBAModel5Cell : NSObject
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

@interface NBAModel6 : NSObject
@property (nonatomic, strong) NSArray<NBAModel6Cell *> *data;
@end
@interface NBAModel6Cell : NSObject
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

@interface NBAModel7 : NSObject
@property (nonatomic, strong) NSArray<NBAModel7Cell *> *data;
@end
@interface NBAModel7Cell : NSObject
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

@interface NBAModel8 : NSObject
@property (nonatomic, strong) NSArray<NBAModel8Cell *> *data;
@end
@interface NBAModel8Cell : NSObject
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

