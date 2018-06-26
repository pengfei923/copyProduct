//
//  SK_InfoViewController.m
//  AFM
//
//  Created by admin on 2017/9/22.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "SK_InfoViewController.h"
#import "Top_JCTableViewCell.h"
#import "SSDZTableViewCell.h"
#import "ZRXQTableViewCell.h"
#import "WJHDTableViewCell.h"
#import "CYWJTableViewCell.h"
#import "SK_InfoModel.h"
#import "PlayerInfoViewController.h"
#import "KeyboardView.h"
#import "DJ_PlayerViewController.h"

#define screen_Width [UIScreen mainScreen].bounds.size.width
#define screen_Height [UIScreen mainScreen].bounds.size.height

@interface SK_InfoViewController ()<UITableViewDelegate , UITableViewDataSource,UITextFieldDelegate,headDelegate>{
    NSString *isKey;
    NSInteger numPerPage;
    NSTimeInterval TIME;         //时间间隔
}

@property (nonatomic , strong) UITableView *tableView;          //列表视图
@property (nonatomic , strong) NSString *Tag;
@property (nonatomic , strong) SK_InfoModelCell *allmodel;
@property (nonatomic , strong) SK_InfoRoomData  *roomInfoModel;          //
@property (nonatomic , strong) KeyboardView  *keyboardView;          //
@property (nonatomic , strong) NSMutableArray  *chatData;          //
@property (nonatomic , strong) NSTimer *listTimer;        //定时器

@end

@implementation SK_InfoViewController
NSString *SK_TopView  = @"Top_JCTableViewCell";
NSString *SK_ZRXQcell = @"ZRXQTableViewCell";
NSString *SK_SSDZcell = @"SSDZTableViewCell";
NSString *SK_CYWJcell = @"CYWJTableViewCell";
NSString *SK_WJHDcell = @"WJHDTableViewCell";

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startTimer];
}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
    [self initData];
    [self addNoticeForKeyboard];

}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = self.name;
    
}


//初始化界面
- (void)initView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.mainWidth, self.mainHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;  // 滚动条
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线
    self.tableView.separatorColor = [UIColor getColorWithdown];

    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView registerClass:[Top_JCTableViewCell class] forCellReuseIdentifier:SK_TopView];
    [self.tableView registerClass:[ZRXQTableViewCell class] forCellReuseIdentifier:SK_ZRXQcell];
    [self.tableView registerClass:[SSDZTableViewCell class] forCellReuseIdentifier:SK_SSDZcell];
    [self.tableView registerClass:[CYWJTableViewCell class] forCellReuseIdentifier:SK_CYWJcell];
    [self.tableView registerClass:[WJHDTableViewCell class] forCellReuseIdentifier:SK_WJHDcell];
    
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;

    [self.view addSubview:self.tableView];
    

    
    //创建keyboardView
    self.keyboardView = [KeyboardView initKeyView];
    self.keyboardView.frame = CGRectMake(0, self.mainHeight-44 ,self.mainWidth,44 );
    [self.keyboardView.turn_Btn addTarget:self action:@selector(sendChatClick:) forControlEvents:UIControlEventTouchUpInside];
    self.keyboardView.txtInput.delegate = self;
    self.keyboardView.txtInput.tag = 2;
    self.keyboardView.txtInput.adjustsFontSizeToFitWidth = YES;  //文字滚动
    self.keyboardView.txtInput.returnKeyType = UIReturnKeySend;  //确认按钮
    self.keyboardView.hidden = YES;

    [self.view addSubview:self.keyboardView];

    self.Tag = @"1";
    ZFRefreshGifHeader *header = [ZFRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_header = header;
    
    ZFRefreshAutoNormalFooter *footer = [ZFRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer = footer;
}

- (void)loadNewData{
    if ([_Tag isEqualToString:@"4"]) {
        numPerPage = 1;
        [self initChatView];
    }
}

- (void)loadMoreData{
    if ([_Tag isEqualToString:@"4"]) {
        numPerPage ++;
        [self initChatView];
    }
}

//TOP按钮回调
-(void)refreshHead:(NSString *)Tag{
    _Tag = Tag;
    if ([Tag isEqualToString:@"4"]) {
        numPerPage = 1;
        [self.tableView.mj_header beginRefreshing];
        [self initChatView];
        self.keyboardView.hidden = NO;
        //将视图上移计算好的偏移
        [UIView animateWithDuration:0.3 animations:^{
            self.tableView.frame = CGRectMake(0, -175, screen_Width , screen_Height+76-12);
        }];

    }else{
        self.keyboardView.hidden = YES;
        [UIView animateWithDuration:0.3 animations:^{
            self.tableView.frame = CGRectMake(0, 0 ,self.tableView.frame.size.width, self.tableView.frame.size.height);
        }];
        [self.tableView reloadData];
    }
}

- (void)initData{
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=user&a=userroomdetail&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                @"id":self.guess_id,// (未开赛以及比赛中的guess_id)
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
        }

        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


//聊天界面
- (void)initChatView {
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
                self.chatData = [[NSMutableArray alloc] initWithArray:listModel.data];
                [self.tableView.mj_header endRefreshing];
            } else {
                [self.chatData addObjectsFromArray:listModel.data];
                [self.tableView.mj_footer endRefreshing];
                if (listModel.data.count == 0) {
                    numPerPage--;
                }
            }
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];

        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 列表代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 ) {
        return 1;
    }else{
        if ([_Tag isEqualToString:@"1"]) {
            return self.allmodel.lineup_player.count;
        }else if ([_Tag isEqualToString:@"2"]){
            return self.roomInfoModel.match_list.count;
        }else if ([_Tag isEqualToString:@"3"]){
            return self.roomInfoModel.join_user.count;
        }else{
            return self.chatData.count;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 215;
    }else{
        if ([_Tag isEqualToString:@"1"]) {
            return 90;
        }else if ([_Tag isEqualToString:@"2"]){
            return 100;
        }else if ([_Tag isEqualToString:@"3"]){
            return 55;
        }else{
            ChatModelCell *model = [self.chatData objectAtIndex:indexPath.row];
            NSString *cellStr = model.content;
            CGSize cellSize = [cellStr boundingRectWithSize:CGSizeMake(self.view.frame.size.width-20, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            //cellSize的高度为文字的真实高度，需要上下都留出空白
            return cellSize.height + 80;
        }
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
    if (indexPath.section == 0) {
        Top_JCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SK_TopView];
        //倒计时
        NSDate *senddate = [NSDate date];
        NSTimeInterval data1 = [senddate timeIntervalSince1970];
        TIME = self.roomInfoModel.match_start_time - data1;
        cell.time_Lab.text = [NSString stringWithFormat:@"%@",[self ConvertStrToTime:TIME]];


        [cell.button1 setTitle:@"阵容详情" forState:UIControlStateNormal];
        [cell.button1 setTitle:@"阵容详情" forState:UIControlStateSelected];
        [cell.button3 setTitle:@"参与玩家" forState:UIControlStateNormal];
        [cell.button3 setTitle:@"参与玩家" forState:UIControlStateSelected];
        [cell.button4 setTitle:@"玩家互动" forState:UIControlStateNormal];
        [cell.button4 setTitle:@"玩家互动" forState:UIControlStateSelected];
        cell.men_Lab.text = self.roomInfoModel.price;
        cell.jiang_Lab.text = self.roomInfoModel.reward_num;
        cell.zhu_Lab.text = [NSString stringWithFormat:@"%@/%@",self.roomInfoModel.now_guess_num,self.roomInfoModel.allow_guess_num];
        cell.gozhu_Lab.text = [NSString stringWithFormat:@"%@/%@",self.roomInfoModel.join_num,self.roomInfoModel.allow_uguess_num];
        
        if ([self.roomInfoModel.reward_id isEqualToString:@"1"]) {//门票
            cell.img_jiang.image = [UIImage imageNamed:@"ticket-white"];
        }else if ([self.roomInfoModel.reward_id isEqualToString:@"8"]){//木头
            cell.img_jiang.image = [UIImage imageNamed:@"wood-white"];
        }else{
        }
        if ([self.roomInfoModel.isnew_hand isEqualToString:@"1"]) {
            cell.biao_image1.image = [UIImage imageNamed:@"novice-icon"];
            if ([self.roomInfoModel.open_id isEqualToString:@"1"]) {
                cell.biao_image2.image = [UIImage imageNamed:@"open-icon"];
                if ([self.roomInfoModel.more_guess isEqualToString:@"1"]) {
                    cell.biao_image3.image = [UIImage imageNamed:@"more-icon"];
                }else{
                    cell.biao_image3.hidden = YES;
                }
            }else{
                if ([self.roomInfoModel.more_guess isEqualToString:@"1"]) {
                    cell.biao_image2.image = [UIImage imageNamed:@"more-icon"];
                }else{
                    cell.biao_image2.hidden = YES;
                    cell.biao_image3.hidden = YES;
                }
            }
        }
        cell.delegate = self;
        return cell;
    }else{
        if ([_Tag isEqualToString:@"1"]) {
            SK_InfoLineup_PlayerData *model = [self.allmodel.lineup_player objectAtIndex:indexPath.row];
            ZRXQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SK_ZRXQcell];
            [cell.Icon_Img yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@" "]];
            cell.PJ_Lab.text = [NSString stringWithFormat:@"平均分：%0.1f",model.average];
            cell.name_lab.text = model.name;
            cell.GZ_lab.text = [NSString stringWithFormat:@"$ %@",model.salary];
            if ([self.project_id isEqualToString:@"4"]) {          //nba
                cell.KDA_Lab.text = [NSString stringWithFormat:@"场均时间：%0.1f",model.play_time];
                if (model.match_data.team_id == model.match_data.team_a_id) {
                    cell.left_Lab.textColor = [UIColor blackColor];
                    [cell.left_Lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
                    cell.right_Lab.textColor = [UIColor darkGrayColor];
                }else{
                    cell.left_Lab.textColor = [UIColor darkGrayColor];
                    cell.right_Lab.textColor = [UIColor blackColor];
                    [cell.right_Lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
                }

                cell.left_Lab.text = [model.match_data.team_a_name objectForKey:@"short_name"];
                cell.right_Lab.text = [model.match_data.team_b_name objectForKey:@"short_name"];

  
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
                    cell.biao_Lab.text = @"替补";
                }else{
                    cell.biao_Lab.text = @"替补";
                }

            }else if ([self.project_id isEqualToString:@"5"]){      //lol
                cell.KDA_Lab.text = [NSString stringWithFormat:@"KDA：%0.1f",model.KDA];
                if (model.match_data.team_id == model.match_data.team_a_id) {
                    cell.left_Lab.textColor = [UIColor blackColor];
                    [cell.left_Lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
                    cell.right_Lab.textColor = [UIColor darkGrayColor];
                }else{
                    cell.left_Lab.textColor = [UIColor darkGrayColor];
                    cell.right_Lab.textColor = [UIColor blackColor];
                    [cell.right_Lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
                }
                
                cell.left_Lab.text = [model.match_data.team_a_name objectForKey:@"short_name"];
                cell.right_Lab.text = [model.match_data.team_b_name objectForKey:@"short_name"];

                if ([model.position isEqualToString:@"1"]) {
                    cell.biao_Lab.text = @"上单";
                }else if ([model.position isEqualToString:@"2"]){
                    cell.biao_Lab.text = @"打野";
                }else if ([model.position isEqualToString:@"3"]){
                    cell.biao_Lab.text = @"中单";
                }else if ([model.position isEqualToString:@"4"]){
                    cell.biao_Lab.text = @"ADC";
                }else if ([model.position isEqualToString:@"5"]){
                    cell.biao_Lab.text = @"辅助";
                }else if ([model.position isEqualToString:@"6"]){
                    cell.biao_Lab.text = @"战队";
                }else{
                    cell.biao_Lab.text = @"替补";
                }

            }else{
                cell.KDA_Lab.text = [NSString stringWithFormat:@"KDA：%0.1f",model.KDA];
                if (model.match_data.team_id == model.match_data.team_a_id) {
                    cell.left_Lab.textColor = [UIColor blackColor];
                    [cell.left_Lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
                    cell.right_Lab.textColor = [UIColor darkGrayColor];
                }else{
                    cell.left_Lab.textColor = [UIColor darkGrayColor];
                    cell.right_Lab.textColor = [UIColor blackColor];
                    [cell.right_Lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
                }
                
                cell.left_Lab.text = [model.match_data.team_a_name objectForKey:@"short_name"];
                cell.right_Lab.text = [model.match_data.team_b_name objectForKey:@"short_name"];

                if ([model.position isEqualToString:@"1"]) {
                    cell.biao_Lab.text = @"一号位";
                }else if ([model.position isEqualToString:@"2"]){
                    cell.biao_Lab.text = @"二号位";
                }else if ([model.position isEqualToString:@"3"]){
                    cell.biao_Lab.text = @"三号位";
                }else if ([model.position isEqualToString:@"4"]){
                    cell.biao_Lab.text = @"四号位";
                }else if ([model.position isEqualToString:@"5"]){
                    cell.biao_Lab.text = @"五号位";
                }else if ([model.position isEqualToString:@"6"]){
                    cell.biao_Lab.text = @"战队";
                }else{
                    cell.biao_Lab.text = @"替补";
                }
            }
            cell.icon_Btn.tag = indexPath.row;
            [cell.icon_Btn addTarget:self action:@selector(icon_BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }else if ([_Tag isEqualToString:@"2"]){
            SK_RoomInfoMatch_listData *model = [self.roomInfoModel.match_list objectAtIndex:indexPath.row];
            SSDZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SK_SSDZcell];
            cell.title_Lab.text = model.match_name;
            cell.time_lab.text = model.match_time_date;
            cell.left_Lab.text = model.name_a;
            cell.right_Lab.text = model.name_b;
            [cell.Left_Img yy_setImageWithURL:[NSURL URLWithString:model.img_a] placeholder:[UIImage imageNamed:@" "]];
            [cell.right_Img yy_setImageWithURL:[NSURL URLWithString:model.img_b] placeholder:[UIImage imageNamed:@" "]];
        
            return cell;
        }else if ([_Tag isEqualToString:@"3"]){
            SK_RoomInfoJoin_userData *usermodel = [self.self.roomInfoModel.join_user objectAtIndex:indexPath.row ];
            CYWJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SK_CYWJcell];
            cell.name_Lab.text = usermodel.username;
            cell.ch_Lab.text = usermodel.rank_name;
            cell.num_Lab.text = usermodel.guess_num;
            [cell.iconImgView yy_setImageWithURL:[NSURL URLWithString:usermodel.avatar_img] placeholder:[UIImage imageNamed:@" "]];
            [cell.ch_ImgView yy_setImageWithURL:[NSURL URLWithString:usermodel.rank_img] placeholder:[UIImage imageNamed:@" "]];

            return cell;
            
        }else{
           
            NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯一确定cell
            WJHDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            ChatModelCell *model = [self.chatData objectAtIndex:indexPath.row];
            if (cell == nil) {
                cell = [[WJHDTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SK_WJHDcell];
                cell.my_lab.text = model.content;
                if ([model.uid isEqualToString:self.appCache.loginViewModel.Id]) {//自己
                    cell.my_name.text = model.username;
                    cell.you_name.hidden = YES;
                    cell.you_img.hidden = YES;
                    cell.my_view.backgroundColor = [UIColor getColorWithR:160 G:210 B:100 A:1];
                    [cell.my_img yy_setImageWithURL:[NSURL URLWithString:model.avatar] placeholder:[UIImage imageNamed:@" "]];
                }else{           //别人
                    cell.you_name.text = model.username;
                    cell.my_name.hidden = YES;
                    cell.my_img.hidden = YES;
                    cell.my_view.backgroundColor = [UIColor whiteColor];
                    cell.my_view.layer.borderColor = [UIColor grayColor].CGColor;
                    cell.my_view.layer.borderWidth = 0.5;
                    [cell.you_img yy_setImageWithURL:[NSURL URLWithString:model.avatar] placeholder:[UIImage imageNamed:@" "]];
                }
            }
            return cell;
        }
    }
}


#pragma mark - 按钮点击
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
- (void)sendChatClick:(UIButton *)Btn{
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
//    isKey  = @"2";//
//    //计算出键盘顶端到inputTextView panel底端的距离
//    CGFloat offset = (self.keyboardView.frame.origin.y + self.keyboardView.frame.size.height) - (self.view.frame.size.height+44 );
//
//    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
//    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//
//    //将视图上移计算好的偏移
//    if(offset > 0) {
//        [UIView animateWithDuration:duration animations:^{
//
//            self.view.frame = CGRectMake(0, -offset, self.view.frame.size.width, self.view.frame.size.height);
//        }];
//    }
}
///键盘消失事件
- (void)keyboardWillHidden:(NSNotification *)notify {
//    isKey  = @"2";//
//
//    // 键盘动画时间
//    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//
//    //视图下沉恢复原状
//    [UIView animateWithDuration:duration animations:^{
//        self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
//
//    }];
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
//发送消息--请求
- (void)initAddData:(NSString *)feedbackContent{
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=room&a=add_comment&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                @"room_id":self.roomID,
                                @"content":feedbackContent };
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
            [self.tableView.mj_footer beginRefreshing];

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
        [self initChatView];
        [self.tableView.mj_footer endRefreshing];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}



#pragma mark - 定时器
//定时器开始
- (void)startTimer{
    if (self.listTimer == nil) {
        self.listTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
        
    }
}
//定时器结束
- (void)stopTimer {
    if (self.listTimer) {
        [self.listTimer invalidate];//定时器无效
        self.listTimer = nil;
    }
}
//定时器方法
- (void)onTimer:(NSTimer *)timer {
    //获取现在时间
    NSDate *senddate = [NSDate date];
    NSInteger data1 = [senddate timeIntervalSince1970];
    //时间差
    TIME = self.roomInfoModel.match_start_time - data1;
    [self.tableView reloadData];
    
}
//定时器计算 时/分/秒
- (NSString *)ConvertStrToTime:(NSInteger )timeStr{
    //重新计算 时/分/秒
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",timeStr/3600];
    
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(timeStr%3600)/60];
    
    NSString *str_second = [NSString stringWithFormat:@"%02ld",timeStr%60];
    
    NSString *timeString = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    return timeString;
}

@end
