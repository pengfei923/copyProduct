//
//  NBA_ChooPlayerViewController.m
//  AFM
//
//  Created by admin on 2017/10/23.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "NBA_ChooPlayerViewController.h"
#import "PlayerInfoViewController.h"
#import "PlayerTableViewCell.h"

@interface NBA_ChooPlayerViewController ()<UITableViewDelegate , UITableViewDataSource>{
    UIButton *rightbutton;
    NSString *TYPE_;          //工资高低（GZGD--GZDG）平均（PJGD--PJDG）KDA(KDAGD--KDADG)
}
@property (nonatomic , strong) NSMutableArray *Player_listData;         //
@property (nonatomic , strong) NSMutableArray *GZ_listData;             //排序后的Player_listData

@property (nonatomic , strong) NSMutableArray *location1_Data;          //
@property (nonatomic , strong) NSMutableArray *location2_Data;          //
@property (nonatomic , strong) NSMutableArray *location3_Data;          //
@property (nonatomic , strong) NSMutableArray *location4_Data;          //
@property (nonatomic , strong) NSMutableArray *location5_Data;          //
@property (nonatomic , strong) NSMutableArray *location6_Data;          //
@property (nonatomic , strong) NSMutableArray *location7_Data;          //
@property (nonatomic , strong) NSMutableArray *location8_Data;          //



@property (nonatomic , strong) NSMutableArray *selectIndexs;         //多选选中的行
@property (nonatomic , strong) NSMutableArray *PJ_arr;               //平均分总和数组
@property (nonatomic , strong) NSMutableArray *GZ_arr;               //工资总和数组
@property (nonatomic , strong) NSMutableArray *GoodsData;            //所有选择的队员--（需去重）
@property (nonatomic , strong) NSMutableArray *Z_playerData;         //最后选入isDis=1的选手



@end

@implementation NBA_ChooPlayerViewController

NSString *nbaPlayer_cellad = @"PlayerTableViewCell";

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES]; //显示导航
    if ([self.type_id isEqualToString:@"8"]) {    //8人
        self.down3View.hidden = NO;
    }else{
        self.down3View.hidden = YES;
    }
    
    [self initDownView];             //底部数据
    [self TongLeftView];             //左边数据
    
  
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
    [self initData];

}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"选择球员";
    //筛选
    UIImage *image1 = [UIImage imageNamed:@"filter-icon"];
    rightbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbutton.frame = CGRectMake(0, 0, image1.size.width, image1.size.height);
    [rightbutton addTarget:self action:@selector(Click_Choose:) forControlEvents:UIControlEventTouchDown];
    [rightbutton setImage:image1 forState:UIControlStateNormal];
    UIBarButtonItem *barrightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightbutton];
    self.navigationItem.rightBarButtonItem = barrightButtonItem;
    self.navigationItem.rightBarButtonItem.badgeBGColor = [UIColor getColorWithTheme];
    
}


//初始化界面
- (void)initView {
    [self initTopView];
    [self initTableView];
    [self initLeftView];
    
    self.name1_lab.text = @"控卫";
    self.name2_lab.text = @"分卫";
    self.name3_lab.text = @"小前";
    self.name4_lab.text = @"大前";
    self.name5_lab.text = @"中锋";
    self.name6_lab.text = @"后卫";
    self.name7_lab.text = @"前锋";
    self.name8_lab.text = @"任意";
    
    
    //五人/八人--------------------区分
    
}

- (void)initData {
    [self initPlayerData:@"GZGD"];
    //请求数据时
    self.GZ_listData    = [[NSMutableArray alloc] init];
    self.GoodsData      = [[NSMutableArray alloc] init];
    self.Z_playerData    = [[NSMutableArray alloc] init];

}

- (void)initPlayerData :(NSString *)TYPE{
    self.location1_Data  = [[NSMutableArray alloc] init];
    self.location2_Data  = [[NSMutableArray alloc] init];
    self.location3_Data  = [[NSMutableArray alloc] init];
    self.location4_Data  = [[NSMutableArray alloc] init];
    self.location5_Data  = [[NSMutableArray alloc] init];
    self.location6_Data  = [[NSMutableArray alloc] init];
    self.location7_Data  = [[NSMutableArray alloc] init];
    self.location8_Data  = [[NSMutableArray alloc] init];
    self.GZ_listData    = [[NSMutableArray alloc] init];
    
    
    
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=room&a=roomplayer&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                @"id":self.roomId };
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
            Player_ListModel *listModel = [Player_ListModel yy_modelWithDictionary:dic];
            self.Player_listData = [[NSMutableArray alloc]initWithArray:listModel.data];
            if ([TYPE isEqualToString:@"GZGD"]) {
                //工资高--低
                NSArray *SALA_GD = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"salary" ascending:NO]];
                NSMutableArray *SSSGD = [[NSMutableArray alloc] initWithArray:[listModel.data sortedArrayUsingDescriptors:SALA_GD]];
                self.GZ_listData  = [[NSMutableArray alloc] init];
                self.GZ_listData = SSSGD;
                self.location8_Data = SSSGD;
                for (Player_ListModelCell *model in self.GZ_listData) {
                    if([model.position isEqualToString:@"1"]){
                        [self.location1_Data addObject:model];
                        [self.location6_Data addObject:model];
                        
                    }else if ([model.position isEqualToString:@"2"]){
                        [self.location2_Data addObject:model];
                        [self.location6_Data addObject:model];

                    }else if ([model.position isEqualToString:@"3"]){
                        [self.location3_Data addObject:model];
                        [self.location7_Data addObject:model];

                    }else if ([model.position isEqualToString:@"4"]){
                        [self.location4_Data addObject:model];
                        [self.location7_Data addObject:model];

                    }else if ([model.position isEqualToString:@"5"]){
                        [self.location5_Data addObject:model];
                    }else{
                    }
                }

            }else if ([TYPE isEqualToString:@"GZDG"]){
                //工资低--高
                NSArray *SALA_DG = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"salary" ascending:YES]];
                NSMutableArray *SSSDG = [[NSMutableArray alloc] initWithArray:[listModel.data sortedArrayUsingDescriptors:SALA_DG]];
                self.GZ_listData  = [[NSMutableArray alloc] init];
                self.GZ_listData = SSSDG;
                self.location8_Data = SSSDG;

                for (Player_ListModelCell *model in self.GZ_listData) {
                    if([model.position isEqualToString:@"1"]){
                        [self.location1_Data addObject:model];
                        [self.location6_Data addObject:model];
                        
                    }else if ([model.position isEqualToString:@"2"]){
                        [self.location2_Data addObject:model];
                        [self.location6_Data addObject:model];
                        
                    }else if ([model.position isEqualToString:@"3"]){
                        [self.location3_Data addObject:model];
                        [self.location7_Data addObject:model];
                        
                    }else if ([model.position isEqualToString:@"4"]){
                        [self.location4_Data addObject:model];
                        [self.location7_Data addObject:model];
                        
                    }else if ([model.position isEqualToString:@"5"]){
                        [self.location5_Data addObject:model];
                    }else{
                    }
                }
            }else if ([TYPE isEqualToString:@"PJGD"]){
                //平均高--低
                NSArray *SALA_GD = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"average" ascending:NO]];
                NSMutableArray *SSSGD = [[NSMutableArray alloc] initWithArray:[listModel.data sortedArrayUsingDescriptors:SALA_GD]];
                self.GZ_listData  = [[NSMutableArray alloc] init];
                self.GZ_listData = SSSGD;
                self.location8_Data = SSSGD;

                for (Player_ListModelCell *model in self.GZ_listData) {
                    if([model.position isEqualToString:@"1"]){
                        [self.location1_Data addObject:model];
                        [self.location6_Data addObject:model];
                        
                    }else if ([model.position isEqualToString:@"2"]){
                        [self.location2_Data addObject:model];
                        [self.location6_Data addObject:model];
                        
                    }else if ([model.position isEqualToString:@"3"]){
                        [self.location3_Data addObject:model];
                        [self.location7_Data addObject:model];
                        
                    }else if ([model.position isEqualToString:@"4"]){
                        [self.location4_Data addObject:model];
                        [self.location7_Data addObject:model];
                        
                    }else if ([model.position isEqualToString:@"5"]){
                        [self.location5_Data addObject:model];
                    }else{
                    }
                }
            }else if ([TYPE isEqualToString:@"PJDG"]){
                //平均低--高
                NSArray *SALA_DG = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"average" ascending:YES]];
                NSMutableArray *SSSDG = [[NSMutableArray alloc] initWithArray:[listModel.data sortedArrayUsingDescriptors:SALA_DG]];
                self.GZ_listData  = [[NSMutableArray alloc] init];
                self.GZ_listData = SSSDG;
                self.location8_Data = SSSDG;

                for (Player_ListModelCell *model in self.GZ_listData) {
                    if([model.position isEqualToString:@"1"]){
                        [self.location1_Data addObject:model];
                        [self.location6_Data addObject:model];
                        
                    }else if ([model.position isEqualToString:@"2"]){
                        [self.location2_Data addObject:model];
                        [self.location6_Data addObject:model];
                        
                    }else if ([model.position isEqualToString:@"3"]){
                        [self.location3_Data addObject:model];
                        [self.location7_Data addObject:model];
                        
                    }else if ([model.position isEqualToString:@"4"]){
                        [self.location4_Data addObject:model];
                        [self.location7_Data addObject:model];
                        
                    }else if ([model.position isEqualToString:@"5"]){
                        [self.location5_Data addObject:model];
                    }else{
                    }
                }
            }else if ([TYPE isEqualToString:@"KDAGD"]){
                //KDA 高--低
                NSArray *SALA_GD= [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"play_time" ascending:NO]];
                NSMutableArray *SSSGD = [[NSMutableArray alloc] initWithArray:[listModel.data sortedArrayUsingDescriptors:SALA_GD]];
                self.GZ_listData  = [[NSMutableArray alloc] init];
                self.GZ_listData = SSSGD;
                self.location8_Data = SSSGD;

                for (Player_ListModelCell *model in self.GZ_listData) {
                    if([model.position isEqualToString:@"1"]){
                        [self.location1_Data addObject:model];
                        [self.location6_Data addObject:model];
                        
                    }else if ([model.position isEqualToString:@"2"]){
                        [self.location2_Data addObject:model];
                        [self.location6_Data addObject:model];
                        
                    }else if ([model.position isEqualToString:@"3"]){
                        [self.location3_Data addObject:model];
                        [self.location7_Data addObject:model];
                        
                    }else if ([model.position isEqualToString:@"4"]){
                        [self.location4_Data addObject:model];
                        [self.location7_Data addObject:model];
                        
                    }else if ([model.position isEqualToString:@"5"]){
                        [self.location5_Data addObject:model];
                    }else{
                    }
                }
            }else if ([TYPE isEqualToString:@"KDADG"]){
                //KDA低--高
                NSArray *SALA_DG = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"play_time" ascending:YES]];
                NSMutableArray *SSSDG = [[NSMutableArray alloc] initWithArray:[listModel.data sortedArrayUsingDescriptors:SALA_DG]];
                self.GZ_listData  = [[NSMutableArray alloc] init];
                self.GZ_listData = SSSDG;
                self.location8_Data = SSSDG;

                for (Player_ListModelCell *model in self.GZ_listData) {
                    if([model.position isEqualToString:@"1"]){
                        [self.location1_Data addObject:model];
                        [self.location6_Data addObject:model];
                        
                    }else if ([model.position isEqualToString:@"2"]){
                        [self.location2_Data addObject:model];
                        [self.location6_Data addObject:model];
                        
                    }else if ([model.position isEqualToString:@"3"]){
                        [self.location3_Data addObject:model];
                        [self.location7_Data addObject:model];
                        
                    }else if ([model.position isEqualToString:@"4"]){
                        [self.location4_Data addObject:model];
                        [self.location7_Data addObject:model];
                        
                    }else if ([model.position isEqualToString:@"5"]){
                        [self.location5_Data addObject:model];
                    }else{
                    }
                }
                
            }else{ }
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


#pragma mark - 顶部view
// 顶部view
- (void)initTopView {
    [self.topButton1 setTitle:@"工资" forState:UIControlStateNormal];
    [self.topButton1 setTitleColor:[UIColor getColorWithTextTheme] forState:UIControlStateNormal];
    [self.topButton1 setImage:[UIImage imageNamed:@"sort-down-icon"] forState:UIControlStateSelected];
    self.topButton1.titleLabel.font = [UIFont systemFontOfSize:12];
    self.topButton1.imageEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    self.topButton1.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    
    
    [self.topButton2 setTitle:@"平均分" forState:UIControlStateNormal];
    [self.topButton2 setTitleColor:[UIColor getColorWithTextTheme] forState:UIControlStateNormal];
    [self.topButton2 setImage:[UIImage imageNamed:@"sort-icon"] forState:UIControlStateNormal];
    self.topButton2.titleLabel.font = [UIFont systemFontOfSize:12];
    self.topButton2.imageEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
    self.topButton2.titleEdgeInsets = UIEdgeInsetsMake(0, -32, 0, 0);
    
    
    [self.topButton3 setTitle:@"场均时间" forState:UIControlStateNormal];
    [self.topButton3 setTitleColor:[UIColor getColorWithTextTheme] forState:UIControlStateNormal];
    [self.topButton3 setImage:[UIImage imageNamed:@"sort-icon"] forState:UIControlStateNormal];
    self.topButton3.titleLabel.font = [UIFont systemFontOfSize:12];
    self.topButton3.imageEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
    self.topButton3.titleEdgeInsets = UIEdgeInsetsMake(0, -56, 0, 0);
    
    
}
//工资
- (IBAction)topButton1Click:(UIButton *)sender {
    self.topButton2.selected = NO;
    self.topButton3.selected = NO;
    if (self.topButton1.selected == NO) {
        self.topButton1.selected = YES;
        [self.topButton1 setImage:[UIImage imageNamed:@"sort-down-icon"] forState:UIControlStateNormal];
        [self.topButton2 setImage:[UIImage imageNamed:@"sort-icon"] forState:UIControlStateNormal];
        [self.topButton3 setImage:[UIImage imageNamed:@"sort-icon"] forState:UIControlStateNormal];
        [self initPlayerData:@"GZGD"];
        
    }else{
        [self.topButton1 setImage:[UIImage imageNamed:@"sort-up-icon"] forState:UIControlStateNormal];
        [self.topButton2 setImage:[UIImage imageNamed:@"sort-icon"] forState:UIControlStateNormal];
        [self.topButton3 setImage:[UIImage imageNamed:@"sort-icon"] forState:UIControlStateNormal];
        self.topButton1.selected = NO;
        [self initPlayerData:@"GZDG"];
        
    }
    
}
//平均分
- (IBAction)topButton2Click:(UIButton *)sender {
    self.topButton1.selected = NO;
    self.topButton3.selected = NO;
    if (self.topButton2.selected == NO) {
        self.topButton2.selected = YES;
        [self.topButton2 setImage:[UIImage imageNamed:@"sort-down-icon"] forState:UIControlStateNormal];
        [self.topButton1 setImage:[UIImage imageNamed:@"sort-icon"] forState:UIControlStateNormal];
        [self.topButton3 setImage:[UIImage imageNamed:@"sort-icon"] forState:UIControlStateNormal];
        [self initPlayerData:@"PJGD"];
        
    }else{
        self.topButton2.selected = NO;
        [self.topButton2 setImage:[UIImage imageNamed:@"sort-up-icon"] forState:UIControlStateNormal];
        [self.topButton1 setImage:[UIImage imageNamed:@"sort-icon"] forState:UIControlStateNormal];
        [self.topButton3 setImage:[UIImage imageNamed:@"sort-icon"] forState:UIControlStateNormal];
        [self initPlayerData:@"PJDG"];
        
    }
    
}
//场均时间
- (IBAction)topButton3Click:(UIButton *)sender {
    self.topButton1.selected = NO;
    self.topButton2.selected = NO;
    if (self.topButton3.selected == NO) {
        self.topButton3.selected = YES;
        [self.topButton3 setImage:[UIImage imageNamed:@"sort-down-icon"] forState:UIControlStateNormal];
        [self.topButton1 setImage:[UIImage imageNamed:@"sort-icon"] forState:UIControlStateNormal];
        [self.topButton2 setImage:[UIImage imageNamed:@"sort-icon"] forState:UIControlStateNormal];
        [self initPlayerData:@"KDAGD"];
        
        
    }else{
        self.topButton3.selected = NO;
        [self.topButton3 setImage:[UIImage imageNamed:@"sort-up-icon"] forState:UIControlStateNormal];
        [self.topButton1 setImage:[UIImage imageNamed:@"sort-icon"] forState:UIControlStateNormal];
        [self.topButton2 setImage:[UIImage imageNamed:@"sort-icon"] forState:UIControlStateNormal];
        [self initPlayerData:@"KDADG"];
        
    }
    
}
//点击头像
- (void)iconBtnClick:(UIButton *)Btn{
    if ([self.typeOder_num isEqualToString:@"1"]) {
        Player_ListModelCell *model = [self.location1_Data objectAtIndex:Btn.tag];
        PlayerInfoViewController *PlayerVC = [[PlayerInfoViewController alloc] init];
        PlayerVC.lol_data_nba = @"nba";
        PlayerVC.JCPlayer = model;
        [PlayerVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:PlayerVC animated:YES];
    }else if ([self.typeOder_num isEqualToString:@"2"]){
        Player_ListModelCell *model = [self.location2_Data objectAtIndex:Btn.tag];
        PlayerInfoViewController *InfoVC = [[PlayerInfoViewController alloc] init];
        InfoVC.JCPlayer = model;
        InfoVC.lol_data_nba = @"nba";

        [InfoVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:InfoVC animated:YES];
    }else if ([self.typeOder_num isEqualToString:@"3"]){
        Player_ListModelCell *model = [self.location3_Data objectAtIndex:Btn.tag];
        PlayerInfoViewController *InfoVC = [[PlayerInfoViewController alloc] init];
        InfoVC.JCPlayer = model;
        InfoVC.lol_data_nba = @"nba";

        [InfoVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:InfoVC animated:YES];
    }else if ([self.typeOder_num isEqualToString:@"4"]){
        Player_ListModelCell *model = [self.location4_Data objectAtIndex:Btn.tag];
        PlayerInfoViewController *InfoVC = [[PlayerInfoViewController alloc] init];
        InfoVC.JCPlayer = model;
        InfoVC.lol_data_nba = @"nba";

        [InfoVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:InfoVC animated:YES];
    }else if ([self.typeOder_num isEqualToString:@"5"]){
        Player_ListModelCell *model = [self.location5_Data objectAtIndex:Btn.tag];
        PlayerInfoViewController *InfoVC = [[PlayerInfoViewController alloc] init];
        InfoVC.JCPlayer = model;
        InfoVC.lol_data_nba = @"nba";

        [InfoVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:InfoVC animated:YES];
    }else if ([self.typeOder_num isEqualToString:@"6"]){
        Player_ListModelCell *model = [self.location6_Data objectAtIndex:Btn.tag];
        PlayerInfoViewController *InfoVC = [[PlayerInfoViewController alloc] init];
        InfoVC.JCPlayer = model;
        InfoVC.lol_data_nba = @"nba";

        [InfoVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:InfoVC animated:YES];
    }else if ([self.typeOder_num isEqualToString:@"7"]){
        Player_ListModelCell *model = [self.location7_Data objectAtIndex:Btn.tag];
        PlayerInfoViewController *InfoVC = [[PlayerInfoViewController alloc] init];
        InfoVC.JCPlayer = model;
        InfoVC.lol_data_nba = @"nba";

        [InfoVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:InfoVC animated:YES];
    }else{
        Player_ListModelCell *model = [self.location8_Data objectAtIndex:Btn.tag];
        PlayerInfoViewController *InfoVC = [[PlayerInfoViewController alloc] init];
        InfoVC.JCPlayer = model;
        InfoVC.lol_data_nba = @"nba";

        [InfoVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:InfoVC animated:YES];
    }
    
    
    
}
//筛选
- (void)Click_Choose:(UIButton *)Btn{
    
//    self.shaixuanView = [ShaixuanView chooseGameView];
//    self.shaixuanView.frame = CGRectMake(0, 0, screen_Width, screen_Height-64);
//    //self.shaixuanView.downView.frame = CGRectMake(0, screen_Height, screen_Width, 300);
//    
//    [self.view addSubview:self.shaixuanView];
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        // 设置view弹出来的位置
//        //self.shaixuanView.downView.frame = CGRectMake(0, screen_Height-300, screen_Width, 300);
//    }];
    
}



#pragma mark - tableview 列表代理
//TableView
- (void)initTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView registerClass:[PlayerTableViewCell class] forCellReuseIdentifier:nbaPlayer_cellad];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.typeOder_num isEqualToString:@"1"]) {
        return self.location1_Data.count;
    }else if ([self.typeOder_num isEqualToString:@"2"]){
        return self.location2_Data.count;
    }else if ([self.typeOder_num isEqualToString:@"3"]){
        return self.location3_Data.count;
    }else if ([self.typeOder_num isEqualToString:@"4"]){
        return self.location4_Data.count;
    }else if ([self.typeOder_num isEqualToString:@"5"]){
        return self.location5_Data.count;
    }else if ([self.typeOder_num isEqualToString:@"6"]){
        return self.location6_Data.count;
    }else if ([self.typeOder_num isEqualToString:@"7"]){
        return self.location7_Data.count;
    }else{
        return self.location8_Data.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.typeOder_num isEqualToString:@"1"]) {
        Player_ListModelCell *model = [self.location1_Data objectAtIndex:indexPath.row];
        PlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nbaPlayer_cellad];
        cell.icon_Btn.tag = indexPath.row;
        cell.add_Btn.tag = indexPath.row;
        [cell.icon_Btn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.Model = model;

        cell.name_Lab.text = model.name;
        cell.leftD_Lab.text = model.match_data.name_a;
        cell.vsD_Lab.text = [NSString stringWithFormat:@"vs %@",model.match_data.name_b];
        cell.price_Lab.text = [NSString stringWithFormat:@"$%@",model.salary];
        cell.pingJ_Lab.text = [NSString stringWithFormat:@"选手平均分：%0.2f",model.average];
        cell.time_Lab.text = [NSString stringWithFormat:@"场均时间：%0.2f",model.play_time];
        [cell.icon_Img yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"player-photo"]];
        cell.userInteractionEnabled = YES;
        cell.NOview.hidden = YES;
        cell.add_Btn.hidden = NO;
        if ([model.is_undetermined isEqualToString:@"1"]) {
            cell.daiD_Lab.hidden = NO;
        }else{
            cell.daiD_Lab.hidden = YES;
        }
        cell.biao_Lab.text = @"控卫";
        if (model.isDisplay) {
            cell.add_Btn.selected = YES;
        }else {
            cell.add_Btn.selected = NO;
        }

        if (_model8 || _model6) {
            if (_model8) {
                if (model.Id == self.model8.Id) {
                    cell.NOview.hidden = NO;
                    cell.weizhi_lab.text = @"任意";
                    cell.add_Btn.hidden = YES;
                    cell.userInteractionEnabled = NO;
                }
            }
            if (_model6) {
                if (model.Id == self.model6.Id) {
                    cell.NOview.hidden = NO;
                    cell.weizhi_lab.text = @"后卫";
                    cell.add_Btn.hidden = YES;
                    cell.userInteractionEnabled = NO;
                }
            }
            if (model.Id != _model6.Id  && model.Id != _model8.Id ) {
                cell.add_Btn.hidden = NO;
                cell.add_Btn.selected = NO;
            }
        }else{
            cell.add_Btn.hidden = NO;
            cell.add_Btn.selected = NO;
        }

        if (self.model1) {
            if (model.Id == self.model1.Id) {
                model.isDisplay = self.model1.isDisplay;
                cell.add_Btn.selected = YES;
                cell.add_Btn.hidden = NO;
            }
        }

        return cell;
    }else if ([self.typeOder_num isEqualToString:@"2"]){
        Player_ListModelCell *model = [self.location2_Data objectAtIndex:indexPath.row];
        PlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nbaPlayer_cellad];
        cell.icon_Btn.tag = indexPath.row;
        [cell.icon_Btn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.userInteractionEnabled = YES;
        cell.Model = model;

        cell.name_Lab.text = model.name;
        cell.leftD_Lab.text = model.match_data.name_a;
        cell.vsD_Lab.text = [NSString stringWithFormat:@"vs %@",model.match_data.name_b];
        cell.price_Lab.text = [NSString stringWithFormat:@"$%@",model.salary];
        cell.pingJ_Lab.text = [NSString stringWithFormat:@"选手平均分：%0.2f",model.average];
        cell.time_Lab.text = [NSString stringWithFormat:@"场均时间：%0.2f",model.play_time];
        [cell.icon_Img yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"player-photo"]];
        if ([model.is_undetermined isEqualToString:@"1"]) {
            cell.daiD_Lab.hidden = NO;
        }else{
            cell.daiD_Lab.hidden = YES;
        }
       
        cell.biao_Lab.text = @"分卫";
        if (model.isDisplay) {
            cell.add_Btn.selected = YES;
        }else {
            cell.add_Btn.selected = NO;
        }

        cell.NOview.hidden = YES;
        cell.add_Btn.hidden = NO;
        
        if (_model8 || _model6) {
            if (_model8) {
                if (model.Id == self.model8.Id) {
                    cell.NOview.hidden = NO;
                    cell.weizhi_lab.text = @"任意";
                    cell.add_Btn.hidden = YES;
                    cell.userInteractionEnabled = NO;
                }
            }
            if (_model6) {
                if (model.Id == self.model6.Id) {
                    cell.NOview.hidden = NO;
                    cell.weizhi_lab.text = @"后卫";
                    cell.add_Btn.hidden = YES;
                    cell.userInteractionEnabled = NO;
                }
            }
            if (model.Id != _model6.Id  && model.Id != _model8.Id ) {
                cell.add_Btn.hidden = NO;
                cell.add_Btn.selected = NO;
            }
        }else{
            cell.add_Btn.hidden = NO;
            cell.add_Btn.selected = NO;
        }
        if (self.model2) {
            if (model.Id == self.model2.Id) {
                model.isDisplay = self.model2.isDisplay;
                cell.add_Btn.selected = YES;
                cell.add_Btn.hidden = NO;
            }
        }

        return cell;
        
    }else if ([self.typeOder_num isEqualToString:@"3"]){
        Player_ListModelCell *model = [self.location3_Data objectAtIndex:indexPath.row];
        PlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nbaPlayer_cellad];
        cell.icon_Btn.tag = indexPath.row;
        [cell.icon_Btn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.userInteractionEnabled = YES;
        cell.Model = model;

        cell.name_Lab.text = model.name;
        cell.leftD_Lab.text = model.match_data.name_a;
        cell.vsD_Lab.text = [NSString stringWithFormat:@"vs %@",model.match_data.name_b];
        cell.price_Lab.text = [NSString stringWithFormat:@"$%@",model.salary];
        cell.pingJ_Lab.text = [NSString stringWithFormat:@"选手平均分：%0.2f",model.average];
        cell.time_Lab.text = [NSString stringWithFormat:@"场均时间：%0.2f",model.play_time];
        [cell.icon_Img yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"player-photo"]];
        if ([model.is_undetermined isEqualToString:@"1"]) {
            cell.daiD_Lab.hidden = NO;
        }else{
            cell.daiD_Lab.hidden = YES;
        }
        
        cell.biao_Lab.text = @"小前";
        if (model.isDisplay) {
            cell.add_Btn.selected = YES;
        }else {
            cell.add_Btn.selected = NO;
        }
        
        cell.NOview.hidden = YES;
        cell.add_Btn.hidden = NO;
        
        if (_model8 || _model7) {
            if (_model8) {
                if (model.Id == self.model8.Id) {
                    cell.NOview.hidden = NO;
                    cell.weizhi_lab.text = @"任意";
                    cell.add_Btn.hidden = YES;
                    cell.userInteractionEnabled = NO;
                }
            }
            if (_model7) {
                if (model.Id == self.model7.Id) {
                    cell.NOview.hidden = NO;
                    cell.weizhi_lab.text = @"后卫";
                    cell.add_Btn.hidden = YES;
                    cell.userInteractionEnabled = NO;
                }
            }
            if (model.Id != _model7.Id  && model.Id != _model8.Id ) {
                cell.add_Btn.hidden = NO;
                cell.add_Btn.selected = NO;
            }
        }else{
            cell.add_Btn.hidden = NO;
            cell.add_Btn.selected = NO;
            
        }

        if (self.model3) {
            if (model.Id == self.model3.Id) {
                model.isDisplay = self.model3.isDisplay;
                cell.add_Btn.selected = YES;
                cell.add_Btn.hidden = NO;

            }
        }


        return cell;
        
    }else if ([self.typeOder_num isEqualToString:@"4"]){
        Player_ListModelCell *model = [self.location4_Data objectAtIndex:indexPath.row];
        PlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nbaPlayer_cellad];
        cell.icon_Btn.tag = indexPath.row;
        [cell.icon_Btn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.userInteractionEnabled = YES;
        cell.Model = model;

        cell.name_Lab.text = model.name;
        cell.leftD_Lab.text = model.match_data.name_a;
        cell.vsD_Lab.text = [NSString stringWithFormat:@"vs %@",model.match_data.name_b];
        cell.price_Lab.text = [NSString stringWithFormat:@"$%@",model.salary];
        cell.pingJ_Lab.text = [NSString stringWithFormat:@"选手平均分：%0.2f",model.average];
        cell.time_Lab.text = [NSString stringWithFormat:@"场均时间：%0.2f",model.play_time];
        [cell.icon_Img yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"player-photo"]];
        if ([model.is_undetermined isEqualToString:@"1"]) {
            cell.daiD_Lab.hidden = NO;
        }else{
            cell.daiD_Lab.hidden = YES;
        }
        cell.biao_Lab.text = @"大前";
        if (model.isDisplay) {
            cell.add_Btn.selected = YES;
        }else {
            cell.add_Btn.selected = NO;
        }
        
        cell.NOview.hidden = YES;
        cell.add_Btn.hidden = NO;
        
        if (_model8 || _model7) {
            if (_model8) {
                if (model.Id == self.model8.Id) {
                    cell.NOview.hidden = NO;
                    cell.weizhi_lab.text = @"任意";
                    cell.add_Btn.hidden = YES;
                    cell.userInteractionEnabled = NO;
                }
            }
            if (_model7) {
                if (model.Id == self.model7.Id) {
                    cell.NOview.hidden = NO;
                    cell.weizhi_lab.text = @"后卫";
                    cell.add_Btn.hidden = YES;
                    cell.userInteractionEnabled = NO;
                }
            }
            if (model.Id != _model7.Id  && model.Id != _model8.Id ) {
                cell.add_Btn.hidden = NO;
                cell.add_Btn.selected = NO;
            }
            
        }else{
            cell.add_Btn.hidden = NO;
            cell.add_Btn.selected = NO;
        }
        
        if (self.model4) {
            if (model.Id == self.model4.Id) {
                model.isDisplay = self.model4.isDisplay;
                cell.add_Btn.selected = YES;
                cell.add_Btn.hidden = NO;

            }
        }
        return cell;
        
    }else if ([self.typeOder_num isEqualToString:@"5"]){
        Player_ListModelCell *model = [self.location5_Data objectAtIndex:indexPath.row];
        PlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nbaPlayer_cellad];
        cell.icon_Btn.tag = indexPath.row;
        [cell.icon_Btn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.userInteractionEnabled = YES;
        cell.Model = model;

        cell.name_Lab.text = model.name;
        cell.leftD_Lab.text = model.match_data.name_a;
        cell.vsD_Lab.text = [NSString stringWithFormat:@"vs %@",model.match_data.name_b];
        cell.price_Lab.text = [NSString stringWithFormat:@"$%@",model.salary];
        cell.pingJ_Lab.text = [NSString stringWithFormat:@"选手平均分：%0.2f",model.average];
        cell.time_Lab.text = [NSString stringWithFormat:@"场均时间：%0.2f",model.play_time];
        [cell.icon_Img yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"player-photo"]];
        if ([model.is_undetermined isEqualToString:@"1"]) {
            cell.daiD_Lab.hidden = NO;
        }else{
            cell.daiD_Lab.hidden = YES;
        }
       
        cell.biao_Lab.text = @"中锋";
        if (model.isDisplay) {
            cell.add_Btn.selected = YES;
        }else {
            cell.add_Btn.selected = NO;
        }
        
        cell.NOview.hidden = YES;
        cell.add_Btn.hidden = NO;
        
        if (_model8) {
            if (_model8) {
                if (model.Id == self.model8.Id) {
                    cell.NOview.hidden = NO;
                    cell.weizhi_lab.text = @"任意";
                    cell.add_Btn.hidden = YES;
                    cell.userInteractionEnabled = NO;
                }else{
                    cell.add_Btn.hidden = NO;
                    cell.add_Btn.selected = NO;
                }
            }
        }else{
            cell.add_Btn.hidden = NO;
            cell.add_Btn.selected = NO;
            
        }

        
        
        if (self.model5) {
            if (model.Id == self.model5.Id) {
                model.isDisplay = self.model5.isDisplay;
                cell.add_Btn.selected = YES;
                cell.add_Btn.hidden = NO;

            }
        }


        return cell;
    }else if ([self.typeOder_num isEqualToString:@"6"]){
        Player_ListModelCell *model = [self.location6_Data objectAtIndex:indexPath.row];
        PlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nbaPlayer_cellad];
        cell.icon_Btn.tag = indexPath.row;
        [cell.icon_Btn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.userInteractionEnabled = YES;
        cell.Model = model;

        cell.name_Lab.text = model.name;
        cell.leftD_Lab.text = model.match_data.name_a;
        cell.vsD_Lab.text = [NSString stringWithFormat:@"vs %@",model.match_data.name_b];
        cell.price_Lab.text = [NSString stringWithFormat:@"$%@",model.salary];
        cell.pingJ_Lab.text = [NSString stringWithFormat:@"选手平均分：%0.2f",model.average];
        cell.time_Lab.text = [NSString stringWithFormat:@"场均时间：%0.2f",model.play_time];
        [cell.icon_Img yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"player-photo"]];
        if ([model.is_undetermined isEqualToString:@"1"]) {
            cell.daiD_Lab.hidden = NO;
        }else{
            cell.daiD_Lab.hidden = YES;
        }

        if ([model.position isEqualToString:@"1"]) {
            cell.biao_Lab.text = @"控卫";
        }else{
            cell.biao_Lab.text = @"分卫";
        }
        
        cell.NOview.hidden = YES;
        cell.add_Btn.hidden = NO;

        if (_model1 || _model2 || _model8 ) {
            if (_model1) {
                if (model.Id == self.model1.Id) {
                    cell.NOview.hidden = NO;
                    cell.weizhi_lab.text = @"控卫";
                    cell.add_Btn.hidden = YES;
                    cell.userInteractionEnabled = NO;
                }
            }
            if (_model2) {
                if (model.Id == self.model2.Id) {
                    cell.NOview.hidden = NO;
                    cell.weizhi_lab.text = @"分卫";
                    cell.add_Btn.hidden = YES;
                    cell.userInteractionEnabled = NO;
                }
            }
            if (_model8) {
                if (model.Id == self.model8.Id) {
                    cell.NOview.hidden = NO;
                    cell.weizhi_lab.text = @"任意";
                    cell.add_Btn.hidden = YES;
                    cell.userInteractionEnabled = NO;
                }
            }
            if (model.Id != _model1.Id  && model.Id != _model2.Id   && model.Id != _model8.Id ) {
                cell.add_Btn.hidden = NO;
                cell.add_Btn.selected = NO;
            }

        }else{
            cell.add_Btn.hidden = NO;
            cell.add_Btn.selected = NO;

        }
 
        if (model.isDisplay) {
            cell.add_Btn.selected = YES;
        }else {
            cell.add_Btn.selected = NO;
        }

        if (self.model6) {
            if (model.Id == self.model6.Id) {
                model.isDisplay = self.model6.isDisplay;
                cell.add_Btn.selected = YES;
                cell.add_Btn.hidden = NO;
            }
        }


        return cell;
    }else if ([self.typeOder_num isEqualToString:@"7"]){
        Player_ListModelCell *model = [self.location7_Data objectAtIndex:indexPath.row];
        PlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nbaPlayer_cellad];
        cell.icon_Btn.tag = indexPath.row;
        [cell.icon_Btn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.userInteractionEnabled = YES;
        cell.Model = model;

        cell.name_Lab.text = model.name;
        cell.leftD_Lab.text = model.match_data.name_a;
        cell.vsD_Lab.text = [NSString stringWithFormat:@"vs %@",model.match_data.name_b];
        cell.price_Lab.text = [NSString stringWithFormat:@"$%@",model.salary];
        cell.pingJ_Lab.text = [NSString stringWithFormat:@"选手平均分：%0.2f",model.average];
        cell.time_Lab.text = [NSString stringWithFormat:@"场均时间：%0.2f",model.play_time];
        [cell.icon_Img yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"player-photo"]];
        if ([model.is_undetermined isEqualToString:@"1"]) {
            cell.daiD_Lab.hidden = NO;
        }else{
            cell.daiD_Lab.hidden = YES;
        }
      
        cell.biao_Lab.text = @"前锋";
        if (model.isDisplay) {
            cell.add_Btn.selected = YES;
        }else {
            cell.add_Btn.selected = NO;
        }
        
        
        cell.NOview.hidden = YES;
        cell.add_Btn.hidden = NO;
        
        if (_model3 || _model4 || _model8 ) {
            if (_model3) {
                if (model.Id == self.model3.Id) {
                    cell.NOview.hidden = NO;
                    cell.weizhi_lab.text = @"小前";
                    cell.add_Btn.hidden = YES;
                    cell.userInteractionEnabled = NO;
                }
            }
            if (_model4) {
                if (model.Id == self.model4.Id) {
                    cell.NOview.hidden = NO;
                    cell.weizhi_lab.text = @"大前";
                    cell.add_Btn.hidden = YES;
                    cell.userInteractionEnabled = NO;
                }
            }
            if (_model8) {
                if (model.Id == self.model8.Id) {
                    cell.NOview.hidden = NO;
                    cell.weizhi_lab.text = @"任意";
                    cell.add_Btn.hidden = YES;
                    cell.userInteractionEnabled = NO;
                }
            }
            if (model.Id != _model3.Id  && model.Id != _model4.Id   && model.Id != _model8.Id ) {
                cell.add_Btn.hidden = NO;
                cell.add_Btn.selected = NO;
            }
        }else{
            cell.add_Btn.hidden = NO;
            cell.add_Btn.selected = NO;
            
        }

        if (self.model7) {
            if (model.Id == self.model7.Id) {
                model.isDisplay = self.model7.isDisplay;
                cell.add_Btn.selected = YES;
                cell.add_Btn.hidden = NO;

            }
        }
        return cell;

    }else {  //任意
        Player_ListModelCell *model = [self.location8_Data objectAtIndex:indexPath.row];
        PlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nbaPlayer_cellad];
        cell.icon_Btn.tag = indexPath.row;
        [cell.icon_Btn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.name_Lab.text = model.name;
        cell.userInteractionEnabled = YES;
        cell.Model = model;

        cell.leftD_Lab.text = model.match_data.name_a;
        cell.vsD_Lab.text = [NSString stringWithFormat:@"vs %@",model.match_data.name_b];
        cell.price_Lab.text = [NSString stringWithFormat:@"$%@",model.salary];
        cell.pingJ_Lab.text = [NSString stringWithFormat:@"选手平均分：%0.2f",model.average];
        cell.time_Lab.text = [NSString stringWithFormat:@"场均时间：%0.2f",model.play_time];
        [cell.icon_Img yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"player-photo"]];
        if ([model.position isEqualToString:@"1"]) {
            cell.biao_Lab.text = @"控卫";
        }else if ([model.position isEqualToString:@"2"]){
            cell.biao_Lab.text = @"分卫";
        }else if ([model.position isEqualToString:@"3"]){
            cell.biao_Lab.text = @"小前";
        }else if ([model.position isEqualToString:@"4"]){
            cell.biao_Lab.text = @"大前";
        }else if ([model.position isEqualToString:@"5"]){
            cell.biao_Lab.text = @"中锋";
        }else if ([model.position isEqualToString:@"6"]){
            cell.biao_Lab.text = @"后卫";
        }else if ([model.position isEqualToString:@"7"]){
            cell.biao_Lab.text = @"前锋";
        }else{
        }
        if ([model.is_undetermined isEqualToString:@"1"]) {
            cell.daiD_Lab.hidden = NO;
        }else{
            cell.daiD_Lab.hidden = YES;
        }
        cell.NOview.hidden = YES;
        cell.add_Btn.tag = indexPath.row;


        
        if (_model1 || _model2 || _model3 || _model4 || _model5 || _model6 || _model7 ) {
            if (_model1) {
                if (model.Id == self.model1.Id) {
                    cell.NOview.hidden = NO;
                    cell.weizhi_lab.text = @"控卫";
                    cell.add_Btn.hidden = YES;
                    cell.userInteractionEnabled = NO;
                }
            }
            if (_model2) {
                if (model.Id == self.model2.Id) {
                    cell.NOview.hidden = NO;
                    cell.weizhi_lab.text = @"分卫";
                    cell.add_Btn.hidden = YES;
                    cell.userInteractionEnabled = NO;
                }
            }
            if (_model3) {
                if (model.Id == self.model3.Id) {
                    cell.NOview.hidden = NO;
                    cell.weizhi_lab.text = @"小前";
                    cell.add_Btn.hidden = YES;
                    cell.userInteractionEnabled = NO;
                }
            }
            if (_model4) {
                if (model.Id == self.model4.Id) {
                    cell.NOview.hidden = NO;
                    cell.weizhi_lab.text = @"大前";
                    cell.add_Btn.hidden = YES;
                    cell.userInteractionEnabled = NO;
                }
            }
            if (_model5) {
                if (model.Id == self.model5.Id) {
                    cell.NOview.hidden = NO;
                    cell.weizhi_lab.text = @"中锋";
                    cell.add_Btn.hidden = YES;
                    cell.userInteractionEnabled = NO;
                }
            }
            if (_model6) {
                if (model.Id == self.model6.Id) {
                    cell.NOview.hidden = NO;
                    cell.weizhi_lab.text = @"后卫";
                    cell.add_Btn.hidden = YES;
                    cell.userInteractionEnabled = NO;
                }
            }
            if (_model7) {
                if (model.Id == self.model7.Id) {
                    cell.NOview.hidden = NO;
                    cell.weizhi_lab.text = @"前锋";
                    cell.add_Btn.hidden = YES;
                    cell.userInteractionEnabled = NO;
                }
            }
            
            
            if (model.Id != _model1.Id  && model.Id != _model2.Id && model.Id != _model3.Id && model.Id != _model4.Id  && model.Id != _model5.Id && model.Id != _model6.Id && model.Id != _model7.Id ) {
                cell.add_Btn.hidden = NO;
                cell.add_Btn.selected = NO;
            }

            
        }else{
            cell.add_Btn.hidden = NO;
            cell.add_Btn.selected = NO;

        }
      
        
        
        
        
        
        if (model.isDisplay) {
            cell.add_Btn.selected = YES;
        }else {
            cell.add_Btn.selected = NO;
        }

        
        
        
        
        if (self.model8) {//第二次进入显示选中状态
            if (model.Id == self.model8.Id) {
                model.isDisplay = self.model8.isDisplay;
                cell.add_Btn.selected = YES;
                cell.add_Btn.hidden = NO;

            }
        }
        
        return cell;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.typeOder_num isEqualToString:@"1"]) {
        for (Player_ListModelCell *model in self.location1_Data) {
            model.isDisplay = NO;
            model.isNO = NO;
        }
        for (Player_ListModelCell *model in self.location1_Data) {
            if (model.isDisplay) {
                self.num1_lab.text = @"1/1";
            }
        }
        Player_ListModelCell *playmodel = [self.location1_Data objectAtIndex:indexPath.row];
        playmodel.isDisplay = YES;
        playmodel.isNO = YES;
        //-------------------------
        self.model1 = [[NBAModel1Cell alloc ]init];
        self.model1.name = playmodel.name;
        self.model1.salary = playmodel.salary;
        self.model1.Id = playmodel.Id;
        self.model1.average = playmodel.average;
        self.model1.play_time = playmodel.play_time;
        self.model1.team_id = playmodel.team_id;
        self.model1.project_id = playmodel.project_id;
        self.model1.img = playmodel.img;
        self.model1.nationality = playmodel.nationality;
        self.model1.position = playmodel.position;
        self.model1.is_undetermined = playmodel.is_undetermined;
        self.model1.is_illness = playmodel.is_illness;
        self.model1.is_ban = playmodel.is_ban;
        self.model1.is_out = playmodel.is_out;
        self.model1.match_id = playmodel.match_id;
        self.model1.state = playmodel.state;
        self.model1.isDisplay = playmodel.isDisplay;
        self.model1.isNO = playmodel.isNO;
        //-------------------------
        
        
        [self initDownView];             //底部数据
        [self TongLeftView];             //左边数据

    
    }else if ([self.typeOder_num isEqualToString:@"2"]){
        for (Player_ListModelCell *model in self.location2_Data) {
            model.isDisplay = NO;
            model.isNO = NO;
        }
        Player_ListModelCell *playmodel = [self.location2_Data objectAtIndex:indexPath.row];
        playmodel.isDisplay = YES;
        playmodel.isNO = YES;
        //-------------------------
        self.model2 = [[NBAModel2Cell alloc ]init];
        self.model2.name = playmodel.name;
        self.model2.salary = playmodel.salary;
        self.model2.Id = playmodel.Id;
        self.model2.average = playmodel.average;
        self.model2.play_time = playmodel.play_time;
        self.model2.team_id = playmodel.team_id;
        self.model2.project_id = playmodel.project_id;
        self.model2.img = playmodel.img;
        self.model2.nationality = playmodel.nationality;
        self.model2.position = playmodel.position;
        self.model2.is_undetermined = playmodel.is_undetermined;
        self.model2.is_illness = playmodel.is_illness;
        self.model2.is_ban = playmodel.is_ban;
        self.model2.is_out = playmodel.is_out;
        self.model2.match_id = playmodel.match_id;
        self.model2.state = playmodel.state;
        self.model2.isDisplay = playmodel.isDisplay;
        self.model2.isNO = playmodel.isNO;
        //-------------------------

        for (Player_ListModelCell *model in self.location2_Data) {
            NSMutableArray *ArrD = [[NSMutableArray alloc ]init];
            if (model.isDisplay) {
                self.num2_lab.text = @"1/1";
                [ArrD addObject:model];
                [self.GoodsData addObjectsFromArray:ArrD];
            }
        }
        [self initDownView];              //--------------------------
        [self TongLeftView];             //左边数据

    }else if ([self.typeOder_num isEqualToString:@"3"]){
        for (Player_ListModelCell *model in self.location3_Data) {
            model.isDisplay = NO;
            model.isNO = NO;
        }
        
        Player_ListModelCell *playmodel = [self.location3_Data objectAtIndex:indexPath.row];
        playmodel.isDisplay = YES;
        playmodel.isNO = YES;
        //-------------------------
        self.model3 = [[NBAModel3Cell alloc ]init];
        self.model3.name = playmodel.name;
        self.model3.salary = playmodel.salary;
        self.model3.Id = playmodel.Id;
        self.model3.average = playmodel.average;
        self.model3.play_time = playmodel.play_time;
        self.model3.team_id = playmodel.team_id;
        self.model3.project_id = playmodel.project_id;
        self.model3.img = playmodel.img;
        self.model3.nationality = playmodel.nationality;
        self.model3.position = playmodel.position;
        self.model3.is_undetermined = playmodel.is_undetermined;
        self.model3.is_illness = playmodel.is_illness;
        self.model3.is_ban = playmodel.is_ban;
        self.model3.is_out = playmodel.is_out;
        self.model3.match_id = playmodel.match_id;
        self.model3.state = playmodel.state;
        self.model3.isDisplay = playmodel.isDisplay;
        self.model3.isNO = playmodel.isNO;
        //-------------------------

        for (Player_ListModelCell *model in self.location3_Data) {
            NSMutableArray *ArrD = [[NSMutableArray alloc ]init];
            if (model.isDisplay) {
                self.num3_lab.text = @"1/1";
                [ArrD addObject:model];
                [self.GoodsData addObjectsFromArray:ArrD];
            }
        }
        [self initDownView];              //--------------------------
        [self TongLeftView];             //左边数据

    }else if ([self.typeOder_num isEqualToString:@"4"]){
        for (Player_ListModelCell *model in self.location4_Data) {
            model.isDisplay = NO;
            model.isNO = NO;
            
        }
        
        Player_ListModelCell *playmodel = [self.location4_Data objectAtIndex:indexPath.row];
        playmodel.isDisplay = YES;
        playmodel.isNO = YES;
        //-------------------------
        self.model4 = [[NBAModel4Cell alloc ]init];
        self.model4.name = playmodel.name;
        self.model4.salary = playmodel.salary;
        self.model4.Id = playmodel.Id;
        self.model4.average = playmodel.average;
        self.model4.play_time = playmodel.play_time;
        self.model4.team_id = playmodel.team_id;
        self.model4.project_id = playmodel.project_id;
        self.model4.img = playmodel.img;
        self.model4.nationality = playmodel.nationality;
        self.model4.position = playmodel.position;
        self.model4.is_undetermined = playmodel.is_undetermined;
        self.model4.is_ban = playmodel.is_ban;
        self.model4.is_out = playmodel.is_out;
        self.model4.match_id = playmodel.match_id;
        self.model4.state = playmodel.state;
        self.model4.isDisplay = playmodel.isDisplay;
        self.model4.isNO = playmodel.isNO;
        //-------------------------

        for (Player_ListModelCell *model in self.location4_Data) {
            NSMutableArray *ArrD = [[NSMutableArray alloc ]init];
            if (model.isDisplay) {
                self.num4_lab.text = @"1/1";
                [ArrD addObject:model];
                [self.GoodsData addObjectsFromArray:ArrD];
            }
        }
        [self initDownView];              //--------------------------
        [self TongLeftView];             //左边数据

    }else if ([self.typeOder_num isEqualToString:@"5"]){
        for (Player_ListModelCell *model in self.location5_Data) {
            model.isDisplay = NO;
            model.isNO = NO;
        }
        Player_ListModelCell *playmodel = [self.location5_Data objectAtIndex:indexPath.row];
        playmodel.isDisplay = YES;
        playmodel.isNO = YES;
        //-------------------------
        self.model5 = [[NBAModel5Cell alloc ]init];
        self.model5.name = playmodel.name;
        self.model5.salary = playmodel.salary;
        self.model5.Id = playmodel.Id;
        self.model5.average = playmodel.average;
        self.model5.play_time = playmodel.play_time;
        self.model5.team_id = playmodel.team_id;
        self.model5.img = playmodel.img;
        self.model5.nationality = playmodel.nationality;
        self.model5.position = playmodel.position;
        self.model5.is_undetermined = playmodel.is_undetermined;
        self.model5.is_illness = playmodel.is_illness;
        self.model5.is_ban = playmodel.is_ban;
        self.model5.is_out = playmodel.is_out;
        self.model5.match_id = playmodel.match_id;
        self.model5.state = playmodel.state;
        self.model5.isDisplay = playmodel.isDisplay;
        self.model5.isNO = playmodel.isNO;
        //-------------------------

        for (Player_ListModelCell *model in self.location5_Data) {
            NSMutableArray *ArrD = [[NSMutableArray alloc ]init];
            if (model.isDisplay) {
                self.num5_lab.text = @"1/1";
                [ArrD addObject:model];
                [self.GoodsData addObjectsFromArray:ArrD];
            }
        }
        [self initDownView];              //--------------------------
        [self TongLeftView];             //左边数据

    }else if ([self.typeOder_num isEqualToString:@"6"]){
        for (Player_ListModelCell *model in self.location6_Data) {
            model.isDisplay = NO;
            model.isNO = NO;
        }
        for (Player_ListModelCell *model in self.location6_Data) {
            if (model.isDisplay) {
                self.num6_lab.text = @"1/1";
            }
        }

        Player_ListModelCell *playmodel = [self.location6_Data objectAtIndex:indexPath.row];
        playmodel.isDisplay = YES;
        playmodel.isNO = YES;
        //-------------------------
        self.model6 = [[NBAModel6Cell alloc ]init];
        self.model6.name = playmodel.name;
        self.model6.salary = playmodel.salary;
        self.model6.Id = playmodel.Id;
        self.model6.average = playmodel.average;
        self.model6.play_time = playmodel.play_time;
        self.model6.team_id = playmodel.team_id;
        self.model6.project_id = playmodel.project_id;
        self.model6.img = playmodel.img;
        self.model6.nationality = playmodel.nationality;
        self.model6.position = playmodel.position;
        self.model6.is_undetermined = playmodel.is_undetermined;
        self.model6.is_illness = playmodel.is_illness;
        self.model6.is_ban = playmodel.is_ban;
        self.model6.is_out = playmodel.is_out;
        self.model6.match_id = playmodel.match_id;
        self.model6.state = playmodel.state;
        self.model6.isDisplay = playmodel.isDisplay;
        self.model6.isNO = playmodel.isNO;
        //------------------------

        [self initDownView];             //底部数据
        [self TongLeftView];             //左边数据

    }else if ([self.typeOder_num isEqualToString:@"7"]){
        for (Player_ListModelCell *model in self.location7_Data) {
            model.isDisplay = NO;
            model.isNO = NO;
        }
        for (Player_ListModelCell *model in self.location7_Data) {
            if (model.isDisplay) {
                self.num7_lab.text = @"1/1";
            }
        }
        Player_ListModelCell *playmodel = [self.location7_Data objectAtIndex:indexPath.row];
        playmodel.isDisplay = YES;
        playmodel.isNO = YES;
        //-------------------------
        self.model7 = [[NBAModel7Cell alloc ]init];
        self.model7.name = playmodel.name;
        self.model7.salary = playmodel.salary;
        self.model7.Id = playmodel.Id;
        self.model7.average = playmodel.average;
        self.model7.play_time = playmodel.play_time;
        self.model7.team_id = playmodel.team_id;
        self.model7.project_id = playmodel.project_id;
        self.model7.img = playmodel.img;
        self.model7.nationality = playmodel.nationality;
        self.model7.position = playmodel.position;
        self.model7.is_undetermined = playmodel.is_undetermined;
        self.model7.is_illness = playmodel.is_illness;
        self.model7.is_ban = playmodel.is_ban;
        self.model7.is_out = playmodel.is_out;
        self.model7.match_id = playmodel.match_id;
        self.model7.state = playmodel.state;
        self.model7.isDisplay = playmodel.isDisplay;
        self.model7.isNO = playmodel.isNO;
        //------------------------
       
        [self initDownView];             //底部数据
        [self TongLeftView];             //左边数据
    }else if ([self.typeOder_num isEqualToString:@"8"]){
        for (Player_ListModelCell *model in self.location8_Data) {
            model.isDisplay = NO;
            model.isNO = NO;
        }
        Player_ListModelCell *playmodel = [self.location8_Data objectAtIndex:indexPath.row];
        playmodel.isDisplay = YES;
        playmodel.isNO = YES;
        //-------------------------
        self.model8 = [[NBAModel8Cell alloc ]init];
        self.model8.name = playmodel.name;
        self.model8.salary = playmodel.salary;
        self.model8.Id = playmodel.Id;
        self.model8.average = playmodel.average;
        self.model8.play_time = playmodel.play_time;
        self.model8.team_id = playmodel.team_id;
        self.model8.project_id = playmodel.project_id;
        self.model8.img = playmodel.img;
        self.model8.nationality = playmodel.nationality;
        self.model8.position = playmodel.position;
        self.model8.is_undetermined = playmodel.is_undetermined;
        self.model8.is_illness = playmodel.is_illness;
        self.model8.is_ban = playmodel.is_ban;
        self.model8.is_out = playmodel.is_out;
        self.model8.match_id = playmodel.match_id;
        self.model8.state = playmodel.state;
        self.model8.isDisplay = playmodel.isDisplay;
        self.model8.isNO = playmodel.isNO;
        //------------------------
        for (Player_ListModelCell *model in self.location8_Data) {
            if (model.isDisplay) {
                self.num8_lab.text = @"1/1";
            }
        }
        [self initDownView];             //底部数据
        [self TongLeftView];             //左边数据
    }else{    }
    
    [tableView reloadData];
    
}


//底部数据
- (void)initDownView{
    self.PJ_arr = [[NSMutableArray alloc] init];
    self.GZ_arr = [[NSMutableArray alloc] init];
    
    if (self.model1) {
        if (self.model1.Id.length >= 1) {
            [self.PJ_arr addObject:[NSNumber numberWithDouble:_model1.average]];
            [self.GZ_arr addObject:_model1.salary];
        }
    }
    if (self.model2) {
        if (self.model2.Id.length >= 1) {
            [self.PJ_arr addObject:[NSNumber numberWithDouble:_model2.average]];
            [self.GZ_arr addObject:_model2.salary];
        }
    }
    if (self.model3) {
        if (self.model3.Id.length >= 1) {
            [self.PJ_arr addObject:[NSNumber numberWithDouble:_model3.average]];
            [self.GZ_arr addObject:_model3.salary];
        }
    }
    if (self.model4) {
        if (self.model4.Id.length >= 1) {
            [self.PJ_arr addObject:[NSNumber numberWithDouble:_model4.average]];
            [self.GZ_arr addObject:_model4.salary];
        }
    }
    if (self.model5) {
        if (self.model5.Id.length >= 1) {
            [self.PJ_arr addObject:[NSNumber numberWithDouble:_model5.average]];
            [self.GZ_arr addObject:_model5.salary];
        }
    }
    if (self.model6) {
        if (self.model6.Id.length >= 1) {
            [self.PJ_arr addObject:[NSNumber numberWithDouble:_model6.average]];
            [self.GZ_arr addObject:_model6.salary];
        }
    }
    if (self.model7) {
        if (self.model7.Id.length >= 1) {
            [self.PJ_arr addObject:[NSNumber numberWithDouble:_model7.average]];
            [self.GZ_arr addObject:_model7.salary];
        }
    }
    if (self.model8) {
        if (self.model8.Id.length >= 1) {
            [self.PJ_arr addObject:[NSNumber numberWithDouble:_model8.average]];
            [self.GZ_arr addObject:_model8.salary];
        }
    }

    //平均分
    NSNumber *sumPJ = [self.PJ_arr valueForKeyPath:@"@sum.floatValue"];
    self.PJ_Lab.text = [NSString stringWithFormat:@"%@",sumPJ];
    
    //工资
    NSNumber *sumGZ = [self.GZ_arr valueForKeyPath:@"@sum.floatValue"];
    self.GZ_Lab.text = [NSString stringWithFormat:@"%.0f",[self.allGZ floatValue] - [sumGZ floatValue]];
    
}


//清除阵容
- (IBAction)QC_BtnClick:(UIButton *)sender {
    self.num1_lab.text = @"0/1";
    self.num2_lab.text = @"0/1";
    self.num3_lab.text = @"0/1";
    self.num4_lab.text = @"0/1";
    self.num5_lab.text = @"0/1";
    self.num6_lab.text = @"0/1";
    self.num7_lab.text = @"0/1";
    self.num8_lab.text = @"0/1";

    self.PJ_arr = [[NSMutableArray alloc] init];
    self.GZ_arr = [[NSMutableArray alloc] init];
    self.PJ_Lab.text = @"0";
    self.GZ_Lab.text = [NSString stringWithFormat:@"%.0f",[self.allGZ floatValue]];

    
    self.model1 = [[NBAModel1Cell alloc] init];
    self.model2 = [[NBAModel2Cell alloc] init];
    self.model3 = [[NBAModel3Cell alloc] init];
    self.model4 = [[NBAModel4Cell alloc] init];
    self.model5 = [[NBAModel5Cell alloc] init];
    self.model6 = [[NBAModel6Cell alloc] init];
    self.model7 = [[NBAModel7Cell alloc] init];
    self.model8 = [[NBAModel8Cell alloc] init];
    
    
    if ([self.type_id isEqualToString:@"5"]) {   //5人间
        [self.next_Btn setTitle:@"已选 0/5" forState:UIControlStateNormal];
        [self.next_Btn setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
        self.next_Btn.imageEdgeInsets = UIEdgeInsetsMake(0, 75, 0, 0);
        self.next_Btn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);

    }else{
        [self.next_Btn setTitle:@"已选 0/8" forState:UIControlStateNormal];
        [self.next_Btn setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
        self.next_Btn.imageEdgeInsets = UIEdgeInsetsMake(0, 75, 0, 0);
        self.next_Btn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    }
    
    
    [self.tableView reloadData];
    
}



//下一步
- (IBAction)next_BtnClick:(UIButton *)sender {
    if ([self.typeOder_num isEqualToString:@"1"]) {
        if (self.returnNbaModel1) {
            self.returnNbaModel1(self.model1, self.model2, self.model3, self.model4, self.model5, self.model6, self.model7, self.model8);
        }
    }else if ([self.typeOder_num isEqualToString:@"2"]){
        if (self.returnNbaModel1) {
            self.returnNbaModel1(self.model1, self.model2, self.model3, self.model4, self.model5, self.model6, self.model7, self.model8);
        }
    }else if ([self.typeOder_num isEqualToString:@"3"]){
        if (self.returnNbaModel1) {
            self.returnNbaModel1(self.model1, self.model2, self.model3, self.model4, self.model5, self.model6, self.model7, self.model8);
        }
    }else if ([self.typeOder_num isEqualToString:@"4"]){
        if (self.returnNbaModel1) {
            self.returnNbaModel1(self.model1, self.model2, self.model3, self.model4, self.model5, self.model6, self.model7, self.model8);
        }
    }else if ([self.typeOder_num isEqualToString:@"5"]){
        if (self.returnNbaModel1) {
            self.returnNbaModel1(self.model1, self.model2, self.model3, self.model4, self.model5, self.model6, self.model7, self.model8);
        }
    }else if ([self.typeOder_num isEqualToString:@"6"]){
        if (self.returnNbaModel1) {
            self.returnNbaModel1(self.model1, self.model2, self.model3, self.model4, self.model5, self.model6, self.model7, self.model8);
        }
    }else if ([self.typeOder_num isEqualToString:@"7"]){
        if (self.returnNbaModel1) {
            self.returnNbaModel1(self.model1, self.model2, self.model3, self.model4, self.model5, self.model6, self.model7, self.model8);
        }
    }else if ([self.typeOder_num isEqualToString:@"8"]){
        if (self.returnNbaModel1) {
            self.returnNbaModel1(self.model1, self.model2, self.model3, self.model4, self.model5, self.model6, self.model7, self.model8);
        }
    }else{}
    [self.navigationController popViewControllerAnimated:YES];
    
}



#pragma mark - 左部view
//左边数据
- (void)TongLeftView{
    NSMutableArray *AAA = [[NSMutableArray alloc] init];
    if (self.model1) {
        if (self.model1.Id.length >= 1) {
            self.num1_lab.text = @"1/1";
            [AAA addObject:self.model1.Id];
        }
    }
    if (self.model2) {
        if (self.model2.Id.length >= 1) {
            self.num2_lab.text = @"1/1";
            [AAA addObject:self.model2.Id];
        }
    }
    if (self.model3) {
        if (self.model3.Id.length >= 1) {
            self.num3_lab.text = @"1/1";
            [AAA addObject:self.model3.Id];
        }
    }
    if (self.model4) {
        if (self.model4.Id.length >= 1) {
            self.num4_lab.text = @"1/1";
            [AAA addObject:self.model4.Id];
        }
    }
    if (self.model5) {
        if (self.model5.Id.length >= 1) {
            self.num5_lab.text = @"1/1";
            [AAA addObject:self.model5.Id];
        }
    }
    if (self.model6) {
        if (self.model6.Id.length >= 1) {
            self.num6_lab.text = @"1/1";
            [AAA addObject:self.model6.Id];
        }
    }
    if (self.model7) {
        if (self.model7.Id.length >= 1) {
            self.num7_lab.text = @"1/1";
            [AAA addObject:self.model7.Id];
        }
    }
    if (self.model8) {
        if (self.model8.Id.length >= 1) {
            self.num8_lab.text = @"1/1";
            [AAA addObject:self.model8.Id];
        }
    }
    
    if ([self.type_id isEqualToString:@"5"]) {   //5人间
        if (AAA.count == 0 ) {
            [self.next_Btn setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
            [self.next_Btn setTitle:@"已选 0/5" forState:UIControlStateNormal];
            self.next_Btn.imageEdgeInsets = UIEdgeInsetsMake(0, 75, 0, 0);
            self.next_Btn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        }else if (AAA.count == 1 ){
            [self.next_Btn setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
            [self.next_Btn setTitle:@"已选 1/5" forState:UIControlStateNormal];
            self.next_Btn.imageEdgeInsets = UIEdgeInsetsMake(0, 75, 0, 0);
            self.next_Btn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        }else if (AAA.count == 2 ){
            [self.next_Btn setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
            [self.next_Btn setTitle:@"已选 2/5" forState:UIControlStateNormal];
            self.next_Btn.imageEdgeInsets = UIEdgeInsetsMake(0, 75, 0, 0);
            self.next_Btn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        }else if (AAA.count == 3 ){
            [self.next_Btn setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
            [self.next_Btn setTitle:@"已选 3/5" forState:UIControlStateNormal];
            self.next_Btn.imageEdgeInsets = UIEdgeInsetsMake(0, 75, 0, 0);
            self.next_Btn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        }else if (AAA.count == 4 ){
            [self.next_Btn setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
            [self.next_Btn setTitle:@"已选 4/5" forState:UIControlStateNormal];
            self.next_Btn.imageEdgeInsets = UIEdgeInsetsMake(0, 75, 0, 0);
            self.next_Btn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        }else if (AAA.count == 5 ){
            [self.next_Btn setTitle:@"下一步" forState:UIControlStateNormal];
            [self.next_Btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            self.next_Btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }else{
        if (AAA.count == 0 ) {
            [self.next_Btn setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
            [self.next_Btn setTitle:@"已选 0/8" forState:UIControlStateNormal];
            self.next_Btn.imageEdgeInsets = UIEdgeInsetsMake(0, 75, 0, 0);
            self.next_Btn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        }else if (AAA.count == 1 ){
            [self.next_Btn setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
            [self.next_Btn setTitle:@"已选 1/8" forState:UIControlStateNormal];
            self.next_Btn.imageEdgeInsets = UIEdgeInsetsMake(0, 75, 0, 0);
            self.next_Btn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        }else if (AAA.count == 2 ){
            [self.next_Btn setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
            [self.next_Btn setTitle:@"已选 2/8" forState:UIControlStateNormal];
            self.next_Btn.imageEdgeInsets = UIEdgeInsetsMake(0, 75, 0, 0);
            self.next_Btn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        }else if (AAA.count == 3 ){
            [self.next_Btn setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
            [self.next_Btn setTitle:@"已选 3/8" forState:UIControlStateNormal];
            self.next_Btn.imageEdgeInsets = UIEdgeInsetsMake(0, 75, 0, 0);
            self.next_Btn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        }else if (AAA.count == 4 ){
            [self.next_Btn setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
            [self.next_Btn setTitle:@"已选 4/8" forState:UIControlStateNormal];
            self.next_Btn.imageEdgeInsets = UIEdgeInsetsMake(0, 75, 0, 0);
            self.next_Btn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        }else if (AAA.count == 5 ){
            [self.next_Btn setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
            [self.next_Btn setTitle:@"已选 5/8" forState:UIControlStateNormal];
            self.next_Btn.imageEdgeInsets = UIEdgeInsetsMake(0, 75, 0, 0);
            self.next_Btn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        }else if (AAA.count == 6 ){
            [self.next_Btn setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
            [self.next_Btn setTitle:@"已选 6/8" forState:UIControlStateNormal];
            self.next_Btn.imageEdgeInsets = UIEdgeInsetsMake(0, 75, 0, 0);
            self.next_Btn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        }else if (AAA.count == 7 ){
            [self.next_Btn setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
            [self.next_Btn setTitle:@"已选 7/8" forState:UIControlStateNormal];
            self.next_Btn.imageEdgeInsets = UIEdgeInsetsMake(0, 75, 0, 0);
            self.next_Btn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        }else if (AAA.count == 8 ){
            [self.next_Btn setTitle:@"下一步" forState:UIControlStateNormal];
            [self.next_Btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            self.next_Btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }
}


//点击左边视图选项
- (void) initDataAAAA :(NSString *)AAAA {
    self.typeOder_num = AAAA;
    [self.tableView reloadData];
    
}
//左边View
- (void)initLeftView {
    if ([self.typeOder_num isEqualToString:@"1"]) {
        self.left_Btn1.selected = YES;
        _name1_lab.textColor = [UIColor getColorWithTheme];
        _num1_lab.textColor = [UIColor getColorWithTheme];
        _LeftView1.backgroundColor = [UIColor whiteColor];
    }else if ([self.typeOder_num isEqualToString:@"2"]){
        self.left_Btn2.selected = YES;
        _name2_lab.textColor = [UIColor getColorWithTheme];
        _num2_lab.textColor = [UIColor getColorWithTheme];
        _LeftView2.backgroundColor = [UIColor whiteColor];
    }else if ([self.typeOder_num isEqualToString:@"3"]){
        self.left_Btn3.selected = YES;
        _name3_lab.textColor = [UIColor getColorWithTheme];
        _num3_lab.textColor = [UIColor getColorWithTheme];
        _LeftView3.backgroundColor = [UIColor whiteColor];
    }else if ([self.typeOder_num isEqualToString:@"4"]){
        self.left_Btn4.selected = YES;
        _name4_lab.textColor = [UIColor getColorWithTheme];
        _num4_lab.textColor = [UIColor getColorWithTheme];
        _LeftView4.backgroundColor = [UIColor whiteColor];
    }else if ([self.typeOder_num isEqualToString:@"5"]){
        self.left_Btn5.selected = YES;
        _name5_lab.textColor = [UIColor getColorWithTheme];
        _num5_lab.textColor = [UIColor getColorWithTheme];
        _LeftView5.backgroundColor = [UIColor whiteColor];
    }else if ([self.typeOder_num isEqualToString:@"6"]){
        self.left_Btn6.selected = YES;
        _name6_lab.textColor = [UIColor getColorWithTheme];
        _num6_lab.textColor = [UIColor getColorWithTheme];
        _LeftView6.backgroundColor = [UIColor whiteColor];
    }else if ([self.typeOder_num isEqualToString:@"7"]){
        self.left_Btn7.selected = YES;
        _name7_lab.textColor = [UIColor getColorWithTheme];
        _num7_lab.textColor = [UIColor getColorWithTheme];
        _LeftView7.backgroundColor = [UIColor whiteColor];
    }else{
        self.left_Btn8.selected = YES;
        _name8_lab.textColor = [UIColor getColorWithTheme];
        _num8_lab.textColor = [UIColor getColorWithTheme];
        _LeftView8.backgroundColor = [UIColor whiteColor];
    }
    
}
//点击button
- (IBAction)Left_Btn1Click:(UIButton *)sender {
    [self initDataAAAA:@"1"];
    
    self.left_Btn1.selected = YES;
    self.left_Btn2.selected = NO;
    self.left_Btn3.selected = NO;
    self.left_Btn4.selected = NO;
    self.left_Btn5.selected = NO;
    self.left_Btn6.selected = NO;
    self.left_Btn7.selected = NO;
    self.left_Btn8.selected = NO;
    
    if (_left_Btn1.selected == YES) {
        _name1_lab.textColor = [UIColor getColorWithTheme];
        _num1_lab.textColor = [UIColor getColorWithTheme];
        _LeftView1.backgroundColor = [UIColor whiteColor];
        
        _name2_lab.textColor = [UIColor getColorWithTexts];
        _num2_lab.textColor = [UIColor getColorWithTexts];
        _LeftView2.backgroundColor = [UIColor clearColor];
        _name3_lab.textColor = [UIColor getColorWithTexts];
        _num3_lab.textColor = [UIColor getColorWithTexts];
        _LeftView3.backgroundColor = [UIColor clearColor];
        _name4_lab.textColor = [UIColor getColorWithTexts];
        _num4_lab.textColor = [UIColor getColorWithTexts];
        _LeftView4.backgroundColor = [UIColor clearColor];
        _name5_lab.textColor = [UIColor getColorWithTexts];
        _num5_lab.textColor = [UIColor getColorWithTexts];
        _LeftView5.backgroundColor = [UIColor clearColor];
        _name6_lab.textColor = [UIColor getColorWithTexts];
        _num6_lab.textColor = [UIColor getColorWithTexts];
        _LeftView6.backgroundColor = [UIColor clearColor];
        _name7_lab.textColor = [UIColor getColorWithTexts];
        _num7_lab.textColor = [UIColor getColorWithTexts];
        _LeftView7.backgroundColor = [UIColor clearColor];
        _name8_lab.textColor = [UIColor getColorWithTexts];
        _num8_lab.textColor = [UIColor getColorWithTexts];
        _LeftView8.backgroundColor = [UIColor clearColor];
        
    }

    
}
- (IBAction)Left_Btn2Click:(UIButton *)sender {
    [self initDataAAAA:@"2"];
    
    self.left_Btn1.selected = NO;
    self.left_Btn2.selected = YES;
    self.left_Btn3.selected = NO;
    self.left_Btn4.selected = NO;
    self.left_Btn5.selected = NO;
    self.left_Btn6.selected = NO;
    self.left_Btn7.selected = NO;
    self.left_Btn8.selected = NO;
    
    if (_left_Btn2.selected == YES) {
        _name2_lab.textColor = [UIColor getColorWithTheme];
        _num2_lab.textColor = [UIColor getColorWithTheme];
        _LeftView2.backgroundColor = [UIColor whiteColor];
        
        _name1_lab.textColor = [UIColor getColorWithTexts];
        _num1_lab.textColor = [UIColor getColorWithTexts];
        _LeftView1.backgroundColor = [UIColor clearColor];
        _name3_lab.textColor = [UIColor getColorWithTexts];
        _num3_lab.textColor = [UIColor getColorWithTexts];
        _LeftView3.backgroundColor = [UIColor clearColor];
        _name4_lab.textColor = [UIColor getColorWithTexts];
        _num4_lab.textColor = [UIColor getColorWithTexts];
        _LeftView4.backgroundColor = [UIColor clearColor];
        _name5_lab.textColor = [UIColor getColorWithTexts];
        _num5_lab.textColor = [UIColor getColorWithTexts];
        _LeftView5.backgroundColor = [UIColor clearColor];
        _name6_lab.textColor = [UIColor getColorWithTexts];
        _num6_lab.textColor = [UIColor getColorWithTexts];
        _LeftView6.backgroundColor = [UIColor clearColor];
        _name7_lab.textColor = [UIColor getColorWithTexts];
        _num7_lab.textColor = [UIColor getColorWithTexts];
        _LeftView7.backgroundColor = [UIColor clearColor];
        _name8_lab.textColor = [UIColor getColorWithTexts];
        _num8_lab.textColor = [UIColor getColorWithTexts];
        _LeftView8.backgroundColor = [UIColor clearColor];
        
        
    }
    

    
}
- (IBAction)Left_Btn3Click:(UIButton *)sender {
    [self initDataAAAA:@"3"];
    
    
    self.left_Btn1.selected = NO;
    self.left_Btn2.selected = NO;
    self.left_Btn3.selected = YES;
    self.left_Btn4.selected = NO;
    self.left_Btn5.selected = NO;
    self.left_Btn6.selected = NO;
    self.left_Btn7.selected = NO;
    self.left_Btn8.selected = NO;
    
    if (_left_Btn3.selected == YES) {
        _name3_lab.textColor = [UIColor getColorWithTheme];
        _num3_lab.textColor = [UIColor getColorWithTheme];
        _LeftView3.backgroundColor = [UIColor whiteColor];
        
        _name2_lab.textColor = [UIColor getColorWithTexts];
        _num2_lab.textColor = [UIColor getColorWithTexts];
        _LeftView2.backgroundColor = [UIColor clearColor];
        _name1_lab.textColor = [UIColor getColorWithTexts];
        _num1_lab.textColor = [UIColor getColorWithTexts];
        _LeftView1.backgroundColor = [UIColor clearColor];
        _name4_lab.textColor = [UIColor getColorWithTexts];
        _num4_lab.textColor = [UIColor getColorWithTexts];
        _LeftView4.backgroundColor = [UIColor clearColor];
        _name5_lab.textColor = [UIColor getColorWithTexts];
        _num5_lab.textColor = [UIColor getColorWithTexts];
        _LeftView5.backgroundColor = [UIColor clearColor];
        _name6_lab.textColor = [UIColor getColorWithTexts];
        _num6_lab.textColor = [UIColor getColorWithTexts];
        _LeftView6.backgroundColor = [UIColor clearColor];
        _name7_lab.textColor = [UIColor getColorWithTexts];
        _num7_lab.textColor = [UIColor getColorWithTexts];
        _LeftView7.backgroundColor = [UIColor clearColor];
        _name8_lab.textColor = [UIColor getColorWithTexts];
        _num8_lab.textColor = [UIColor getColorWithTexts];
        _LeftView8.backgroundColor = [UIColor clearColor];
    }

    
}
- (IBAction)Left_Btn4Click:(UIButton *)sender {
    [self initDataAAAA:@"4"];
    
    self.left_Btn1.selected = NO;
    self.left_Btn2.selected = NO;
    self.left_Btn3.selected = NO;
    self.left_Btn4.selected = YES;
    self.left_Btn5.selected = NO;
    self.left_Btn6.selected = NO;
    self.left_Btn7.selected = NO;
    self.left_Btn8.selected = NO;
    
    if (_left_Btn4.selected == YES) {
        _name4_lab.textColor = [UIColor getColorWithTheme];
        _num4_lab.textColor = [UIColor getColorWithTheme];
        _LeftView4.backgroundColor = [UIColor whiteColor];
        
        _name2_lab.textColor = [UIColor getColorWithTexts];
        _num2_lab.textColor = [UIColor getColorWithTexts];
        _LeftView2.backgroundColor = [UIColor clearColor];
        _name3_lab.textColor = [UIColor getColorWithTexts];
        _num3_lab.textColor = [UIColor getColorWithTexts];
        _LeftView3.backgroundColor = [UIColor clearColor];
        _name1_lab.textColor = [UIColor getColorWithTexts];
        _num1_lab.textColor = [UIColor getColorWithTexts];
        _LeftView1.backgroundColor = [UIColor clearColor];
        _name5_lab.textColor = [UIColor getColorWithTexts];
        _num5_lab.textColor = [UIColor getColorWithTexts];
        _LeftView5.backgroundColor = [UIColor clearColor];
        _name6_lab.textColor = [UIColor getColorWithTexts];
        _num6_lab.textColor = [UIColor getColorWithTexts];
        _LeftView6.backgroundColor = [UIColor clearColor];
        _name7_lab.textColor = [UIColor getColorWithTexts];
        _num7_lab.textColor = [UIColor getColorWithTexts];
        _LeftView7.backgroundColor = [UIColor clearColor];
        _name8_lab.textColor = [UIColor getColorWithTexts];
        _num8_lab.textColor = [UIColor getColorWithTexts];
        _LeftView8.backgroundColor = [UIColor clearColor];
    }

    
}
- (IBAction)Left_Btn5Click:(UIButton *)sender {
    [self initDataAAAA:@"5"];
    
    self.left_Btn1.selected = NO;
    self.left_Btn2.selected = NO;
    self.left_Btn3.selected = NO;
    self.left_Btn4.selected = NO;
    self.left_Btn5.selected = YES;
    self.left_Btn6.selected = NO;
    self.left_Btn7.selected = NO;
    self.left_Btn8.selected = NO;
    
    if (_left_Btn5.selected == YES) {
        _name5_lab.textColor = [UIColor getColorWithTheme];
        _num5_lab.textColor = [UIColor getColorWithTheme];
        _LeftView5.backgroundColor = [UIColor whiteColor];
        
        _name2_lab.textColor = [UIColor getColorWithTexts];
        _num2_lab.textColor = [UIColor getColorWithTexts];
        _LeftView2.backgroundColor = [UIColor clearColor];
        _name3_lab.textColor = [UIColor getColorWithTexts];
        _num3_lab.textColor = [UIColor getColorWithTexts];
        _LeftView3.backgroundColor = [UIColor clearColor];
        _name4_lab.textColor = [UIColor getColorWithTexts];
        _num4_lab.textColor = [UIColor getColorWithTexts];
        _LeftView4.backgroundColor = [UIColor clearColor];
        _name1_lab.textColor = [UIColor getColorWithTexts];
        _num1_lab.textColor = [UIColor getColorWithTexts];
        _LeftView1.backgroundColor = [UIColor clearColor];
        _name6_lab.textColor = [UIColor getColorWithTexts];
        _num6_lab.textColor = [UIColor getColorWithTexts];
        _LeftView6.backgroundColor = [UIColor clearColor];
        _name7_lab.textColor = [UIColor getColorWithTexts];
        _num7_lab.textColor = [UIColor getColorWithTexts];
        _LeftView7.backgroundColor = [UIColor clearColor];
        _name8_lab.textColor = [UIColor getColorWithTexts];
        _num8_lab.textColor = [UIColor getColorWithTexts];
        _LeftView8.backgroundColor = [UIColor clearColor];
    }
    

    
}
- (IBAction)Left_Btn6Click:(UIButton *)sender {
    [self initDataAAAA:@"6"];
    
    self.left_Btn1.selected = NO;
    self.left_Btn2.selected = NO;
    self.left_Btn3.selected = NO;
    self.left_Btn4.selected = NO;
    self.left_Btn5.selected = NO;
    self.left_Btn6.selected = YES;
    self.left_Btn7.selected = NO;
    self.left_Btn8.selected = NO;
    
    if (_left_Btn6.selected == YES) {
        _name6_lab.textColor = [UIColor getColorWithTheme];
        _num6_lab.textColor = [UIColor getColorWithTheme];
        _LeftView6.backgroundColor = [UIColor whiteColor];
        
        _name2_lab.textColor = [UIColor getColorWithTexts];
        _num2_lab.textColor = [UIColor getColorWithTexts];
        _LeftView2.backgroundColor = [UIColor clearColor];
        _name3_lab.textColor = [UIColor getColorWithTexts];
        _num3_lab.textColor = [UIColor getColorWithTexts];
        _LeftView3.backgroundColor = [UIColor clearColor];
        _name4_lab.textColor = [UIColor getColorWithTexts];
        _num4_lab.textColor = [UIColor getColorWithTexts];
        _LeftView4.backgroundColor = [UIColor clearColor];
        _name1_lab.textColor = [UIColor getColorWithTexts];
        _num1_lab.textColor = [UIColor getColorWithTexts];
        _LeftView1.backgroundColor = [UIColor clearColor];
        _name5_lab.textColor = [UIColor getColorWithTexts];
        _num5_lab.textColor = [UIColor getColorWithTexts];
        _LeftView5.backgroundColor = [UIColor clearColor];
        _name7_lab.textColor = [UIColor getColorWithTexts];
        _num7_lab.textColor = [UIColor getColorWithTexts];
        _LeftView7.backgroundColor = [UIColor clearColor];
        _name8_lab.textColor = [UIColor getColorWithTexts];
        _num8_lab.textColor = [UIColor getColorWithTexts];
        _LeftView8.backgroundColor = [UIColor clearColor];
    }

    
}
- (IBAction)Left_Btn7Click:(UIButton *)sender {
    [self initDataAAAA:@"7"];
    
    self.left_Btn1.selected = NO;
    self.left_Btn2.selected = NO;
    self.left_Btn3.selected = NO;
    self.left_Btn4.selected = NO;
    self.left_Btn5.selected = NO;
    self.left_Btn6.selected = NO;
    self.left_Btn7.selected = YES;
    self.left_Btn8.selected = NO;
    
    if (_left_Btn7.selected == YES) {
        _name7_lab.textColor = [UIColor getColorWithTheme];
        _num7_lab.textColor = [UIColor getColorWithTheme];
        _LeftView7.backgroundColor = [UIColor whiteColor];
        
        _name2_lab.textColor = [UIColor getColorWithTexts];
        _num2_lab.textColor = [UIColor getColorWithTexts];
        _LeftView2.backgroundColor = [UIColor clearColor];
        _name3_lab.textColor = [UIColor getColorWithTexts];
        _num3_lab.textColor = [UIColor getColorWithTexts];
        _LeftView3.backgroundColor = [UIColor clearColor];
        _name4_lab.textColor = [UIColor getColorWithTexts];
        _num4_lab.textColor = [UIColor getColorWithTexts];
        _LeftView4.backgroundColor = [UIColor clearColor];
        _name1_lab.textColor = [UIColor getColorWithTexts];
        _num1_lab.textColor = [UIColor getColorWithTexts];
        _LeftView1.backgroundColor = [UIColor clearColor];
        _name6_lab.textColor = [UIColor getColorWithTexts];
        _num6_lab.textColor = [UIColor getColorWithTexts];
        _LeftView6.backgroundColor = [UIColor clearColor];
        _name5_lab.textColor = [UIColor getColorWithTexts];
        _num5_lab.textColor = [UIColor getColorWithTexts];
        _LeftView5.backgroundColor = [UIColor clearColor];
        _name8_lab.textColor = [UIColor getColorWithTexts];
        _num8_lab.textColor = [UIColor getColorWithTexts];
        _LeftView8.backgroundColor = [UIColor clearColor];
    }
    

    
}
- (IBAction)Left_Btn8Click:(UIButton *)sender {
    [self initDataAAAA:@"8"];
    
    self.left_Btn1.selected = NO;
    self.left_Btn2.selected = NO;
    self.left_Btn3.selected = NO;
    self.left_Btn4.selected = NO;
    self.left_Btn5.selected = NO;
    self.left_Btn6.selected = NO;
    self.left_Btn7.selected = NO;
    self.left_Btn8.selected = YES;
    
    if (_left_Btn8.selected == YES) {
        _name8_lab.textColor = [UIColor getColorWithTheme];
        _num8_lab.textColor = [UIColor getColorWithTheme];
        _LeftView8.backgroundColor = [UIColor whiteColor];
        
        _name2_lab.textColor = [UIColor getColorWithTexts];
        _num2_lab.textColor = [UIColor getColorWithTexts];
        _LeftView2.backgroundColor = [UIColor clearColor];
        _name3_lab.textColor = [UIColor getColorWithTexts];
        _num3_lab.textColor = [UIColor getColorWithTexts];
        _LeftView3.backgroundColor = [UIColor clearColor];
        _name4_lab.textColor = [UIColor getColorWithTexts];
        _num4_lab.textColor = [UIColor getColorWithTexts];
        _LeftView4.backgroundColor = [UIColor clearColor];
        _name1_lab.textColor = [UIColor getColorWithTexts];
        _num1_lab.textColor = [UIColor getColorWithTexts];
        _LeftView1.backgroundColor = [UIColor clearColor];
        _name6_lab.textColor = [UIColor getColorWithTexts];
        _num6_lab.textColor = [UIColor getColorWithTexts];
        _LeftView6.backgroundColor = [UIColor clearColor];
        _name7_lab.textColor = [UIColor getColorWithTexts];
        _num7_lab.textColor = [UIColor getColorWithTexts];
        _LeftView7.backgroundColor = [UIColor clearColor];
        _name5_lab.textColor = [UIColor getColorWithTexts];
        _num5_lab.textColor = [UIColor getColorWithTexts];
        _LeftView5.backgroundColor = [UIColor clearColor];
    }

    
}



@end


@implementation NBAModel1
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [NBAModel1Cell class]};
}
@end
@implementation NBAModel1Cell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id" };
}
@end
@implementation NBAModel2
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [NBAModel2Cell class]};
}
@end
@implementation NBAModel2Cell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id" };
}
@end
@implementation NBAModel3
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [NBAModel3Cell class]};
}
@end
@implementation NBAModel3Cell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id" };
}
@end@implementation NBAModel4
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [NBAModel4Cell class]};
}
@end
@implementation NBAModel4Cell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id" };
}
@end@implementation NBAModel5
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [NBAModel5Cell class]};
}
@end
@implementation NBAModel5Cell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id" };
}
@end@implementation NBAModel6
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [NBAModel6Cell class]};
}
@end
@implementation NBAModel6Cell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id" };
}
@end
@implementation NBAModel7
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [NBAModel7Cell class]};
}
@end
@implementation NBAModel7Cell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id" };
}
@end@implementation NBAModel8
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [NBAModel8Cell class]};
}
@end
@implementation NBAModel8Cell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id" };
}
@end

