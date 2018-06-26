//
//  ViewController_Page1.m
//  CarServiceO2O
//
//  Created by 华四MAC on 16/7/18.
//  Copyright © 2016年 华四MAC. All rights reserved.
//

#import "ViewController_Page1.h"
#import "TopTableViewCell.h"
#import "GameTableViewCell.h"
#import "HomeTableHeaderView.h"
#import "NBA_RoomViewController.h"
#import "RoomInfoViewController.h"
#import "DJ_RoomViewController.h"
#import "MingRenViewController.h"

@interface ViewController_Page1 ()<UITableViewDelegate , UITableViewDataSource>{
          NSInteger numPerPage;//页数
}
@property (nonatomic , strong) UITableView *tableView;          //列表视图
@property (nonatomic , strong) HomeTableHeaderView *myheaderview;
@property (nonatomic , strong) NSMutableArray *listData;          //

@end

@implementation ViewController_Page1
NSString *Topnew_headertop = @"TopTableViewCell";
NSString *Game_cellad = @"GameTableViewCell";


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES]; //显示导航
    if (![self getUpLoginBool]) {
        return;
    }else{
//        [self initData];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    if (![self getUpLoginBool]) {
        return;
    }else{
        [self initNavigation];
        [self initView];
        [self initData];
    }
}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"爱伐木";

}


//初始化界面
- (void)initView {

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = self.myheaderview;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView registerClass:[TopTableViewCell class] forCellReuseIdentifier:Topnew_headertop];
    [self.tableView registerClass:[GameTableViewCell class] forCellReuseIdentifier:Game_cellad];
    [self.view addSubview:self.tableView];

    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;

    ZFRefreshGifHeader *header = [ZFRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_header = header;
    
    ZFRefreshAutoNormalFooter *footer = [ZFRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer = footer;

   
}

//首页bandana
- (HomeTableHeaderView *)myheaderview {
    if (!_myheaderview) {
        _myheaderview = [[HomeTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.mainWidth, (self.mainWidth/5) *2)];
        _myheaderview.controller = self;
    }
    return _myheaderview;
}




//初始化数据
- (void)initData{
    self.listData = [[NSMutableArray alloc] init];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewData {
    numPerPage = 1;
    [self initListData];
}


- (void)loadMoreData {
    numPerPage ++;
    [self initListData];
}

- (void)initListData {
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=room&a=roomlist&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                @"is_hot":@"1",
                                @"page":[NSString stringWithFormat:@"%ld",(long)numPerPage]  //页数
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
            HomeListModel *listModel = [HomeListModel yy_modelWithDictionary:dic];
            if (numPerPage == 1) {
                self.listData = [[NSMutableArray alloc]initWithArray:listModel.data];
                [self.tableView.mj_header endRefreshing];
            }else {
                [self.listData addObjectsFromArray:listModel.data];
                [self.tableView.mj_footer endRefreshing];
                if (listModel.data.count == 0) {
                    numPerPage--;
                    [AppDelegate notificationRequestInfoWithStatus:@"无更多数据"];
                }
            }
        }
        [self.tableView reloadData];
        [self initStart];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}


- (void)initStart{
    NSString *urlStr = @"http://api.aifamu.com/check.php";
    NSDictionary *paramters = @{@"":@"" };
    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
    [manager setSecurityPolicy:[AFMHTTPSManager customSecurityPolicy]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST: urlStr parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"%@",dic);
        NSMutableDictionary *Dic = [[NSMutableDictionary alloc]initWithDictionary:[dic objectForKey:@"data"]];
        if ([[Dic objectForKey:@"status"]isEqualToNumber:@1]) {
            self.appCache.Status = @"1";
        }else{
            self.appCache.Status = @"2";
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
}


#pragma mark - 列表代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 1 : self.listData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 0 ? 94 : 130;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
       TopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Topnew_headertop];
        [cell.nbaBtn addTarget:self action:@selector(nbaRoomClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.djBtn addTarget:self action:@selector(djRoomClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.mrbtn addTarget:self action:@selector(mrRoonClick:) forControlEvents:UIControlEventTouchUpInside];

       return cell;
    }else{
        GameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Game_cellad];
        if (self.listData) {
            HomeListModelCell *model = [self.listData objectAtIndex:indexPath.row];
            cell.name_Lab.text = model.name;
            [cell.icon_LImgView yy_setImageWithURL:[NSURL URLWithString:model.type_img] placeholder:[UIImage imageNamed:@" "]];
            cell.mengP_Lab.text = model.price;
            cell.jiangL_Lab.text = model.reward_num;
            cell.canY_Lab.text = [NSString stringWithFormat:@"%@/%@",model.now_guess_num,model.allow_guess_num];
            cell.canN_Lab.text = [NSString stringWithFormat:@"%@/%@",model.join_num,model.allow_uguess_num];
            cell.time_Lab.text = model.match_start_date;
            
            if ([model.join_num isEqualToString:@"0"]) {
                cell.isCanyu.text = @"未参与";
            }else if (model.join_num == model.allow_uguess_num){
                cell.isCanyu.text = @"已参与";
            }else{
                cell.isCanyu.text = @"继续参加";
            }
            if ([model.reward_id isEqualToString:@"1"]) {//门票
                cell.JL_inageView.image = [UIImage imageNamed:@"ticket-gray"];
            }else if ([model.reward_id isEqualToString:@"8"]){//木头
                cell.JL_inageView.image = [UIImage imageNamed:@"wood-gray"];
            }else{
            }
            
            //标签
            if ([model.isnew_hand isEqualToString:@"1"]) {
                cell.biao_image1.image = [UIImage imageNamed:@"novice-icon"];
                
                if ([model.open_id isEqualToString:@"1"]) {
                    cell.biao_image2.image = [UIImage imageNamed:@"open-icon"];
                    if ([model.more_guess isEqualToString:@"1"]) {
                        cell.biao_image3.image = [UIImage imageNamed:@"more-icon"];
                    }else{
                        cell.biao_image3.hidden = YES;
                    }
                }else{
                    if ([model.more_guess isEqualToString:@"1"]) {
                        cell.biao_image2.image = [UIImage imageNamed:@"more-icon"];
                    }else{
                        cell.biao_image2.hidden = YES;
                        cell.biao_image3.hidden = YES;
                    }
                }
            }else{
                if ([model.open_id isEqualToString:@"1"]) {//必开
                    cell.biao_image1.image = [UIImage imageNamed:@"open-icon"];
                    if ([model.more_guess isEqualToString:@"1"]) {   //多注
                        cell.biao_image2.image = [UIImage imageNamed:@"more-icon"];
                        cell.biao_image3.hidden = YES;
                    }else{
                        cell.biao_image2.hidden = YES;
                        cell.biao_image3.hidden = YES;
                    }
                }else{
                    if ([model.more_guess isEqualToString:@"1"]) {   //多注
                        cell.biao_image1.image = [UIImage imageNamed:@"more-icon"];
                        cell.biao_image2.hidden = YES;
                        cell.biao_image3.hidden = YES;
                    }else{
                        cell.biao_image2.hidden = YES;
                        cell.biao_image3.hidden = YES;
                    }
                }
            }
            //底部背景
            if ([model.project_id isEqualToString:@"5"] & [model.type_id isEqualToString:@"0"]) {  //lol
                cell.icon_backImageView .image = [UIImage imageNamed:@"lol-room-bg"];
            }
            if ([model.project_id isEqualToString:@"6"] & [model.type_id isEqualToString:@"0"]) {  //dota
                cell.icon_backImageView .image = [UIImage imageNamed:@"dota-room-bg"];
            }

        }

        
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HomeListModelCell *model = [self.listData objectAtIndex:indexPath.row];
    
    RoomInfoViewController *InfoVC = [[RoomInfoViewController alloc] init];
    InfoVC.Id = model.Id;
    InfoVC.price = model.price;
    InfoVC.allow_uguess_num = model.allow_uguess_num;
    InfoVC.join_num = model.join_num;
    InfoVC.name = model.name;
    InfoVC.iconImg = model.type_img;
    
    if ([model.project_id isEqualToString:@"4"]) {  //dota
        InfoVC.lol_dota_nba = @"nba";
    }
    if ([model.project_id isEqualToString:@"5"]) {  //lol
        InfoVC.lol_dota_nba = @"lol";
    }
    if ([model.project_id isEqualToString:@"6"]) {  //dota
        InfoVC.lol_dota_nba = @"dota";
    }
    [InfoVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:InfoVC animated:YES];
    
    
//    if (model.now_guess_num == model.allow_guess_num) {
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"房间参与人数已满" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        }];
//        [alertController addAction:okAction];
//        [self presentViewController:alertController animated:YES completion:nil];
//    }else{
//
//    }
}


// NBA
- (void)nbaRoomClick:(UIButton *)Btn{
    NBA_RoomViewController *nbaRVC = [[NBA_RoomViewController alloc] init];
    [nbaRVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:nbaRVC animated:YES];
}
// 电竞
- (void)djRoomClick:(UIButton *)Btn{
    DJ_RoomViewController *djRVC = [[DJ_RoomViewController alloc] init];
    [djRVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:djRVC animated:YES];
}
// 名人
- (void)mrRoonClick:(UIButton *)Btn{
    MingRenViewController *mrRVC = [[MingRenViewController alloc] init];
    [mrRVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:mrRVC animated:YES];
}


@end


@implementation HomeListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [HomeListModelCell class]};
}
@end

@implementation HomeListModelCell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id",@"isnew_hand" : @"new_hand" };
}
@end




