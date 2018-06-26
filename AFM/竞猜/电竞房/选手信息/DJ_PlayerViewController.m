//
//  DJ_PlayerViewController.m
//  AFM
//
//  Created by admin on 2017/10/30.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "DJ_PlayerViewController.h"
#import "Top_Player1TableViewCell.h"
#import "Player_TopTableViewCell.h"
#import "PlayerMegTableViewCell.h"
#import "BSRZ_TableViewCell.h"

@interface DJ_PlayerViewController ()<UITableViewDelegate , UITableViewDataSource,topChooseDelegate>

@property (nonatomic , strong) UITableView *tableView;          //列表视图
@property (nonatomic , strong) NSString *num;
@property (nonatomic , strong) NSMutableArray *listData;         //

@end



@implementation DJ_PlayerViewController

NSString *Top_View1 = @"Top_Player1TableViewCell";
NSString *Choose_cell1 = @"Player_TopTableViewCell";
NSString *Megplayer_cell1 = @"PlayerMegTableViewCell";
NSString *BSRZ_cell1 = @"BSRZ_TableViewCell";

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES]; //显示导航
    [self initData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
}

//初始化导航栏
- (void)initNavigation {
    if ([self.JCPlayer.position isEqualToString:@"6"]) {
        self.navigationItem.title = @"战队信息";
    }else{
        self.navigationItem.title = @"选手信息";
    }
}


//初始化界面
- (void)initView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.mainWidth, self.mainHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.showsVerticalScrollIndicator = NO;  // 滚动条
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线
    self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView registerClass:[Top_Player1TableViewCell class] forCellReuseIdentifier:Top_View1];
    [self.tableView registerClass:[PlayerMegTableViewCell class] forCellReuseIdentifier:Megplayer_cell1];
    [self.tableView registerClass:[Player_TopTableViewCell class] forCellReuseIdentifier:Choose_cell1];
    [self.tableView registerClass:[BSRZ_TableViewCell class] forCellReuseIdentifier:BSRZ_cell1];
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
    
    self.num = @"2";
}

-(void)refreshNum:(NSString *)num{
    _num = num;
    [_tableView reloadData];
}


//初始化数据
- (void)initData {
    if (self.JCPlayer.Id.length != 0) {
        self.ID_ = self.JCPlayer.Id;
    }else if (self.Player.player_id.length != 0){
        self.ID_ = self.Player.player_id;
    }else{
        
    }
    if ([self.lol_data_nba isEqualToString:@"lol"]) { //获取LOL选手比赛数据
        NSString *urlStr = @"http://api.aifamu.com/index.php?m=extra&a=lolplayermatchdata&apptype=app&version=1";
        NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                    @"player_id":self.ID_ };
        AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
        [manager setSecurityPolicy:[AFMHTTPSManager customSecurityPolicy]];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST: urlStr parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            if ([[dic objectForKey:@"error"]isEqualToNumber:@0]) {
                NSDictionary *dicData_next = [[dic objectForKey:@"data"] objectForKey:@"next_match"];
                self.next_Time = [NSString stringWithFormat:@"%@",[dicData_next objectForKey:@"match_time"]];
                self.next_opponents = [NSString stringWithFormat:@"%@",[dicData_next objectForKey:@"opponents"]];
                
                NSDictionary *dic_Down = [[dic objectForKey:@"data"] objectForKey:@"season_avg"];
                self.jiS = [NSString stringWithFormat:@"%@",[dic_Down objectForKey:@"kill"]];
                self.zhuG = [NSString stringWithFormat:@"%@",[dic_Down objectForKey:@"assists"]];
                self.dail = [NSString stringWithFormat:@"%@",[dic_Down objectForKey:@"death"]];
                self.buD = [NSString stringWithFormat:@"%@",[dic_Down objectForKey:@"jungle"]];
                
                self.chaiT = [NSString stringWithFormat:@"%@",[dic_Down objectForKey:@"tower"]];
                self.yiX = [NSString stringWithFormat:@"%@",[dic_Down objectForKey:@"first_blood"]];
                self.daL = [NSString stringWithFormat:@"%@",[dic_Down objectForKey:@"barons"]];
                self.xiaoL = [NSString stringWithFormat:@"%@",[dic_Down objectForKey:@"dragons"]];

                self.PlayerCell = [DJ_PlayerModelCell yy_modelWithDictionary:[dic objectForKey:@"data"]];
                
            }
            [self initPlayer_team];
            [self.tableView reloadData];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }else{
        NSString *urlStr = @"http://api.aifamu.com/index.php?m=extra&a=dota2playermatchdata&apptype=app&version=1";
        NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                    @"player_id":self.ID_ };
        AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
        [manager setSecurityPolicy:[AFMHTTPSManager customSecurityPolicy]];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST: urlStr parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            if ([[dic objectForKey:@"error"]isEqualToNumber:@0]) {
                NSDictionary *dicData_next = [[dic objectForKey:@"data"] objectForKey:@"next_match"];
                self.next_Time = [NSString stringWithFormat:@"%@",[dicData_next objectForKey:@"match_time"]];
                self.next_opponents = [NSString stringWithFormat:@"%@",[dicData_next objectForKey:@"opponents"]];
                
                NSDictionary *dic_Down = [[dic objectForKey:@"data"] objectForKey:@"season_avg"];
                self.jiS = [NSString stringWithFormat:@"%@",[dic_Down objectForKey:@"kill"]];
                self.zhuG = [NSString stringWithFormat:@"%@",[dic_Down objectForKey:@"assists"]];
                self.dail = [NSString stringWithFormat:@"%@",[dic_Down objectForKey:@"death"]];
                self.buD = [NSString stringWithFormat:@"%@",[dic_Down objectForKey:@"jungle"]];
                self.chaiT = [NSString stringWithFormat:@"%@",[dic_Down objectForKey:@"tower"]];
                self.yiX = [NSString stringWithFormat:@"%@",[dic_Down objectForKey:@"first_blood"]];
                self.rouS = [NSString stringWithFormat:@"%@",[dic_Down objectForKey:@"barons"]];
                
                self.PlayerCell = [DJ_PlayerModelCell yy_modelWithDictionary:[dic objectForKey:@"data"]];
            }
            [self initPlayer_team];
            [self.tableView reloadData];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
 
    }

}
//获取所有的球队信息
- (void)initPlayer_team{
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=match&a=team&apptype=app&version=1";
    NSDictionary *paramters = @{@"project_id":self.PlayerCell.player_data.team_id };
    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
    [manager setSecurityPolicy:[AFMHTTPSManager customSecurityPolicy]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST: urlStr parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        if ([[dic objectForKey:@"error"]isEqualToNumber:@0]) {
            Player_teamModel *listModel = [Player_teamModel yy_modelWithDictionary:dic];
            self.listData = [[NSMutableArray alloc]initWithArray:listModel.data];
            for (Player_teamModelCell *model in listModel.data) {
                if (model.Id == self.PlayerCell.player_data.team_id) {
                    self.team_name = model.name;
                }
            }
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}



#pragma mark - 列表代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_num isEqualToString:@"1"]) {
        return 7;//相关消息
    }else {
        return 3;//比赛日志
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 150;
    }else if (indexPath.row == 1){
        return 44;
    }else{
        if ([_num isEqualToString:@"2"]) {
            return [UIScreen mainScreen].bounds.size.height - 194;
        }else {
            return 100;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        Top_Player1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Top_View1];
        
        if (self.PlayerCell.player_data.name) {
            [cell.iconImgView yy_setImageWithURL:[NSURL URLWithString:self.PlayerCell.player_data.img] placeholder:[UIImage imageNamed:@"player-photo"]];
            cell.name_Lab.text = [NSString stringWithFormat:@"%@",self.PlayerCell.player_data.name];
            cell.money_Lab.text = [NSString stringWithFormat:@"$%@ ",self.PlayerCell.player_data.salary];
        }else{
        }

        if (self.next_Time.length == 0) {
            cell.time_Lab.hidden = YES;
        }else{
            cell.time_Lab.text = [NSString stringWithFormat:@"%@",self.next_Time];
        }
        if (self.next_opponents.length == 0) {
            cell.vs_Lab.hidden = YES;
        }else{
            cell.vs_Lab.text = [NSString stringWithFormat:@"%@ vs %@",self.team_name,self.next_opponents];
        }
        cell.downView2.hidden = YES;
        cell.downView1.hidden = NO;

        
        if ([self.lol_data_nba isEqualToString:@"lol"]) {
            if ([self.PlayerCell.player_data.position isEqualToString:@"1"]) {
                cell.work_Lab.text = [NSString stringWithFormat:@"%@  上单",self.team_name];
            }else if ([self.PlayerCell.player_data.position isEqualToString:@"2"]){
                cell.work_Lab.text = [NSString stringWithFormat:@"%@  打野",self.team_name];
            }else if ([self.PlayerCell.player_data.position isEqualToString:@"3"]){
                cell.work_Lab.text = [NSString stringWithFormat:@"%@  中单",self.team_name];
            }else if ([self.PlayerCell.player_data.position isEqualToString:@"4"]){
                cell.work_Lab.text = [NSString stringWithFormat:@"%@  ADC",self.team_name];
            }else if ([self.PlayerCell.player_data.position isEqualToString:@"5"]){
                cell.work_Lab.text = [NSString stringWithFormat:@"%@  辅助",self.team_name];
            }else if ([self.PlayerCell.player_data.position isEqualToString:@"6"]){
                cell.work_Lab.text = [NSString stringWithFormat:@"%@  团队",self.team_name];
            }else{}
            
            if ([self.PlayerCell.player_data.position isEqualToString:@"6"]) {
                cell.downView1.hidden = YES;
                cell.downView2.hidden = NO;
                
                cell.zhaJ_Lab.text = [NSString stringWithFormat:@"%@",self.PlayerCell.player_data.result];
                cell.chaT_Lab.text = [NSString stringWithFormat:@"%@",self.chaiT];
                cell.yiX_Lab.text = [NSString stringWithFormat:@"%@",self.yiX];
                cell.daL_Lab.text = [NSString stringWithFormat:@"%@",self.daL];
                cell.xiaoL_Lab.text = [NSString stringWithFormat:@"%@",self.xiaoL];
                cell.pingJ_lab.text = [NSString stringWithFormat:@"%0.1f",self.PlayerCell.player_data.average];
                
            }else{
                cell.downView2.hidden = YES;
                cell.downView1.hidden = NO;

                cell.jiasha_Lab.text = [NSString stringWithFormat:@"%@",self.jiS];
                cell.zhugong_Lab.text = [NSString stringWithFormat:@"%@",self.zhuG];
                cell.die_Lab.text = [NSString stringWithFormat:@"%@",self.dail];
                cell.budao_Lab.text = [NSString stringWithFormat:@"%@",self.buD];
                cell.average_Lab.text = [NSString stringWithFormat:@"%0.1f",self.PlayerCell.player_data.average];
            }
        }else{
            if ([self.PlayerCell.player_data.position isEqualToString:@"1"]) {
                cell.work_Lab.text = [NSString stringWithFormat:@"%@  一号位",self.team_name];
            }else if ([self.PlayerCell.player_data.position isEqualToString:@"2"]){
                cell.work_Lab.text = [NSString stringWithFormat:@"%@  二号位",self.team_name];
            }else if ([self.PlayerCell.player_data.position isEqualToString:@"3"]){
                cell.work_Lab.text = [NSString stringWithFormat:@"%@  三号位",self.team_name];
            }else if ([self.PlayerCell.player_data.position isEqualToString:@"4"]){
                cell.work_Lab.text = [NSString stringWithFormat:@"%@  四号位",self.team_name];
            }else if ([self.PlayerCell.player_data.position isEqualToString:@"5"]){
                cell.work_Lab.text = [NSString stringWithFormat:@"%@  五号位",self.team_name];
            }else if ([self.PlayerCell.player_data.position isEqualToString:@"6"]){
                cell.work_Lab.text = [NSString stringWithFormat:@"%@  战队",self.team_name];
            }else{}
            if ([self.PlayerCell.player_data.position isEqualToString:@"6"]) {
                cell.lable1.text = @"战绩";
                cell.lable2.text = @"拆塔";
                cell.lable3.text = @"一血";
                cell.lable4.text = @"肉山";
                cell.jiasha_Lab.text = [NSString stringWithFormat:@"%@",self.PlayerCell.player_data.result];
                cell.zhugong_Lab.text = [NSString stringWithFormat:@"%@",self.chaiT];
                cell.die_Lab.text = [NSString stringWithFormat:@"%@",self.yiX];
                cell.budao_Lab.text = [NSString stringWithFormat:@"%@",self.rouS];
                cell.average_Lab.text = [NSString stringWithFormat:@"%0.1f",self.PlayerCell.player_data.average];
            }else{
                cell.lable1.text = @"击杀";
                cell.lable2.text = @"助攻";
                cell.lable3.text = @"死亡";
                cell.lable4.text = @"补刀";
                cell.jiasha_Lab.text = [NSString stringWithFormat:@"%@",self.jiS];
                cell.zhugong_Lab.text = [NSString stringWithFormat:@"%@",self.zhuG];
                cell.die_Lab.text = [NSString stringWithFormat:@"%@",self.dail];
                cell.budao_Lab.text = [NSString stringWithFormat:@"%@",self.buD];
                cell.average_Lab.text = [NSString stringWithFormat:@"%0.1f",self.PlayerCell.player_data.average];
            }
            
        }
        //曲线图
        PNLineChart *lineChart = [[PNLineChart alloc]initWithFrame:CGRectMake(0, 0, 220, 70)];
        lineChart.backgroundColor = [UIColor clearColor];
        lineChart.axisWidth = 1.0;
        [lineChart setXLabels:@[@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" "]];
        [lineChart setYLabels:@[@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" "]];
        
        // Line Chart No.1
        NSMutableArray *data01Array = self.JCPlayer.last_ten_score;
        PNLineChartData *data01 = [PNLineChartData new];
        data01.color = [UIColor whiteColor];
        data01.itemCount = lineChart.xLabels.count;
        data01.getData = ^(NSUInteger index) {
            CGFloat yValue = [data01Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        // Line Chart No.2
        NSMutableArray *AAAAAA = [[NSMutableArray alloc] init];
        for(int i = 0;i < 10;i++){
            AAAAAA[i] = [NSString stringWithFormat:@"%0.2f",self.JCPlayer.average];
        }
        NSMutableArray * data02Array = AAAAAA;
        PNLineChartData *data02 = [PNLineChartData new];
        data02.color = [UIColor grayColor];
        data02.itemCount = lineChart.xLabels.count;
        data02.getData = ^(NSUInteger index) {
            CGFloat yValue = [data02Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        lineChart.chartData = @[data01, data02];
        [lineChart strokeChart];
        [cell.quView addSubview:lineChart];

        return cell;
    }else if (indexPath.row == 1){
        Player_TopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Choose_cell1];
        cell.delegate = self;
        return cell;
    }else{
        if ([_num isEqualToString:@"2"]) {
            BSRZ_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BSRZ_cell1];
            cell.model = self.PlayerCell;
            [cell.tableView reloadData];
            [cell.tableView2 reloadData];
            return cell;
        }else{
            PlayerMegTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Megplayer_cell1];
            cell.title_Lab.hidden = YES;
            cell.concer_Lab.hidden = YES;
            return cell;
        }
    }
        
}

@end




@implementation DJ_PlayerModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [DJ_PlayerModelCell class]};
}
@end

@implementation DJ_PlayerModelCell
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"player_data":[DJ_Player_DataModelCell class], @"all":[DJ_PlayerModel_All_Cell class], @"ten":[DJ_PlayerModel_Ten_Cell class], @"season":[DJ_PlayerModel_Season_Cell class] };
    
}
@end

@implementation DJ_Player_DataModelCell

@end

@implementation DJ_PlayerModel_All_Cell

@end
@implementation DJ_PlayerModel_Ten_Cell

@end
@implementation DJ_PlayerModel_Season_Cell

@end




















