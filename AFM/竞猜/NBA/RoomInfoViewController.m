//
//  RoomInfoViewController.m
//  AFM
//
//  Created by admin on 2017/9/12.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "RoomInfoViewController.h"
#import "Top_JCTableViewCell.h"
#import "JJFPTableViewCell.h"
#import "SSDZTableViewCell.h"
#import "BSXXTableViewCell.h"
#import "CYWJTableViewCell.h"
#import "ChooseZRViewController.h"
#import "RoomInfoModelData.h"
#import "DJ_ChooseViewController.h"
#import "DJ1_ChooseViewController.h"
#import "JJFP_TopTableViewCell.h"
#import "ChooseZRViewController.h"
#import "New_InfoViewController.h"


@interface RoomInfoViewController ()<UITableViewDelegate , UITableViewDataSource,headDelegate>{
    UIButton *detailedbutton;
    UIButton *Man_Btn;
    NSTimeInterval TIME;         //时间间隔

}
@property (nonatomic , strong) UITableView *tableView;          //列表视图
@property (nonatomic , strong) NSString *Tag;                  //返回tag
@property (nonatomic , strong) NSMutableArray *AllListData;      //
@property (nonatomic , strong) NSMutableArray *joinListData;     //
@property (nonatomic , strong) NSMutableArray *NEWData;          //
@property (nonatomic , strong) NSTimer *listTimer;              //定时器

@property (nonatomic , strong) RoomInfoModelDataCell *allmodel;

@end

@implementation RoomInfoViewController
NSString *Top_headerView = @"Top_JCTableViewCell";
NSString *ID_JJTOPcell = @"JJFP_TopTableViewCell";
NSString *ID_JJFPcell = @"JJFPTableViewCell";
NSString *ID_SSDZcell = @"SSDZTableViewCell";
NSString *ID_BSXXcell = @"BSXXTableViewCell";
NSString *ID_CYWJcell = @"CYWJTableViewCell";

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startTimer];
    [self initData];

}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
    
}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = self.name;
}


//初始化界面
- (void)initView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.mainWidth, self.mainHeight - 50) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;  // 滚动条
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线
    self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView registerClass:[Top_JCTableViewCell class] forCellReuseIdentifier:Top_headerView];
    [self.tableView registerClass:[JJFPTableViewCell class] forCellReuseIdentifier:ID_JJFPcell];
    [self.tableView registerClass:[SSDZTableViewCell class] forCellReuseIdentifier:ID_SSDZcell];
    [self.tableView registerClass:[BSXXTableViewCell class] forCellReuseIdentifier:ID_BSXXcell];
    [self.tableView registerClass:[CYWJTableViewCell class] forCellReuseIdentifier:ID_CYWJcell];
    [self.tableView registerClass:[JJFP_TopTableViewCell class] forCellReuseIdentifier:ID_JJTOPcell];
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;

    [self.view addSubview:self.tableView];
    
    detailedbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    detailedbutton.frame = CGRectMake(0, self.mainHeight-50, self.mainWidth, 50);
    [detailedbutton setImage:[UIImage imageNamed:@"ticket-white"] forState:UIControlStateNormal];
    [detailedbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [detailedbutton setBackgroundColor:[UIColor getColorWithTheme]];
    detailedbutton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;

    
    Man_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    Man_Btn.frame = CGRectMake(0, self.mainHeight-50, self.mainWidth, 50);
    [Man_Btn setTitle:[NSString stringWithFormat:@"参与次数已达上限"] forState:UIControlStateNormal];
    [Man_Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Man_Btn setBackgroundColor:[UIColor lightGrayColor]];
    Man_Btn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:Man_Btn];
    [self.view addSubview:detailedbutton];

    if (self.join_num == self.allow_uguess_num) {
        Man_Btn.hidden = NO;
        detailedbutton.hidden = YES;
    }else{
        Man_Btn.hidden = YES;
        detailedbutton.hidden = NO;
        [detailedbutton addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }

    self.Tag = @"1";

}


//block
-(void)refreshHead:(NSString *)Tag{
    _Tag = Tag;
    [_tableView reloadData];
}


//初始化数据
- (void)initData{
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=room&a=roomdetail&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                @"id":self.Id  };
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
            RoomInfoModelDataCell *Model = [RoomInfoModelDataCell yy_modelWithDictionary:Dic];
            self.allmodel = Model;
            self.price = self.allmodel.price;
            [detailedbutton setTitle:[NSString stringWithFormat:@"%@ 加入",self.allmodel.price] forState:UIControlStateNormal];

            //可用总工资
            self.GZall = self.allmodel.lineup.pay;
        }
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
            return self.allmodel.reward_rule_k.count + 1;
        }else if ([_Tag isEqualToString:@"2"]){
            return self.allmodel.match_list.count;
        }else if ([_Tag isEqualToString:@"3"]){
            return self.NEWData.count;
        }else{
            return self.allmodel.join_user.count;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 215;
    }else{
        if ([_Tag isEqualToString:@"1"]) {
            return indexPath.row == 0 ? 90:45;
        }else if ([_Tag isEqualToString:@"2"]){
            return 100;
        }else if ([_Tag isEqualToString:@"3"]){
            return 88;
        }else{
            return 55;
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
    if (indexPath.section == 0) {
        Top_JCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Top_headerView];
        //倒计时
        NSDate *senddate = [NSDate date];
        NSInteger data1 = [senddate timeIntervalSince1970];
        TIME = self.allmodel.match_start_time - data1;
        cell.time_Lab.text = [NSString stringWithFormat:@"%@",[self ConvertStrToTime:TIME]];
        
        cell.men_Lab.text = self.allmodel.price;
        cell.jiang_Lab.text = self.allmodel.reward_num;
        cell.zhu_Lab.text = [NSString stringWithFormat:@"%@/%@",self.allmodel.now_guess_num,self.allmodel.allow_guess_num];
        cell.gozhu_Lab.text = [NSString stringWithFormat:@"%@/%@",self.allmodel.join_num,self.allmodel.allow_uguess_num];
        if ([self.allmodel.reward_id isEqualToString:@"1"]) {//门票
            cell.img_jiang.image = [UIImage imageNamed:@"ticket-white"];
        }else if ([self.allmodel.reward_id isEqualToString:@"8"]){//木头
            cell.img_jiang.image = [UIImage imageNamed:@"wood-white"];
        }else{
        }
        if ([self.allmodel.isnew_hand isEqualToString:@"1"]) {
            cell.biao_image1.image = [UIImage imageNamed:@"novice-icon"];
            if ([self.allmodel.open_id isEqualToString:@"1"]) {
                cell.biao_image2.image = [UIImage imageNamed:@"open-icon"];
                if ([self.allmodel.more_guess isEqualToString:@"1"]) {
                    cell.biao_image3.image = [UIImage imageNamed:@"more-icon"];
                }else{
                    cell.biao_image3.hidden = YES;
                }
            }else{
                if ([self.allmodel.more_guess isEqualToString:@"1"]) {
                    cell.biao_image2.image = [UIImage imageNamed:@"more-icon"];
                }else{
                    cell.biao_image2.hidden = YES;
                    cell.biao_image3.hidden = YES;
                }
            }
        }
        [cell.button3 addTarget:self action:@selector(button3Click:) forControlEvents:UIControlEventTouchUpInside];
        cell.delegate = self;
        return cell;
    }else{
        if ([_Tag isEqualToString:@"1"]) {
            if (indexPath.row == 0) {     //头视图的注释说明
                JJFP_TopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_JJTOPcell];
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                // 行间距设置为30
                [paragraphStyle setLineSpacing:4];
                NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:cell.title_lab.text];
                [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [cell.title_lab.text length])];
                // 设置Label要显示的text
                [cell.title_lab  setAttributedText:setString];
      
                return cell;
            }else{
                RoomInfoReward_ruleData *model = [self.allmodel.reward_rule_k objectAtIndex:indexPath.row-1];
                JJFPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_JJFPcell];
                cell.left_Lab.text = model.name;
                cell.num_Lab.text = model.content;
                if ([self.allmodel.prize_type isEqualToString:@"1"]) {//1门票2木头
                    cell.type.image = [UIImage imageNamed:@"ticket-red"];
                }else if ([self.allmodel.prize_type isEqualToString:@"2"]){
                    cell.type.image = [UIImage imageNamed:@"wood-red"];
                }
                
                return cell;
 
            }
        }else if ([_Tag isEqualToString:@"2"]){
            RoomInfoMatch_listData *model = [self.allmodel.match_list objectAtIndex:indexPath.row];
            SSDZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_SSDZcell];
            cell.title_Lab.text = model.match_name;
            cell.time_lab.text = model.match_time_date;
            cell.left_Lab.text = model.name_a;
            cell.right_Lab.text = model.name_b;
            [cell.Left_Img yy_setImageWithURL:[NSURL URLWithString:model.img_a] placeholder:[UIImage imageNamed:@" "]];
            [cell.right_Img yy_setImageWithURL:[NSURL URLWithString:model.img_b] placeholder:[UIImage imageNamed:@" "]];

            return cell;
        }else if ([_Tag isEqualToString:@"3"]){
            BSXXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_BSXXcell];
            RoomNew_listDataCell *model = [self.NEWData objectAtIndex:indexPath.row];
            cell.title_Lab.text = model.title;
            cell.num_Lab.text = [NSString stringWithFormat:@"%@阅",model.views];
            [cell.Img_View yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@" "]];

            return cell;
        }else{
            RoomInfoJoin_userData *usermodel = [self.allmodel.join_user objectAtIndex:indexPath.row];
            CYWJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_CYWJcell];
            cell.name_Lab.text = usermodel.username;
            cell.ch_Lab.text = usermodel.rank_name;
            cell.num_Lab.text = usermodel.guess_num;
            [cell.iconImgView yy_setImageWithURL:[NSURL URLWithString:usermodel.avatar_img] placeholder:[UIImage imageNamed:@" "]];
            [cell.ch_ImgView yy_setImageWithURL:[NSURL URLWithString:usermodel.rank_img] placeholder:[UIImage imageNamed:@" "]];
            
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_Tag isEqualToString:@"3"]){
        RoomNew_listDataCell *model = [self.NEWData objectAtIndex:indexPath.row];
        New_InfoViewController *newInfoV = [[New_InfoViewController alloc] init];
        newInfoV.url = model.href;
        [newInfoV setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:newInfoV animated:YES];
    }else{
    }
}



//立即参加
- (void)playBtnClick:(UIButton *)send {
    if ([self.lol_dota_nba isEqualToString:@"nba"]) {
        ChooseZRViewController *infonbaVC = [[ChooseZRViewController alloc] init];
        infonbaVC.Id = self.allmodel.Id;
        infonbaVC.price = self.price;
        infonbaVC.allow_uguess_num = self.allow_uguess_num;
        infonbaVC.join_num = self.join_num;
        infonbaVC.name = self.name;
        infonbaVC.iconImg = self.iconImg;
        infonbaVC.now_guess_num = self.allmodel.now_guess_num;
        infonbaVC.allow_guess_num = self.allmodel.allow_guess_num;
        infonbaVC.TIME_mast = TIME;
        infonbaVC.allGZ = self.GZall;
        infonbaVC.type_num = self.allmodel.lineup.num;  //5人/8人
        [infonbaVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:infonbaVC animated:YES];

    }else{
        if ([self.lol_dota_nba isEqualToString:@"lol"]) {
            DJ1_ChooseViewController *infoVC = [[DJ1_ChooseViewController alloc] init];
            infoVC.Id = self.allmodel.Id;
            infoVC.price = self.price;
            infoVC.allow_uguess_num = self.allow_uguess_num;
            infoVC.join_num = self.join_num;
            infoVC.name = self.name;
            infoVC.iconImg = self.iconImg;
            infoVC.now_guess_num = self.allmodel.now_guess_num;
            infoVC.allow_guess_num = self.allmodel.allow_guess_num;
            infoVC.TIME_mast = TIME;
            infoVC.type = self.lol_dota_nba;
            infoVC.allGZ = self.GZall;
            [infoVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:infoVC animated:YES];

        }else{
            DJ_ChooseViewController *infoVC = [[DJ_ChooseViewController alloc] init];
            infoVC.Id = self.allmodel.Id;
            infoVC.price = self.price;
            infoVC.allow_uguess_num = self.allow_uguess_num;
            infoVC.join_num = self.join_num;
            infoVC.name = self.name;
            infoVC.iconImg = self.iconImg;
            infoVC.now_guess_num = self.allmodel.now_guess_num;
            infoVC.allow_guess_num = self.allmodel.allow_guess_num;
            infoVC.TIME_mast = TIME;
            infoVC.type = self.lol_dota_nba;
            infoVC.allGZ = self.GZall;
            [infoVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:infoVC animated:YES];
        }        
    }
}


//新闻
- (void)button3Click:(UIButton *)Btn{
    NSString *urlStr = @"http://appapi.sgamer.com/index.php?g=api&m=news&a=getteamnews";
    NSDictionary *paramters = @{@"tags":self.allmodel.team_tags,
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
            RoomNew_listData *listModel = [RoomNew_listData yy_modelWithDictionary:dic];
            self.NEWData = [[NSMutableArray alloc]initWithArray:listModel.data];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}







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
    TIME = self.allmodel.match_start_time - data1;
    [self.tableView reloadData];
}
//重新计算 时/分/秒
- (NSString *)ConvertStrToTime:(NSInteger )timeStr{
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",timeStr/3600];
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(timeStr%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld",timeStr%60];
    NSString *timeString = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    return timeString;
}



@end


@implementation RoomNew_listData
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [RoomNew_listDataCell class]};
}
@end

@implementation RoomNew_listDataCell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id" };
}
@end




