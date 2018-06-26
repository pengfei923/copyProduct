//
//  PlayerInfoViewController.m
//  AFM
//
//  Created by admin on 2017/9/14.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "PlayerInfoViewController.h"
#import "Top_PlayerTableViewCell.h"
#import "Top_Player1TableViewCell.h"
#import "Player_TopTableViewCell.h"
#import "PlayerMegTableViewCell.h"
#import "Player_teamModel.h"
#import "SJPlayer_NBATableViewCell.h"

@interface PlayerInfoViewController ()<UITableViewDelegate , UITableViewDataSource, topChooseDelegate>

@property (nonatomic , strong) UITableView *tableView;          //列表视图
@property (nonatomic , strong) NSString *num;

@property (nonatomic , strong) NSMutableArray *listData;         //

@end

@implementation PlayerInfoViewController

NSString *Top_View = @"Top_PlayerTableViewCell";
NSString *Top1_View = @"Top_Player1TableViewCell";
NSString *Choose_cell = @"Player_TopTableViewCell";
NSString *Megplayer_cell = @"PlayerMegTableViewCell";
NSString *SJ_nba_Cell = @"SJPlayer_NBATableViewCell";

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
    self.navigationItem.title = @"球员信息";
    
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
    [self.tableView registerClass:[Top_PlayerTableViewCell class] forCellReuseIdentifier:Top_View];
    [self.tableView registerClass:[Top_Player1TableViewCell class] forCellReuseIdentifier:Top1_View];
    [self.tableView registerClass:[Player_TopTableViewCell class] forCellReuseIdentifier:Choose_cell];
    [self.tableView registerClass:[PlayerMegTableViewCell class] forCellReuseIdentifier:Megplayer_cell];
    [self.tableView registerClass:[SJPlayer_NBATableViewCell class] forCellReuseIdentifier:SJ_nba_Cell];
    
    [self.view addSubview:self.tableView];
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.num = @"2";

}

-(void)refreshNum:(NSString *)num{
    _num = num;
    [_tableView reloadData];
}


//初始化数据
- (void)initData {
    if (self.JCPlayer.Id) {
        self.player_id = self.JCPlayer.Id;
    }
    if (self.Player.player_id) {
        self.player_id = self.self.Player.player_id;
    }
    
    if ([self.lol_data_nba isEqualToString:@"nba"]) {
        NSString *urlStr = @"http://api.aifamu.com/index.php?m=extra&a=playermatchdata&apptype=app&version=1";
        NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                    @"player_id":self.player_id  };
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
                self.deF = [NSString stringWithFormat:@"%@",[dic_Down objectForKey:@"get_score"]];
                self.sanF = [NSString stringWithFormat:@"%@",[dic_Down objectForKey:@"three_point"]];
                self.lanB = [NSString stringWithFormat:@"%@",[dic_Down objectForKey:@"backboard"]];
                self.zhuG = [NSString stringWithFormat:@"%@",[dic_Down objectForKey:@"help_score"]];
                self.qiangD = [NSString stringWithFormat:@"%@",[dic_Down objectForKey:@"hinder_score"]];
                self.fengG = [NSString stringWithFormat:@"%@",[dic_Down objectForKey:@"cover_score"]];
                self.shiW = [NSString stringWithFormat:@"%@",[dic_Down objectForKey:@"mistake_score"]];
                self.jiF = [NSString stringWithFormat:@"%@",[dic_Down objectForKey:@"score"]];  //积分
                self.time = [NSString stringWithFormat:@"%@",[dic_Down objectForKey:@"play_time"]];

                NSDictionary *dic_Data = [[dic objectForKey:@"data"] objectForKey:@"player_data"];
                self.play_num = [NSString stringWithFormat:@"%@",[dic_Data objectForKey:@"play_num"]];
                self.play_time = [NSString stringWithFormat:@"%@",[dic_Data objectForKey:@"play_time"]];
                self.listModel = [Player_ModelCell yy_modelWithDictionary:[dic objectForKey:@"data"]];

            }
            [self initPlayer_team];
          //  [self.tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
}

- (void)initPlayer_team{
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=match&a=team&apptype=app&version=1";
    NSDictionary *paramters = @{@"project_id":self.listModel.player_data.team_id };
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
                if (model.Id == self.listModel.player_data.team_id) {
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
        return 180;
    }else if (indexPath.row == 1){
        return 44;
    }else{
        if ([_num isEqualToString:@"2"]) {
            return [UIScreen mainScreen].bounds.size.height - 224;
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
        Top_PlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Top_View];
        if (self.JCPlayer.Id) {
            [cell.icon_ImgV yy_setImageWithURL:[NSURL URLWithString:self.JCPlayer.img] placeholder:[UIImage imageNamed:@"player-photo"]];
            cell.name_Lab.text = self.JCPlayer.name;
            cell.money_Lab.text = [NSString stringWithFormat:@" $%@ ",self.JCPlayer.salary];
        }else{
            [cell.icon_ImgV yy_setImageWithURL:[NSURL URLWithString:self.IMG] placeholder:[UIImage imageNamed:@"player-photo"]];
            cell.name_Lab.text = self.NAME;
            cell.money_Lab.text = [NSString stringWithFormat:@" $%@ ",self.SALARY];

        }
        if (self.Player.player_id) {
            [cell.icon_ImgV yy_setImageWithURL:[NSURL URLWithString:self.Player.img] placeholder:[UIImage imageNamed:@"player-photo"]];
            cell.name_Lab.text = self.Player.name;
            cell.money_Lab.text = [NSString stringWithFormat:@" $%@  ",self.Player.salary];
        }

        cell.time_Lab.text = [NSString stringWithFormat:@"%@",self.next_Time];
        if (self.next_opponents.length > 0) {
            cell.vs_Lab.text = [NSString stringWithFormat:@"%@ vs %@",self.team_name,self.next_opponents];
        }else{
            cell.vs_Lab.text = @"";
        }
        
        cell.defen_Lab.text = self.deF;
        cell.sanfen_Lab.text = self.sanF;
        cell.lanban_Lab.text = self.lanB;
        cell.zhugong_Lab.text = self.zhuG;
        cell.qiangd_Lab.text = self.qiangD;
        cell.fengg_Lab.text = self.fengG;
        cell.shiwu_Lab.text = self.shiW;
        if (self.JCPlayer.Id) {
            int Avg_number = [[NSString stringWithFormat:@"%0.2f",self.JCPlayer.average] intValue];
            cell.chart.current = [NSNumber numberWithInt:Avg_number];
        }
        if (self.Player.player_id) {
            int Avg_number = [[NSString stringWithFormat:@"%0.2f",self.Player.average] intValue];
            cell.chart.current = [NSNumber numberWithInt:Avg_number];
        }

        int Num_number = [self.play_num intValue];
        int Time_number = [self.play_time intValue];
        cell.chart.chartType = PNChartFormatTypeNone;
        cell.chart1.chartType = PNChartFormatTypeNone;
        cell.chart2.chartType = PNChartFormatTypeNone;
        cell.chart1.current = [NSNumber numberWithInt:Num_number];
        cell.chart2.current = [NSNumber numberWithInt:Time_number];
        [cell.chart strokeChart];
        [cell.chart1 strokeChart];
        [cell.chart2 strokeChart];
        
        cell.Model = self.listModel;
        
        if (self.JCPlayer.Id) {
            self.position = self.JCPlayer.position;
        }
        if (self.Player.player_id) {
            self.position = self.Player.position;
        }

        if ([self.position isEqualToString:@"1"]) {
            cell.work_Lab.text = [NSString stringWithFormat:@"%@  控卫",self.team_name];
        }else if ([self.position isEqualToString:@"2"]){
            cell.work_Lab.text = [NSString stringWithFormat:@"%@  分卫",self.team_name];
        }else if ([self.position isEqualToString:@"3"]){
            cell.work_Lab.text = [NSString stringWithFormat:@"%@  小前",self.team_name];
        }else if ([self.position isEqualToString:@"4"]){
            cell.work_Lab.text = [NSString stringWithFormat:@"%@  大前",self.team_name];
        }else if ([self.position isEqualToString:@"5"]){
            cell.work_Lab.text = [NSString stringWithFormat:@"%@  中锋",self.team_name];
        }else{
        }
        
        return cell;
        
    }else if (indexPath.row == 1){
        Player_TopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Choose_cell];
        cell.delegate = self;
        return cell;
    }else{
        if ([_num isEqualToString:@"1"]) {
            PlayerMegTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Megplayer_cell];
            cell.concer_Lab.hidden = YES;
            cell.title_Lab.hidden = YES;
            return cell;
        }else {
            SJPlayer_NBATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SJ_nba_Cell];
            cell.model = self.listModel;
            cell.deF = self.deF;
            cell.sanF = self.sanF;
            cell.lanB = self.lanB;
            cell.zhuG = self.zhuG;
            cell.qiangD = self.qiangD;
            cell.fengG = self.fengG;
            cell.shiW = self.shiW;
            cell.jiF = self.jiF;
            cell.time = self.time;

            [cell.tableView reloadData];
            [cell.tableView2 reloadData];
            return cell;
        }
    }
}


@end









@implementation Player_Model
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [Player_ModelCell class]};
}
@end


@implementation Player_ModelCell
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"player_data":[Player_Data_ModelCell class] , @"match_info":[Player_Info_ModelCell class],@"all_match_info":[PlayerModel_All_Cell class],@"ten_match_info":[PlayerModel_Ten_Cell class],@"season_avg_10":[Player_avg10_ModelCell class]};
    
}
@end

@implementation Player_Data_ModelCell
@end


@implementation Player_Info_ModelCell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id" };
}
@end
@implementation PlayerModel_All_Cell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id" };
}
@end
@implementation PlayerModel_Ten_Cell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id" };
}
@end
@implementation Player_avg10_ModelCell
@end


















/**
 PNLineChart *lineChart = [[PNLineChart alloc]initWithFrame:CGRectMake(0, 0, 220, 70)];
 //设置背景颜色
 lineChart.backgroundColor = [UIColor clearColor];
 lineChart.axisWidth = 1.0;
 [lineChart setXLabels:@[@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" "]];
 [lineChart setYLabels:@[@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" "]];
 
 // Line Chart No.1
 NSMutableArray *data01Array  = [[NSMutableArray alloc ] init];
 if (self.JCPlayer) {
 data01Array = self.JCPlayer.last_ten_score;
 }
 if (self.Player) {
 data01Array = self.listModel.last_ten_score;
 }
 NSLog(@"%@",[data01Array yy_modelDescription]);
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
 if (self.JCPlayer.Id) {
 AAAAAA[i] = [NSString stringWithFormat:@"%0.2f",self.JCPlayer.average];
 }
 if (self.Player.player_id) {
 AAAAAA[i] = [NSString stringWithFormat:@"%0.2f",self.Player.average];
 }
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
 */
