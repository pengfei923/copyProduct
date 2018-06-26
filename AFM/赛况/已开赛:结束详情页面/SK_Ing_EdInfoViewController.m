//
//  SK_Ing_EdInfoViewController.m
//  AFM
//
//  Created by admin on 2017/9/22.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "SK_Ing_EdInfoViewController.h"
#import "ZRXQTableViewCell.h"
#import "SSDZTableViewCell.h"
#import "JCPMTableViewCell.h"
#import "WJHDTableViewCell.h"
#import "JCPM_topTableViewCell.h"
#import "ZRXQ_topTableViewCell.h"
#import "SK_InfoModel.h"
#import "PlayerInfoViewController.h"
#import "ChatModel.h"
#import "KeyboardView.h"
#import "DJ_PlayerViewController.h"
#import "MyPlayer_ZRTableViewCell.h"
#import "MyPlayer_ZRViewController.h"

@interface SK_Ing_EdInfoViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    NSString *isKey;
    NSInteger numPerPage;

}

@property (nonatomic , strong) UIScrollView *scrollView;         //
@property (nonatomic , strong) UITableView  *tableView;         //列表视图
@property (nonatomic , strong) UITableView  *tableView2;   //聊天视图
@property (nonatomic , strong) NSString *Tag;
@property (nonatomic , strong) KeyboardView  *keyboardView;          //底部键盘View
@property (nonatomic , strong) SK_InfoModelCell *allmodel;
@property (nonatomic , strong) SK_InfoRoomData  *roomInfoModel;          //
@property (nonatomic , strong) SK_InfoUser_RData *infoUser_RData;   //排名
@property (nonatomic , strong) NSMutableArray *chatData;
@end

@implementation SK_Ing_EdInfoViewController

NSString *SKIaE_ZRXQcell = @"MyPlayer_ZRTableViewCell";
NSString *SKIaE_SSDZcell = @"SSDZTableViewCell";
NSString *SKIaE_JCPMcell = @"JCPMTableViewCell";
NSString *SKIaE_WJHDcell = @"WJHDTableViewCell";

NSString *SKtop_JCPMcell = @"JCPM_topTableViewCell";
NSString *SKtop_ZRXQcell = @"ZRXQ_topTableViewCell";

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES]; //显示导航
    
    [self initData];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
    [self addNoticeForKeyboard];

}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = self.ronmName;

}


//初始化界面
- (void)initView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, screen_Width *2, screen_Height-40 -64)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height -40-64) style:UITableViewStylePlain];
    self.tableView.tag = 1;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;  // 滚动条
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线
    self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView registerClass:[MyPlayer_ZRTableViewCell class] forCellReuseIdentifier:SKIaE_ZRXQcell];
    [self.tableView registerClass:[SSDZTableViewCell class] forCellReuseIdentifier:SKIaE_SSDZcell];
    [self.tableView registerClass:[JCPMTableViewCell class] forCellReuseIdentifier:SKIaE_JCPMcell];
    [self.tableView registerClass:[JCPM_topTableViewCell class] forCellReuseIdentifier:SKtop_JCPMcell];
    [self.tableView registerClass:[ZRXQ_topTableViewCell class] forCellReuseIdentifier:SKtop_ZRXQcell];
    [self.scrollView addSubview:self.tableView];
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;

    
    self.tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(screen_Width, 0, screen_Width, screen_Height -40-64-40) style:UITableViewStylePlain];
    self.tableView2.tag = 2;
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    self.tableView2.showsVerticalScrollIndicator = NO;
    self.tableView2.separatorColor = [UIColor getColorWithdown];
    self.tableView2.estimatedRowHeight = 100;
    self.tableView2.rowHeight = UITableViewAutomaticDimension;
    self.tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线
    self.tableView2.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView2 registerClass:[WJHDTableViewCell class] forCellReuseIdentifier:SKIaE_WJHDcell];
    [self.scrollView addSubview:self.tableView2];
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView2.estimatedRowHeight = 0;
    self.tableView2.estimatedSectionHeaderHeight = 0;
    self.tableView2.estimatedSectionFooterHeight = 0;

    
    //创建keyboardView
    self.keyboardView = [KeyboardView initKeyView];
    self.keyboardView.frame = CGRectMake(screen_Width, screen_Height-44 -64-40, screen_Width,44 );
    [self.keyboardView.turn_Btn addTarget:self action:@selector(commentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.keyboardView.txtInput.delegate = self;
    self.keyboardView.txtInput.tag = 1;
    self.keyboardView.txtInput.adjustsFontSizeToFitWidth = YES;  //文字滚动
    self.keyboardView.txtInput.returnKeyType = UIReturnKeySend;  //确认按钮

    [self.scrollView addSubview:self.keyboardView];

    self.Tag = @"1";
    self.line2.hidden = YES;
    self.line3.hidden = YES;
    self.line4.hidden = YES;
    
    ZFRefreshGifHeader *header = [ZFRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView2.mj_header = header;
    
    ZFRefreshAutoNormalFooter *footer = [ZFRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView2.mj_footer = footer;

}

#pragma mark - 下拉刷新数据
- (void)loadNewData{
    numPerPage ++;
    [self initListChatData];
}


- (void)loadMoreData {
    numPerPage --;
    [self initListChatData];
}


//初始化数据
- (void)initData{
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=user&a=userroomdetail&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                @"id":self.ID,// (未开赛以及比赛中的guess_id)
                                @"room_id":self.roomID,
                                };
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
            NSMutableDictionary *Dic = [[NSMutableDictionary alloc]initWithDictionary:[dic objectForKey:@"data"]];
            SK_InfoModelCell *Model = [SK_InfoModelCell yy_modelWithDictionary:Dic];
            self.allmodel = Model;
            NSMutableDictionary *DDic = [[NSMutableDictionary alloc]initWithDictionary:[Dic objectForKey:@"room_info"]];
            SK_InfoRoomData *RoomModel = [SK_InfoRoomData yy_modelWithDictionary:DDic];
            self.roomInfoModel = RoomModel;
            
            SK_InfoUser_RData *PMModel = [SK_InfoUser_RData yy_modelWithDictionary:Dic];
            self.infoUser_RData = PMModel;
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

//点击玩家互动-------请求聊天列表
- (IBAction)chatClick:(UIButton *)sender {
    numPerPage = 2;
    [self.tableView2.mj_footer beginRefreshing];

}

//聊天列表
- (void)initListChatData{
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=room&a=show_comment&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                @"room_id":self.roomID,
                                @"page":[NSString stringWithFormat:@"%ld",(long)numPerPage] };
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
            ChatModel *listModel = [ChatModel yy_modelWithDictionary:dic];

            if (numPerPage == 1) {
                NSArray *SALA_GD = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"addtime" ascending:YES]];
                self.chatData = [[NSMutableArray alloc] initWithArray:[listModel.data sortedArrayUsingDescriptors:SALA_GD]];
                [self.tableView2.mj_header endRefreshing];
            } else {
                NSMutableArray *AAAAAA =[[NSMutableArray alloc] init];
                [AAAAAA addObjectsFromArray:listModel.data];
                NSArray *SALA_GD = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"addtime" ascending:YES]];
                self.chatData = [[NSMutableArray alloc] initWithArray:[AAAAAA sortedArrayUsingDescriptors:SALA_GD]];
                [self.tableView2.mj_footer endRefreshing];

            }
        }
        [self.tableView2.mj_header endRefreshing];
        [self.tableView2.mj_footer endRefreshing];
        [self.tableView2 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 1){
        return 2;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 1){
        if (section == 0 ) {
            return 1;
        }else{
            if ([_Tag isEqualToString:@"1"]) {
                return self.allmodel.lineup_player.count;
            }else if ([_Tag isEqualToString:@"2"]){
                return self.roomInfoModel.match_list.count;
            }else {
                return self.allmodel.all_user_rank.count;
            }
        }
    }else{
        return self.chatData.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1){
        if (indexPath.section == 0) {
            if ([_Tag isEqualToString:@"1"]) {
                return 30;
            }else if ([_Tag isEqualToString:@"2"]){
                return 0.1;
            }else if ([_Tag isEqualToString:@"3"]){
                return 115;
            }else{
                return 0.1;
            }
        }else{
            if ([_Tag isEqualToString:@"1"]) {
                return 90;
            }else if ([_Tag isEqualToString:@"2"]){
                return 100;
            }else if ([_Tag isEqualToString:@"3"]){
                return 86;
            }else{
                return 0.1;
            }
        }
    }else{
        ChatModelCell *model = [self.chatData objectAtIndex:indexPath.row];
        NSString *cellStr = model.content;
        CGSize cellSize = [cellStr boundingRectWithSize:CGSizeMake(self.view.frame.size.width-20, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
        //cellSize的高度为文字的真实高度，需要上下都留出空白
        return cellSize.height + 80;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 1){
        if (indexPath.section == 0) {
            if ([_Tag isEqualToString:@"1"]) {
                ZRXQ_topTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SKtop_ZRXQcell];
                return cell;
            }else if ([_Tag isEqualToString:@"2"]){
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleId"];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"titleId"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                return cell;
            }else{
                JCPM_topTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SKtop_JCPMcell];
                cell.num_Lab.text = self.ZHUnum;
                cell.PM_1lab.text = [NSString stringWithFormat:@"%@/",self.myPM];
                cell.PM_2lab.text = [NSString stringWithFormat:@"%@",self.zPM];
                cell.GJ_Lab.text = [NSString stringWithFormat:@"%0.1f",self.infoUser_RData.lineup_score];
                
               return cell;
            }
        }else{
            if ([_Tag isEqualToString:@"1"]) {
                MyPlayer_ZRTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SKIaE_ZRXQcell];
                SK_InfoLineup_PlayerData *Model = [self.allmodel.lineup_player objectAtIndex:indexPath.row];
                cell.Model = Model;
                [cell.icon_IMG yy_setImageWithURL:[NSURL URLWithString:Model.img] placeholder:[UIImage imageNamed:@"player-photo"]];
                cell.name_Lab.text = Model.name;
                cell.GZ_Lab.text = [NSString stringWithFormat:@"$ %@",Model.salary];
                [cell.GZ_Lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];

                cell.icon_Btn.tag = indexPath.row;
                [cell.icon_Btn addTarget:self action:@selector(icon_BtnClick:) forControlEvents:UIControlEventTouchUpInside];
 
                if ([Model.match_data.is_join isEqualToString:@"1"]) {   // 是否上场 1是2否
                    cell.is_join.selected = YES;
                }else{
                    cell.is_join.selected = NO;
                }
                //比赛状态
                for (SK_RoomInfoMatch_listData *model in self.roomInfoModel.match_list) {
                    if (Model.match_data.match_id == model.Id) {
                        if ([model.match_status isEqualToString:@"3"]) {
                            cell.state_M.text = @"已结束";
                            cell.state_M.textColor = [UIColor grayColor];
                        }else{
                            cell.state_M.text = @"比赛中";
                            cell.state_M.textColor = [UIColor orangeColor];
                        }
                    }
                }

                if ([self.project_id isEqualToString:@"4"]) {    //nba
                    //判断球员自己属于哪个队伍
                    if (Model.match_data.team_id == Model.match_data.team_a_id) {
                        cell.dui1_lab.textColor = [UIColor blackColor];
                        [cell.dui1_lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
                        cell.dui2_lab.textColor = [UIColor darkGrayColor];
                    }else{
                        cell.dui1_lab.textColor = [UIColor darkGrayColor];
                        cell.dui2_lab.textColor = [UIColor blackColor];
                        [cell.dui2_lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
                    }
                    if ([Model.match_data.team_a_score intValue] > [Model.match_data.team_b_score intValue]) {
                        cell.num1_lab.textColor = [UIColor redColor];
                        cell.num2_lab.textColor = [UIColor darkGrayColor];
                    }else if ([Model.match_data.team_a_score intValue] < [Model.match_data.team_b_score intValue]){
                        cell.num2_lab.textColor = [UIColor redColor];
                        cell.num1_lab.textColor = [UIColor darkGrayColor];
                    }else{
                        cell.num2_lab.textColor = [UIColor redColor];
                        cell.num1_lab.textColor = [UIColor redColor];
                    }
                    //比赛战绩
                    cell.dui1_lab.text = [Model.match_data.team_a_name objectForKey:@"short_name"];
                    cell.dui2_lab.text = [Model.match_data.team_b_name objectForKey:@"short_name"];
                    cell.num1_lab.text = Model.match_data.team_a_score;
                    cell.num2_lab.text = Model.match_data.team_b_score;
                    [cell.num1_lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
                    [cell.num2_lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];

                    //比赛数据
                    cell.lol_dotaView.hidden = YES;
                    cell.nbaView.hidden = NO;
                    cell.JF_Lab.text = [NSString stringWithFormat:@"%0.1f",Model.match_data.score];
                    [cell.JF_Lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
                    cell.deF_L.text = Model.match_data.get_score;
                    cell.sanF_Lab.text = Model.match_data.three_point;
                    cell.lanB_Lab.text = Model.match_data.backboard;
                    cell.zhuG_Lab.text = Model.match_data.help_score;
                    cell.qiangD_Lab.text = Model.match_data.hinder_score;
                    cell.fengG_Lab.text = Model.match_data.cover_score;
                    cell.shiW_Lab.text = Model.match_data.mistake_score;
                    

                    if ([Model.position isEqualToString:@"1"]) {
                        cell.biao_lab.text = @"控卫";
                    }else if ([Model.position isEqualToString:@"2"]){
                        cell.biao_lab.text = @"分卫";
                    }else if ([Model.position isEqualToString:@"3"]){
                        cell.biao_lab.text = @"小前";
                    }else if ([Model.position isEqualToString:@"4"]){
                        cell.biao_lab.text = @"大前";
                    }else if ([Model.position isEqualToString:@"5"]){
                        cell.biao_lab.text = @"中锋";
                    }else if ([Model.position isEqualToString:@"6"]){
                        cell.biao_lab.text = @"替补";
                    }else{
                        cell.biao_lab.text = @"替补";
                    }
                }else if ([self.project_id isEqualToString:@"5"]){     //lol
                    cell.lol_dotaView.hidden = NO;
                    cell.nbaView.hidden = YES;
                    
                    for (SK_RoomInfoMatch_listData *model in self.roomInfoModel.match_list) {
                        if (Model.team_id == model.team_a || Model.team_id == model.team_b) {
                            cell.dui1_lab.text = model.name_a;
                            cell.dui2_lab.text = model.name_b;
                            cell.num1_lab.text = model.score_a;
                            cell.num2_lab.text = model.score_b;
                            [cell.num1_lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
                            [cell.num2_lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
                            
                            //判断那个分数高
                            if ([model.score_a intValue] > [model.score_b intValue]) {
                                cell.num1_lab.textColor = [UIColor redColor];
                                cell.num2_lab.textColor = [UIColor darkGrayColor];
                            }else if ([model.score_a intValue] < [model.score_b intValue]){
                                cell.num2_lab.textColor = [UIColor redColor];
                                cell.num1_lab.textColor = [UIColor darkGrayColor];
                            }else{
                                cell.num2_lab.textColor = [UIColor redColor];
                                cell.num1_lab.textColor = [UIColor redColor];
                            }
                            //判断球员自己属于哪个队伍
                            if (Model.team_name == model.name_a) {
                                cell.dui1_lab.textColor = [UIColor blackColor];
                                [cell.dui1_lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
                                cell.dui2_lab.textColor = [UIColor darkGrayColor];
                            }else if (Model.team_name == model.name_b){
                                cell.dui1_lab.textColor = [UIColor darkGrayColor];
                                cell.dui2_lab.textColor = [UIColor blackColor];
                                [cell.dui2_lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
                            }else{  }
                        }
                    }
                   
                    cell.JF_Lab.text = [NSString stringWithFormat:@"%0.1f",Model.match_data.scores];
                    [cell.JF_Lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
                    cell.jiS_Lab.text = Model.match_data.kill;
                    cell.zhuG_lab.text = Model.match_data.assists;
                    cell.siW_Lab.text = Model.match_data.death;
                    cell.BuD_lab.text = Model.match_data.jungle;
                    cell.kda_Lab.text = [NSString stringWithFormat:@"%0.1f",Model.KDA];
                    
                    
                    
                    
                    if ([Model.position isEqualToString:@"1"]) {
                        cell.biao_lab.text = @"上单";
                    }else if ([Model.position isEqualToString:@"2"]){
                        cell.biao_lab.text = @"打野";
                    }else if ([Model.position isEqualToString:@"3"]){
                        cell.biao_lab.text = @"中单";
                    }else if ([Model.position isEqualToString:@"4"]){
                        cell.biao_lab.text = @"ADC";
                    }else if ([Model.position isEqualToString:@"5"]){
                        cell.biao_lab.text = @"辅助";
                    }else if ([Model.position isEqualToString:@"6"]){
                        cell.biao_lab.text = @"战队";
                    }else{
                        cell.biao_lab.text = @"替补";
                    }
                }else{
                    cell.lol_dotaView.hidden = NO;
                    cell.nbaView.hidden = YES;
                    
                    for (SK_RoomInfoMatch_listData *model in self.roomInfoModel.match_list) {
                        if (Model.team_id == model.team_a || Model.team_id == model.team_b) {
                            cell.dui1_lab.text = model.name_a;
                            cell.dui2_lab.text = model.name_b;
                            cell.num1_lab.text = model.score_a;
                            cell.num2_lab.text = model.score_b;
                            [cell.num1_lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
                            [cell.num2_lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
                            
                            //判断那个分数高
                            if ([model.score_a intValue] > [model.score_b intValue]) {
                                cell.num1_lab.textColor = [UIColor redColor];
                                cell.num2_lab.textColor = [UIColor darkGrayColor];
                            }else if ([model.score_a intValue] < [model.score_b intValue]){
                                cell.num2_lab.textColor = [UIColor redColor];
                                cell.num1_lab.textColor = [UIColor darkGrayColor];
                            }else{
                                cell.num2_lab.textColor = [UIColor redColor];
                                cell.num1_lab.textColor = [UIColor redColor];
                            }
                            //判断球员自己属于哪个队伍
                            if (Model.team_name == model.name_a) {
                                cell.dui1_lab.textColor = [UIColor blackColor];
                                [cell.dui1_lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
                                cell.dui2_lab.textColor = [UIColor darkGrayColor];
                            }else if (Model.team_name == model.name_b){
                                cell.dui1_lab.textColor = [UIColor darkGrayColor];
                                cell.dui2_lab.textColor = [UIColor blackColor];
                                [cell.dui2_lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
                            }else{  }
                        }
                    }
                    
                    cell.JF_Lab.text = [NSString stringWithFormat:@"%0.1f",Model.match_data.scores];
                    [cell.JF_Lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
                    cell.jiS_Lab.text = Model.match_data.kill;
                    cell.zhuG_lab.text = Model.match_data.assists;
                    cell.siW_Lab.text = Model.match_data.death;
                    cell.BuD_lab.text = Model.match_data.jungle;
                    cell.kda_Lab.text = [NSString stringWithFormat:@"%0.1f",Model.KDA];

                    if ([Model.position isEqualToString:@"1"]) {
                        cell.biao_lab.text = @"一号位";
                    }else if ([Model.position isEqualToString:@"2"]){
                        cell.biao_lab.text = @"二号位";
                    }else if ([Model.position isEqualToString:@"3"]){
                        cell.biao_lab.text = @"三号位";
                    }else if ([Model.position isEqualToString:@"4"]){
                        cell.biao_lab.text = @"四号位";
                    }else if ([Model.position isEqualToString:@"5"]){
                        cell.biao_lab.text = @"五号位";
                    }else if ([Model.position isEqualToString:@"6"]){
                        cell.biao_lab.text = @"团队";
                    }else{
                        cell.biao_lab.text = @"替补";
                    }
                }
                
                return cell;
            }else if ([_Tag isEqualToString:@"2"]){
                SSDZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SKIaE_SSDZcell];
                SK_RoomInfoMatch_listData *model = [self.roomInfoModel.match_list objectAtIndex:indexPath.row];
                [cell.Left_Img yy_setImageWithURL:[NSURL URLWithString:model.img_a] placeholder:[UIImage imageNamed:@" "]];
                [cell.right_Img yy_setImageWithURL:[NSURL URLWithString:model.img_b] placeholder:[UIImage imageNamed:@" "]];
                cell.left_Lab.text = model.name_a;
                cell.right_Lab.text = model.name_b;
                cell.title_Lab.text = @"";

                [cell.VS_Lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30]];
                cell.VS_Lab.text = [NSString stringWithFormat:@"%@  :  %@",model.score_a,model.score_b];

                if ([model.match_status isEqualToString:@"3"]) {  //已结束
                    cell.time_lab.textColor = [UIColor grayColor];
                    cell.time_lab.text = @"已结束";
                }else {                                     //比赛中
                    cell.time_lab.textColor = [UIColor orangeColor];
                    cell.time_lab.text = @"比赛中";
                }
                
                return cell;
            }else {
                JCPMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SKIaE_JCPMcell];
                SK_InfoUser_RankData *usermodel = [self.allmodel.all_user_rank objectAtIndex:indexPath.row ];
                cell.name_Lab.text = usermodel.username;
                cell.lable1.text = usermodel.total_play_time;
                cell.lable2.text = [NSString stringWithFormat:@"%0.2f",usermodel.lineup_score];
                if ([usermodel.is_reward isEqualToString:@""]) {
                    cell.lable3.text = @"无";
                }else{
                    cell.lable3.text = usermodel.is_reward;
                }
                if ([usermodel.username isEqualToString:self.appCache.loginViewModel.username]) {
                    cell.PM_Lab.text = @"您的排名";
                    cell.PM_Lab.textColor = [UIColor whiteColor];
                    cell.PMnum_Lab.textColor = [UIColor whiteColor];
                    cell.left_Img.image = [UIImage imageNamed:@"rank-bg2"];
                }else{
                    cell.PM_Lab.text = @"当前排名";
                    cell.PM_Lab.textColor = [UIColor getColorWithTextTheme];
                    cell.PMnum_Lab.textColor = [UIColor darkGrayColor];
                    cell.left_Img.image = [UIImage imageNamed:@"rank-bg1"];
                }
                cell.PMnum_Lab.text = usermodel.ranking;
                [cell.icon_Img yy_setImageWithURL:[NSURL URLWithString:usermodel.avatar_img] placeholder:[UIImage imageNamed:@" "]];
                [cell.CH_Img yy_setImageWithURL:[NSURL URLWithString:usermodel.rank_img] placeholder:[UIImage imageNamed:@" "]];
                cell.CH_Lab.text = usermodel.rank_name;

                return cell;
             }
        }
    }else{
        ChatModelCell *model = [self.chatData objectAtIndex:indexPath.row];
        WJHDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SKIaE_WJHDcell];
        cell.my_lab.text = model.content;
        
        if ([model.uid isEqualToString:self.appCache.loginViewModel.Id]) {//自己
            cell.my_name.text = model.username;
            cell.you_name.hidden = YES;
            cell.you_img.hidden = YES;
            cell.my_view.backgroundColor = [UIColor getColorWithR:160 G:210 B:100 A:1];
            [cell.my_img yy_setImageWithURL:[NSURL URLWithString:model.avatar] placeholder:[UIImage imageNamed:@" "]];
        }else{//别人
            cell.you_name.text = model.username;
            cell.my_name.hidden = YES;
            cell.my_img.hidden = YES;
            cell.my_view.backgroundColor = [UIColor getColorWithdown];
            cell.my_view.layer.borderColor = [UIColor grayColor].CGColor;
            cell.my_view.layer.borderWidth = 0.5;
            [cell.you_img yy_setImageWithURL:[NSURL URLWithString:model.avatar] placeholder:[UIImage imageNamed:@" "]];
        }
        
//        //行间距
//        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:model.content];
//        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        [paragraphStyle setLineSpacing:5];//调整行间距
//        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [model.content length])];
//        cell.my_lab.attributedText = attributedString;
//        [cell.my_lab sizeToFit];
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 1){
//        if ([_Tag isEqualToString:@"3"]) {
//            MyPlayer_ZRViewController *PlayerVC = [[MyPlayer_ZRViewController alloc] init];
//            PlayerVC.roomName = self.ronmName;
//            [PlayerVC setHidesBottomBarWhenPushed:YES];
//            [self.navigationController pushViewController:PlayerVC animated:YES];
//        }
    }
}

//头像点击
- (void)icon_BtnClick:(UIButton *)Btn{
    if ([self.project_id isEqualToString:@"4"]) {          //nba
        SK_InfoLineup_PlayerData *model = [self.allmodel.lineup_player objectAtIndex:Btn.tag];
        PlayerInfoViewController *PlayerVC = [[PlayerInfoViewController alloc] init];
        [PlayerVC setHidesBottomBarWhenPushed:YES];
        PlayerVC.Player = model;
        PlayerVC.lol_data_nba = @"nba";
        
        [self.navigationController pushViewController:PlayerVC animated:YES];
        
    }else if ([self.project_id isEqualToString:@"5"]){      //lol
        SK_InfoLineup_PlayerData *model = [self.allmodel.lineup_player objectAtIndex:Btn.tag];
        DJ_PlayerViewController *PlayerVC = [[DJ_PlayerViewController alloc] init];
        PlayerVC.Player = model;
        
        PlayerVC.lol_data_nba = @"lol";
        [PlayerVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:PlayerVC animated:YES];
        
    }else{
        SK_InfoLineup_PlayerData *model = [self.allmodel.lineup_player objectAtIndex:Btn.tag];
        DJ_PlayerViewController *PlayerVC = [[DJ_PlayerViewController alloc] init];
        PlayerVC.Player = model;
        
        PlayerVC.lol_data_nba = @"dota";
        [PlayerVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:PlayerVC animated:YES];
        
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.keyboardView.inputView becomeFirstResponder];
}
//发送按钮的回调方法
- (void)commentButtonAction:(UIButton *)sender{
    [self initAddData:self.keyboardView.txtInput.text];
}
///键盘通知
- (void)addNoticeForKeyboard {
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}
///键盘显示事件
- (void)keyboardWillShow:(NSNotification *)notification {
    isKey  = @"1";//

    //获取键盘高度
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //计算出键盘顶端到inputTextView panel底端的距离
    CGFloat offset = (self.keyboardView.frame.origin.y + self.keyboardView.frame.size.height) - (self.scrollView.frame.size.height+44 - kbHeight);
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            self.scrollView.frame = CGRectMake(-screen_Width, -offset, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        }];
    }
}
///键盘消失事件
- (void)keyboardWillHidden:(NSNotification *)notify {
    isKey  = @"1";//

    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.scrollView.frame = CGRectMake(-screen_Width, 40, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        
    }];
}
///通知消失
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
///文本框内容发生变化
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //当文本框只有一个字符的时候，我们需要判定该字符是添加的还是需要删除的。如果是添加，需要打开用户交互，如果是删除，需要关闭用户交互
    if (string.length){//添加字符串，打开用户交互
        self.keyboardView.turn_Btn.userInteractionEnabled = YES;
    }else{
        if (textField.text.length <= 1) {
            self.keyboardView.turn_Btn.userInteractionEnabled = NO;
        }
    }
    return YES;
}
///点击确认
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (![self.keyboardView.txtInput isExclusiveTouch]) {
        [self.keyboardView.txtInput resignFirstResponder];
    }
    if (textField.text.length > 0) {
        [self initAddData:textField.text];
    }else {
        [AppDelegate notificationRequestInfoWithStatus:@"请输入您要反馈的内容"];
    }
    self.keyboardView.txtInput.text = @"";
    return YES;
}
///添加留言
- (void)initAddData:(NSString *)feedbackContent{
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=room&a=add_comment&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                @"room_id":self.roomID,
                                @"content":feedbackContent,
                                };
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
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[dic objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        //取消第一响应者
        [self.keyboardView.txtInput resignFirstResponder];
        self.keyboardView.txtInput.text = @"";
        [self initListChatData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}



- (IBAction)button1Click:(UIButton *)sender {
    self.button1.selected = YES;
    self.line1.hidden = NO;
    self.button2.selected = NO;
    self.line2.hidden = YES;
    self.button3.selected = NO;
    self.line3.hidden = YES;
    self.button4.selected = NO;
    self.line4.hidden = YES;

    [self refreshTop:@"1"];

    if ([isKey isEqualToString:@"1"]) {
        self.scrollView.contentOffset = CGPointMake(-screen_Width, 0);
    }else{
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }

}

- (IBAction)button2Click:(UIButton *)sender {
    self.button1.selected = NO;
    self.line1.hidden = YES;
    self.button2.selected = YES;
    self.line2.hidden = NO;
    self.button3.selected = NO;
    self.line3.hidden = YES;
    self.button4.selected = NO;
    self.line4.hidden = YES;

    [self refreshTop:@"2"];

    if ([isKey isEqualToString:@"1"]) {
        self.scrollView.contentOffset = CGPointMake(-screen_Width, 0);
    }else{
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }

}

- (IBAction)button3Click:(UIButton *)sender {
    self.button1.selected = NO;
    self.line1.hidden = YES;
    self.button2.selected = NO;
    self.line2.hidden = YES;
    self.button3.selected = YES;
    self.line3.hidden = NO;
    self.button4.selected = NO;
    self.line4.hidden = YES;
    
    [self refreshTop:@"3"];

    if ([isKey isEqualToString:@"1"]) {
        self.scrollView.contentOffset = CGPointMake(-screen_Width, 0);
    }else{
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }
    
}

- (IBAction)button4Click:(UIButton *)sender {
    self.button1.selected = NO;
    self.line1.hidden = YES;
    self.button2.selected = NO;
    self.line2.hidden = YES;
    self.button3.selected = NO;
    self.line3.hidden = YES;
    self.button4.selected = YES;
    self.line4.hidden = NO;

//    [self refreshTop:@"4"];
    
    if ([isKey isEqualToString:@"1"]) {
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }else{
        self.scrollView.contentOffset = CGPointMake(screen_Width, 0);
    }
    
    [self.tableView2 reloadData];

    
}


-(void)refreshTop:(NSString *)Tag{
    _Tag = Tag;
    [_tableView reloadData];
}



@end
