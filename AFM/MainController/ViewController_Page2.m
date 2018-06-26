//
//  ViewController_Page2.m
//  CarServiceO2O
//
//  Created by 华四MAC on 16/7/18.
//  Copyright © 2016年 华四MAC. All rights reserved.
//

#import "ViewController_Page2.h"
#import "SK_TopView.h"
#import "SK_EndTableViewCell.h"
#import "SK_InfoViewController.h"
#import "SK_Ing_EdInfoViewController.h"
#import "NoS_ZRTableViewCell.h"
#import "No_ZRinfoTableViewCell.h"
#import "WNo_ZRinfoTableViewCell.h"
#import "TJZR_BackView.h"
#import "TakeRewardView.h"

#import "WSTableviewTree.h"
#import "DJ1_ChooseViewController.h"


@interface ViewController_Page2 ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate, WSTableViewDelegate, TopDelegate >{
    UIButton *YJ_btn;        //悬浮视图 -- 一键领奖功能
    NSInteger numPerPage;    //页数
    NSString *ROOM_id;

}
@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , strong) WSTableView *tableView1;          //tableView1
@property (nonatomic , strong) WSTableView *tableView2;          //tableView2
@property (nonatomic , strong) UITableView *tableView3;          //tableView3


@property (nonatomic , strong) SK_TopView *topView;             //顶部视图
@property (nonatomic , strong) TJZR_BackView *backRView;         //加注弹框
@property (nonatomic , strong) TakeRewardView *takeRview;        //领奖弹框

@property (nonatomic , strong) NSString *Top;
@property (nonatomic , strong) NSMutableArray *dataArray;
@property (nonatomic , strong) NSMutableArray *dataArray2;
@property (nonatomic , strong) NSMutableArray *cellData;
@property (nonatomic , strong) NSMutableArray *cellData2;
@property (nonatomic , strong) WSTableviewDataModel *WTSdata;
@property (nonatomic , strong) NSMutableArray *listData;          //已结束的数组3

@property (nonatomic , strong) NSMutableArray *TIME_listData;             //排序后的Player_listData
@property (nonatomic , strong) NSArray *paixuArray;                       //时间排序。用于secsion
@property (nonatomic , strong) Home2_ENDRoom_ListModelCell *EndModel;

@end


@implementation ViewController_Page2

NSString *NO_cellad     = @"NoS_ZRTableViewCell";
NSString *NOinfo_cellad = @"No_ZRinfoTableViewCell";
NSString *WNOinfo_cellad = @"WNo_ZRinfoTableViewCell";
NSString *SKEnd_cellad  = @"SK_EndTableViewCell";

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //返回-偏移量
    self.scrollView.contentOffset = CGPointMake(self.mainWidth*([_Top intValue] -1), 0);

}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
    [self initData];

}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"赛况";
}

//头视图协议
-(void)refreshSK_TOP:(NSString *)Tag{
    _Top = Tag;
    if ([Tag isEqualToString:@"3"]) {
        YJ_btn.hidden = NO;
    }else{
        YJ_btn.hidden = YES;
    }
    [self initData];
}


//初始化界面
- (void)initView {
    UIView *top_View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, 40)];
    [self.view addSubview:top_View];
    
    self.topView = [[SK_TopView alloc] init];
    self.topView.frame = CGRectMake(0,  0, screen_Width, 40);
    self.topView.delegate = self;
    self.Top = @"1";
    [top_View addSubview:self.topView];
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, screen_Width *3, screen_Height-40 -64)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];

    
    self.tableView1 = [[WSTableView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height -40-64-44) style:UITableViewStylePlain];
    self.tableView1.tag = 1;
    self.tableView1.WSTableViewDelegate = self;
    self.tableView1.showsVerticalScrollIndicator = NO;
    self.tableView1.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView1.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView1 registerClass:[NoS_ZRTableViewCell class] forCellReuseIdentifier:NO_cellad];
    [self.tableView1 registerClass:[WNo_ZRinfoTableViewCell class] forCellReuseIdentifier:WNOinfo_cellad];
    [self.tableView1 registerClass:[No_ZRinfoTableViewCell class] forCellReuseIdentifier:NOinfo_cellad];
    
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView1.estimatedRowHeight = 0;
    self.tableView1.estimatedSectionHeaderHeight = 0;
    self.tableView1.estimatedSectionFooterHeight = 0;
    [self.scrollView addSubview:self.tableView1];
    
    //下拉刷新
    ZFRefreshGifHeader *header = [ZFRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView1.mj_header = header;
    //上拉刷新
    ZFRefreshAutoNormalFooter *footer = [ZFRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView1.mj_footer = footer;

    
    
    self.tableView2 = [[WSTableView alloc] initWithFrame:CGRectMake(screen_Width, 0, screen_Width, screen_Height -40-64-44) style:UITableViewStylePlain];
    self.tableView2.tag = 2;
    self.tableView2.WSTableViewDelegate = self;
    self.tableView2.showsVerticalScrollIndicator = NO;
    self.tableView2.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView2.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView2 registerClass:[NoS_ZRTableViewCell class] forCellReuseIdentifier:NO_cellad];
    [self.tableView2 registerClass:[No_ZRinfoTableViewCell class] forCellReuseIdentifier:NOinfo_cellad];
    
    [self.scrollView addSubview:self.tableView2];
    
    
    self.tableView3 = [[UITableView alloc] initWithFrame:CGRectMake(screen_Width*2, 0, screen_Width, screen_Height -40-64-44) style:UITableViewStylePlain];
    self.tableView3.tag = 3;
    self.tableView3.delegate = self;
    self.tableView3.dataSource = self;
    self.tableView3.showsVerticalScrollIndicator = NO;
    self.tableView3.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView3.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView3 registerClass:[SK_EndTableViewCell class] forCellReuseIdentifier:SKEnd_cellad];
    
    [self.scrollView addSubview:self.tableView3];

//一键领取
    YJ_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    YJ_btn.frame = CGRectMake(screen_Width-60, screen_Height-60-64-50, 60, 60);
    YJ_btn.hidden = YES;
    [YJ_btn setImage:[UIImage imageNamed:@"keybtn"] forState:UIControlStateNormal];
    [YJ_btn addTarget:self action:@selector(YJLJ_BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:YJ_btn ];

}

//初始化数据
- (void)initData {
    self.dataArray   = [[NSMutableArray alloc] init];
    self.dataArray2  = [[NSMutableArray alloc] init];
    self.listData    = [[NSMutableArray alloc] init];
    self.cellData    = [[NSMutableArray alloc] init];
   
    if ([_Top isEqualToString:@"1"]) {
//        [self initListData];
        [self.tableView1.mj_header beginRefreshing];

    }else{
        [self initListData];
    }
}

//下拉刷新数据
- (void)loadNewData{
    numPerPage = 1;
    [self initListData];
//    [self.tableView1.mj_header endRefreshing];
}

//上拉加载数据
- (void)loadMoreData {
    numPerPage ++;
    [self initListData];
//    [self.tableView1.mj_footer endRefreshing];
}



//获取用户的 赛况列表
- (void)initListData{
    if ([_Top isEqualToString:@"3"]) {
        self.scrollView.contentOffset = CGPointMake(self.mainWidth*([_Top intValue] -1), 0);
        NSString *urlStr = @"http://api.aifamu.com/index.php?m=user&a=finishbet&apptype=app&version=1";
        NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token };
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
                Home2_ENDListModel *listModel = [Home2_ENDListModel yy_modelWithDictionary:dic];
                self.listData = [[NSMutableArray alloc]initWithArray:listModel.data];
                
                //时间排序
                NSArray *TIME_GD = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];
                NSMutableArray *TIMEGD = [[NSMutableArray alloc] initWithArray:[listModel.data sortedArrayUsingDescriptors:TIME_GD]];
                
                self.TIME_listData  = [[NSMutableArray alloc] init];
                self.TIME_listData = TIMEGD;
                
                NSMutableArray *AAAA = [[NSMutableArray alloc] init];
                //遍历所有的日期
                for (Home2_ENDListModelCell *model in  self.TIME_listData) {
                    [AAAA addObject:model.date];
                }
                //对所有的日期去重
                NSSet *set = [NSSet setWithArray:AAAA];
                //去重后重新排序
                self.paixuArray = [[NSArray alloc] init];
                NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:nil ascending:NO]];
                self.paixuArray = [set sortedArrayUsingDescriptors:sortDesc];

                for (Home2_ENDListModelCell *model in self.TIME_listData) {
                    if (model.date == self.paixuArray[0]) {
                    }
                }
            }
            [self.tableView3 reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
        
    }else if ([_Top isEqualToString:@"2"]){
        self.scrollView.contentOffset = CGPointMake(self.mainWidth*([_Top intValue] -1), 0);
        NSString *urlStr = @"http://api.aifamu.com/index.php?m=user&a=userbetmatching&apptype=app&version=1";
        NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token};
        AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
        [manager setSecurityPolicy:[AFMHTTPSManager customSecurityPolicy]];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST: urlStr parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
            if ([[dic objectForKey:@"error"]isEqualToNumber:@0]) {
                SK_WeiModel *listModel = [SK_WeiModel yy_modelWithDictionary:dic];
                self.cellData2 = [[NSMutableArray alloc]initWithArray:listModel.data];
                //cell
                WSTableviewDataModel *Model = [[WSTableviewDataModel alloc] init];
                Model.expandable = YES;
                [Model object_add_toSecondLevelArrM:self.cellData2];
                //子cell
                for (SK_WeiModelCell *cellmodel in listModel.data) {
                    WSTableviewDataModel *dataModel = [[WSTableviewDataModel alloc] init];
                    dataModel.firstLevelStr = @"子cell";
                    dataModel.shouldExpandSubRows = YES;
                    dataModel.expandable = YES;
                    [self.dataArray2 addObject:dataModel];
                    for (SK_Wei_RoomInfoData *skmodelcell in cellmodel.room_info) {
                        [dataModel object_add_toSecondLevelArrM:skmodelcell];
                    }
                }
            }
            [self.tableView2 reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }else{                //未开赛
        self.scrollView.contentOffset = CGPointMake(self.mainWidth*([_Top intValue] -1), 0);
        NSString *urlStr = @"http://api.aifamu.com/index.php?m=user&a=userbetmatch&apptype=app&version=1";
        NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                 @"page":[NSString stringWithFormat:@"%ld",(long)numPerPage]};
        AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
        [manager setSecurityPolicy:[AFMHTTPSManager customSecurityPolicy]];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST: urlStr parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
            __weak typeof(self) weakSelf = self;
            if ([[dic objectForKey:@"error"]isEqualToNumber:@0]) {
                SK_WeiModel *listModel = [SK_WeiModel yy_modelWithDictionary:dic];
                if (numPerPage == 1) {
                    weakSelf.cellData = [[NSMutableArray alloc]initWithArray:listModel.data];
                    //cell
                    WSTableviewDataModel *Model = [[WSTableviewDataModel alloc] init];
                    Model.expandable = YES;
                    [Model object_add_toSecondLevelArrM:self.cellData];
                    //子cell
                    self.dataArray = [[NSMutableArray alloc] init];
                    for (SK_WeiModelCell *cellmodel in listModel.data) {
                        WSTableviewDataModel *dataModel = [[WSTableviewDataModel alloc] init];
                        dataModel.firstLevelStr = @"子cell";
                        dataModel.shouldExpandSubRows = YES;
                        dataModel.expandable = YES;
                        [self.dataArray addObject:dataModel];
                        for (SK_Wei_RoomInfoData *skmodelcell in cellmodel.room_info) {
                            [dataModel object_add_toSecondLevelArrM:skmodelcell];
                        }
                    }
                    [self.tableView1.mj_header endRefreshing];
                }else {
                    if (listModel.data.count == 0) {
                        numPerPage --;
                        [AppDelegate notificationRequestSuccessWithStatus:@"数据已全部加载"];
                    }else{
//                        [weakSelf.cellData addObjectsFromArray:listModel.data];
                        weakSelf.cellData = [[NSMutableArray alloc]initWithArray:listModel.data];

                        //cell
                        WSTableviewDataModel *Model = [[WSTableviewDataModel alloc] init];
//                        NSLog(@"%lu",(unsigned long)listModel.data.count);  //----2             ++++weakSelf.cellData  ==12
                        Model.expandable = YES;
                        [Model object_add_toSecondLevelArrM:self.cellData];
                        //子cell
                        self.dataArray = [[NSMutableArray alloc] init];//=-====-=--=-=-=--==-=-=-=-=--=-=-=
                        
                        for (SK_WeiModelCell *cellmodel in listModel.data) {
                            WSTableviewDataModel *dataModel = [[WSTableviewDataModel alloc] init];
                            dataModel.firstLevelStr = @"子cell";
                            dataModel.shouldExpandSubRows = YES;
                            dataModel.expandable = YES;
                            [self.dataArray addObject:dataModel];
                            for (SK_Wei_RoomInfoData *skmodelcell in cellmodel.room_info) {
                                [dataModel object_add_toSecondLevelArrM:skmodelcell];
                            }
                        }
                    }
                    [self.tableView1.mj_header endRefreshing];
                    [self.tableView1.mj_footer endRefreshing];
                }
            }
            [self.tableView1 reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }
}


#pragma mark - 列表代理
//头试图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (tableView.tag == 3)? 30 :10.0f;
}
//  自定义分区头的view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 3){
        static NSString * identy = @"head";
        UITableViewHeaderFooterView * hf = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identy];
        if (!hf) {
            hf = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:identy];
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width,30)];
            view.backgroundColor = [UIColor getColorWithdown];
            
            UIImageView *Img = [[UIImageView alloc] initWithFrame:CGRectMake(12, 11, 5, 14)];
            Img.image = [UIImage imageNamed:@"borline"];
            UILabel *title_L = [[UILabel alloc] initWithFrame:CGRectMake(20, 8, 200, 20)];
            title_L.font = [UIFont systemFontOfSize:12];
            [view addSubview:Img];
            [view addSubview:title_L];
            [hf addSubview:view];
        }
        return hf;
    }else{
        return nil;
    }
}
//section个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 1){
        return self.dataArray.count;
    }else if(tableView.tag == 2){
        return self.dataArray2.count;
    }else{
        return self.TIME_listData.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (tableView.tag == 3)? 1: 1;
}

- (NSInteger)tableView:(WSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 1){
        WSTableviewDataModel *dataModel = self.dataArray[indexPath.section];
        return [dataModel.secondLevelArrM count];
    }else {
        WSTableviewDataModel *dataModel = self.dataArray2[indexPath.section];
        return [dataModel.secondLevelArrM count];
    }

}

- (BOOL)tableView:(WSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 1){
        WSTableviewDataModel *dataModel = self.dataArray[indexPath.section];
        return dataModel.shouldExpandSubRows;
    }else{
        WSTableviewDataModel *dataModel = self.dataArray2[indexPath.section];
        return dataModel.shouldExpandSubRows;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 1){
        NSString *CellIdenti = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
        NoS_ZRTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdenti];
        WSTableviewDataModel *dataModel = self.dataArray[indexPath.section];
        SK_WeiModelCell *model = [self.cellData objectAtIndex:indexPath.section];
        if (cell == nil) {
           cell = [[NoS_ZRTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NO_cellad];
            cell.zr_Lab.text = [NSString stringWithFormat:@"阵容%ld",(long)indexPath.section + 1];
            cell.PJ_Lab.text = [NSString stringWithFormat:@"%0.1f",model.lineup_score];
            cell.CYRoom_lab.text = [NSString stringWithFormat:@"已参与房间数：%@",model.join_room_num];
            cell.Player = model;
            cell.controller = self;
            cell.expandable = dataModel.expandable;
            cell.C_Button.tag = indexPath.section;
            [cell.C_Button addTarget:self action:@selector(ChooseZRClick:) forControlEvents:UIControlEventTouchUpInside];
        }
     
        return cell;
    }else if(tableView.tag == 2){
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯一确定cell
        NoS_ZRTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        WSTableviewDataModel *dataModel = self.dataArray2[indexPath.section];
        SK_WeiModelCell *model = [self.cellData2 objectAtIndex:indexPath.section];

        if (cell == nil) {
            cell = [[NoS_ZRTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NO_cellad];
            cell.zr_Lab.text = [NSString stringWithFormat:@"阵容%ld",(long)indexPath.section + 1];
            cell.PJ_Lab.text = [NSString stringWithFormat:@"%0.1f",model.lineup_score];
            cell.CYRoom_lab.text = [NSString stringWithFormat:@"已参与房间数：%@",model.join_room_num];
            cell.Player = model;
            cell.controller = self;
            cell.fenshuType = @"dq";
            cell.expandable = dataModel.expandable;

        }
       
        return cell;
    }else{
        SK_EndTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SKEnd_cellad];
        Home2_ENDListModelCell *model = [self.TIME_listData objectAtIndex:indexPath.section];
        cell.Model = model;
        cell.turnBtn.tag = indexPath.section;

        [cell.turnBtn addTarget:self action:@selector(turn_BtnClick:) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 1){
        WSTableviewDataModel *dataModel = self.dataArray[indexPath.section];
        self.WTSdata = dataModel;
        WNo_ZRinfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WNo_ZRinfoTableViewCell class])];
        SK_Wei_RoomInfoData *skmodelcell = [dataModel object_get_fromSecondLevelArrMWithIndex:indexPath.subRow];
        cell.name_Lab.text = skmodelcell.name;
        [cell.icon_Img yy_setImageWithURL:[NSURL URLWithString:skmodelcell.type_img] placeholder:[UIImage imageNamed:@"player-photo"]];
        cell.menp_Lab.text = skmodelcell.price;
        cell.JL_Lab.text = skmodelcell.reward_num;
        cell.Znum_Lab.text = [NSString stringWithFormat:@"%@/%@",skmodelcell.now_guess_num,skmodelcell.allow_guess_num];
        cell.addZ_Lab.text = [NSString stringWithFormat:@"%@/%@",skmodelcell.join_num,skmodelcell.allow_uguess_num];
        
        if ([skmodelcell.join_num intValue] == [skmodelcell.allow_uguess_num intValue]) {
            cell.add_Lable.text = @"已满";
            cell.add_Lable.backgroundColor = [UIColor grayColor];
            cell.addZ_View.layer.borderWidth = 0.5;
            cell.addZ_View.layer.borderColor = [[UIColor grayColor] CGColor];
        }else{
            cell.add_Lable.text = @"继续参加";
            cell.add_Lable.backgroundColor = [UIColor orangeColor];
            cell.addZ_View.layer.borderWidth = 0.5;
            cell.addZ_View.layer.borderColor = [[UIColor orangeColor] CGColor];
        }
        
        cell.time_Lab.text = skmodelcell.match_start_date;
        cell.add_Btn.tag = indexPath.subRow;
        ROOM_id =  skmodelcell.Id;

        [cell.add_Btn addTarget:self action:@selector(AddBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //标签
        if ([skmodelcell.isnew_hand isEqualToString:@"1"]) {
            cell.biao_image1.image = [UIImage imageNamed:@"novice-icon"];
            
            if ([skmodelcell.open_id isEqualToString:@"1"]) {
                cell.biao_image2.image = [UIImage imageNamed:@"open-icon"];
                if ([skmodelcell.more_guess isEqualToString:@"1"]) {
                    cell.biao_image3.image = [UIImage imageNamed:@"more-icon"];
                }else{
                    cell.biao_image3.hidden = YES;
                }
            }else{
                if ([skmodelcell.more_guess isEqualToString:@"1"]) {
                    cell.biao_image2.image = [UIImage imageNamed:@"more-icon"];
                }else{
                    cell.biao_image2.hidden = YES;
                    cell.biao_image3.hidden = YES;
                }
            }
        }else{
            if ([skmodelcell.open_id isEqualToString:@"1"]) {//必开
                cell.biao_image1.image = [UIImage imageNamed:@"open-icon"];
                if ([skmodelcell.more_guess isEqualToString:@"1"]) {   //多注
                    cell.biao_image2.image = [UIImage imageNamed:@"more-icon"];
                    cell.biao_image3.hidden = YES;
                }else{
                    cell.biao_image2.hidden = YES;
                    cell.biao_image3.hidden = YES;
                }
            }else{
                if ([skmodelcell.more_guess isEqualToString:@"1"]) {   //多注
                    cell.biao_image1.image = [UIImage imageNamed:@"more-icon"];
                    cell.biao_image2.hidden = YES;
                    cell.biao_image3.hidden = YES;
                }else{
                    cell.biao_image2.hidden = YES;
                    cell.biao_image3.hidden = YES;
                }
            }
        }
        return cell;
    }else if(tableView.tag == 2){
        WSTableviewDataModel *dataModel = self.dataArray2[indexPath.section];
        self.WTSdata = dataModel;
        
        NSString *cellId = [NSString stringWithFormat:@"cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
        No_ZRinfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//        No_ZRinfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([No_ZRinfoTableViewCell class])];
        SK_Wei_RoomInfoData *skmodelcell = [dataModel object_get_fromSecondLevelArrMWithIndex:indexPath.subRow];

        if (cell == nil) {
            cell = [[No_ZRinfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([No_ZRinfoTableViewCell class])];
            
            cell.name_Lab.text = skmodelcell.name;
            [cell.icon_Img yy_setImageWithURL:[NSURL URLWithString:skmodelcell.type_img] placeholder:[UIImage imageNamed:@""]];
            cell.JL_Lab.text = skmodelcell.open_num;
            cell.Znum_Lab.text = [NSString stringWithFormat:@"%@/%@",skmodelcell.join_num,skmodelcell.allow_uguess_num];
            cell.DQPM_Lab.text = [NSString stringWithFormat:@"%@/%@",skmodelcell.player_ranking,skmodelcell.now_guess_num];
            [cell.myIcon_Img yy_setImageWithURL:[NSURL URLWithString:self.appCache.loginViewModel.avatar_img] placeholder:[UIImage imageNamed:@""]];
            
            cell.my_Lab.text   = skmodelcell.my_score;
            cell.jiang_lab.text = skmodelcell.door_socre; // 房间先线
            cell.mostJ_lab.text = skmodelcell.max_socre;  //第一

            if ([skmodelcell.my_score isEqualToString:@"0"]) {
                if (screen_Width == 320) { //5s
                    cell.jindu_Constraint.constant = 120;
                }else if (screen_Width == 375){ //6
                    cell.jindu_Constraint.constant = 150;
                }else if (screen_Width == 414){
                    cell.jindu_Constraint.constant = 165;
                }else{
                }
            }else if ([skmodelcell.my_score integerValue] == [skmodelcell.max_socre integerValue]){  //第一名
                if (screen_Width == 320) { //5s
                    cell.jindu_Constraint.constant = 120;
                }else if (screen_Width == 375){ //6
                    cell.jindu_Constraint.constant = 140;
                }else if (screen_Width == 414){
                    cell.jindu_Constraint.constant = 160;
                }else{
                }
            }else if ([skmodelcell.my_score integerValue] == [skmodelcell.door_socre integerValue]){  //过线
                if (screen_Width == 320) { //5s
                    cell.jindu_Constraint.constant = 60;
                }else if (screen_Width == 375){ //6
                    cell.jindu_Constraint.constant = 80;
                }else if (screen_Width == 414){
                    cell.jindu_Constraint.constant = 100;
                }else{
                }
            }else if (([skmodelcell.my_score integerValue]  <  [skmodelcell.max_socre integerValue]) && ([skmodelcell.my_score integerValue]  >  [skmodelcell.door_socre integerValue])){  //过线区间
                if (screen_Width == 320) { //5s
                    cell.jindu_Constraint.constant = 80;
                }else if (screen_Width == 375){ //6
                    cell.jindu_Constraint.constant = 100;
                }else if (screen_Width == 414){
                    cell.jindu_Constraint.constant = 120;
                }else{
                }
            }else{  //   0---过线
                float T_Fen = ([skmodelcell.my_score floatValue] / [skmodelcell.door_socre floatValue] *100);
                if (screen_Width == 320) { //5s
                    cell.jindu_Constraint.constant = T_Fen - 50;
                }else if (screen_Width == 375){ //6
                    cell.jindu_Constraint.constant = T_Fen - 60;
                }else if (screen_Width == 414){
                    cell.jindu_Constraint.constant = T_Fen - 70;
                }else{
                }
            }
            
        }

        
        return cell;
    }else{
        return nil;
    }

    
}

- (CGFloat)tableView:(WSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 154;
}

- (CGFloat)tableView:(WSTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 1){
        WSTableviewDataModel *dataModel = _dataArray[indexPath.section];
        if (indexPath.subRow < dataModel.secondLevelArrM.count) {
            return 150;
        } else {
            return 150;
        }
    }else {
        WSTableviewDataModel *dataModel = _dataArray2[indexPath.section];
        if (indexPath.subRow < dataModel.secondLevelArrM.count) {
            return 150;
        } else {
            return 150;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 1){
        WSTableviewDataModel *dataModel = _dataArray[indexPath.section];
        dataModel.shouldExpandSubRows = !dataModel.shouldExpandSubRows;
    }else if(tableView.tag == 2){
        WSTableviewDataModel *dataModel = _dataArray2[indexPath.section];
        dataModel.shouldExpandSubRows = !dataModel.shouldExpandSubRows;
    }else{
        Home2_ENDListModelCell *model = [self.TIME_listData objectAtIndex:indexPath.section];
        SK_Ing_EdInfoViewController *Info3VC = [[SK_Ing_EdInfoViewController alloc] init];
        Info3VC.ID = model.Id;
        Info3VC.roomID = model.room_id;
        Info3VC.myPM = model.ranking;
        Info3VC.ZHUnum = model.room_info.join_num;      //自己投注数
        Info3VC.zPM = model.room_info.now_guess_num;    //总注数
        Info3VC.ronmName = model.room_info.name;
        Info3VC.IMG = model.ranking;
        Info3VC.GJ_num = model.ranking;
        Info3VC.my_num = model.ranking;
        Info3VC.HJ_num = model.ranking;

        Info3VC.project_id = model.project_id;
        [Info3VC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:Info3VC animated:YES];
        
    }

}

- (void)tableView:(WSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 1){
        WSTableviewDataModel *dataModel = self.dataArray[indexPath.section];
        SK_Wei_RoomInfoData *model = [dataModel object_get_fromSecondLevelArrMWithIndex:indexPath.subRow];
        SK_InfoViewController *Info1VC = [[SK_InfoViewController alloc] init];
        Info1VC.roomID = model.Id;
        Info1VC.guess_id = model.guess_id;
        Info1VC.project_id = model.project_id;
        Info1VC.name = model.name;

        [Info1VC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:Info1VC animated:YES];
    }else if(tableView.tag == 2){
        SK_Ing_EdInfoViewController *Info3VC = [[SK_Ing_EdInfoViewController alloc] init];
        WSTableviewDataModel *dataModel = self.dataArray2[indexPath.section];
        SK_Wei_RoomInfoData *model = [dataModel object_get_fromSecondLevelArrMWithIndex:indexPath.subRow];
        Info3VC.ID = model.guess_id;
        Info3VC.roomID = model.Id;
        Info3VC.myPM = model.player_ranking;
        Info3VC.zPM = model.now_guess_num;
        Info3VC.ZHUnum = model.join_num;//已投注数
        Info3VC.ronmName = model.name;
        Info3VC.project_id = model.project_id;
        [Info3VC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:Info3VC animated:YES];
 
    }else{}

}

//选择阵容
- (void)ChooseZRClick:(UIButton *)Btn {
    //    SK_WeiModelCell *model = [self.cellData objectAtIndex:Btn.tag];
    //
    //    NSLog(@"%@",[model yy_modelDescription]);
    //    if ([model.project_id isEqualToString:@"5"]) { //LOL
    //        DJ1_ChooseViewController *lolVC = [[DJ1_ChooseViewController alloc] init];
    //        lolVC.ZR_Type = @"lol";
    //        lolVC.ZR_dic = model.lineup_info;
    //        lolVC.Id = ROOM_id;
    //        for (SK_Wei_PlayerInfoData *Model in model.player_lineup_info) {
    //            NSMutableArray *GZ_arr = [[NSMutableArray alloc] init];
    //            NSMutableArray *PJ_arr = [[NSMutableArray alloc] init];
    //            [GZ_arr addObject:Model.salary];
    //            [PJ_arr addObject:[NSString stringWithFormat:@"%0.1f",Model.average]];
    //        }
    //
    //        lolVC.PJ_ = [NSString stringWithFormat:@"%0.1f",model.lineup_score];
    //        lolVC.GZ_ = [NSString stringWithFormat:@"%0.f",model.lineup_score];
    //
    ////        lolVC.allow_uguess_num = self.allow_uguess_num;
    ////        lolVC.join_num = self.join_num;
    ////        lolVC.name = self.name;
    ////        lolVC.iconImg = self.iconImg;
    ////        lolVC.now_guess_num = self.allmodel.now_guess_num;
    ////        lolVC.allow_guess_num = self.allmodel.allow_guess_num;
    ////        lolVC.TIME_mast = TIME;
    ////        lolVC.type = self.lol_dota_nba;
    ////        lolVC.allGZ = self.GZall;
    //
    //        [lolVC setHidesBottomBarWhenPushed:YES];
    //        [self.navigationController pushViewController:lolVC animated:YES];
    //
    //
    //    }else if ([model.project_id isEqualToString:@"6"]){  //DOTA2
    //
    //
    //    }else if ([model.project_id isEqualToString:@"4"]){  //NBA
    //     //5人----8人
    //
    //
    //    }else{}
    //
    
}

//加注按钮
- (void)AddBtnClick:(UIButton *)Btn {
    SK_Wei_RoomInfoData *skmodel = [self.WTSdata object_get_fromSecondLevelArrMWithIndex:Btn.tag];
    if (skmodel.allow_uguess_num == skmodel.join_num) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"message:@"参与人数已满" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        self.
        self.backRView = [TJZR_BackView cloosePayView];
        self.backRView.frame = CGRectMake(0, 0, screen_Width, screen_Height);
        self.backRView.DQYY_Lab.text = self.appCache.loginViewModel.entrance_ticket;
        self.backRView.JCDJ_Lab.text = skmodel.price;
        self.backRView.FJ_Lab.text = [NSString stringWithFormat:@"%@/%@",skmodel.now_guess_num,skmodel.allow_guess_num];
        self.backRView.zong_lab.text = skmodel.price;
        NSString *SY_num = [NSString stringWithFormat:@"%.f",[skmodel.allow_uguess_num floatValue] - [skmodel.join_num floatValue]];
        self.backRView.MaxNum = [SY_num intValue];
        self.backRView.maxNum_Lab.text = [NSString stringWithFormat:@"/ %@",SY_num];
        
        self.backRView.controller = self;
        //当前顶层窗口
        UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
        //添加到窗口
        [window addSubview:self.backRView];
    }
}


//领取奖励
- (void)turn_BtnClick:(UIButton *)Btn{
    Home2_ENDListModelCell *model = [self.TIME_listData objectAtIndex:Btn.tag];
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=award&a=get_reward&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                @"id":model.get_reward_id };
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
            NSDictionary *Dic = [dic objectForKey:@"data"];

            self.takeRview = [TakeRewardView turnTRView];
            self.takeRview.frame = CGRectMake(0, 0, screen_Width, screen_Height);
            self.takeRview.YJ_View.hidden = YES;
            self.takeRview.MP_Lab.text = [NSString stringWithFormat:@"%@",[Dic objectForKey:@"nums"]];
            [self.takeRview.esc_Btn addTarget:self action:@selector(ReloadClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.takeRview.turn_Btn addTarget:self action:@selector(ReloadClick:) forControlEvents:UIControlEventTouchUpInside];
            if ([[Dic objectForKey:@"type"] isEqualToString:@"2"]) {//2 木头 1 门票 4实物
                self.takeRview.type_Lab.text = @"木头";
                self.takeRview.type_Img.image = [UIImage imageNamed:@"wood-black"];
            }else if ([[Dic objectForKey:@"type"] isEqualToString:@"1"]){
                self.takeRview.type_Lab.text = @"门票";
                self.takeRview.type_Img.image = [UIImage imageNamed:@"ticket-black"];
            }else{
                self.takeRview.type_Lab.hidden = YES;
                self.takeRview.type_Img.hidden = YES;
                self.takeRview.MP_Lab.hidden = YES;
            }
            //当前顶层窗口
            UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
            //添加到窗口
            [window addSubview:self.takeRview];
        }else{
            [SVProgressHUD showInfoWithStatus:[dic objectForKey:@"msg"]];
        }
             [self.tableView3 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


//一键领取
- (void)YJLJ_BtnClick:(UIButton *)Btn{
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=award&a=get_reward_all&version=2";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
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
            NSDictionary *Dic = [dic objectForKey:@"data"];
            
            self.takeRview = [TakeRewardView turnTRView];
            self.takeRview.frame = CGRectMake(0, 0, screen_Width, screen_Height);
            self.takeRview.num_View.hidden = YES;
            self.takeRview.Y_mpLab.text = [NSString stringWithFormat:@"%@",[Dic objectForKey:@"entrance_ticket"]];
            self.takeRview.Y_mtLab.text = [NSString stringWithFormat:@"%@",[Dic objectForKey:@"gold"]];
            [self.takeRview.esc_Btn addTarget:self action:@selector(ReloadClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.takeRview.turn_Btn addTarget:self action:@selector(ReloadClick:) forControlEvents:UIControlEventTouchUpInside];

            //当前顶层窗口
            UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
            //添加到窗口
            [window addSubview:self.takeRview];
        }else{
            [SVProgressHUD showInfoWithStatus:[dic objectForKey:@"msg"]];
        }
        [self.tableView3 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
//一键领取 弹框 点击事件
- (void)ReloadClick:(UIButton *)Btn{
    [self.tableView3 reloadData];
}












@end

@implementation Home2_ENDListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [Home2_ENDListModelCell class]};
}
@end

@implementation Home2_ENDListModelCell
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"room_info" : [Home2_ENDRoom_ListModelCell class]};
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id" };
}
@end

@implementation Home2_ENDRoom_ListModelCell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id",@"isnew_hand" : @"new_hand" };
}

@end



