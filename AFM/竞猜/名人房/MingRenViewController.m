//
//  MingRenViewController.m
//  AFM
//
//  Created by 年少 on 2017/10/22.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "MingRenViewController.h"
#import "TopView.h"
#import "ClooseRoomView.h"
#import "GameTableViewCell.h"

@interface MingRenViewController ()<UITableViewDelegate , UITableViewDataSource , BtnBackBlcok>{
    NSInteger numPerPage;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic , strong) TopView *topView;                    //顶部视图
@property (nonatomic , strong) ClooseRoomView *clooseRView;         //筛选视图
@property (nonatomic , strong) NSMutableArray *listData;            //所有的房间列表
@property (nonatomic , strong) NSMutableArray *joinData;            //参加的场数



@end

@implementation MingRenViewController

NSString *MRs_cellad = @"GameTableViewCell";


//block
-(void)btnBackBlcok:(NSString *)Btn_tag{
    self.Btn_tag = Btn_tag;
    [self initListData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
    [self initData];
}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"名人房";
}


//初始化界面
- (void)initView {
    self.top_View.frame = CGRectMake(30,  0, screen_Width, 40);
    [self.view addSubview:self.top_View];

    self.topView = [[TopView alloc] init];
    [self.topView.button2 setTitle:@"LOL" forState:UIControlStateNormal];
    [self.topView.button3 setTitle:@"DOTA2" forState:UIControlStateNormal];
    [self.topView.button4 setTitle:@"NBA" forState:UIControlStateNormal];
    [self.topView.button2 setTitle:@"LOL" forState:UIControlStateSelected];
    [self.topView.button3 setTitle:@"DOTA2" forState:UIControlStateSelected];
    [self.topView.button4 setTitle:@"NBA" forState:UIControlStateSelected];
    self.topView.delegate = self;
    self.topView.frame = CGRectMake(0,  0, screen_Width, 40);
    [self.top_View addSubview:self.topView];
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.tableView registerClass:[GameTableViewCell class] forCellReuseIdentifier:MRs_cellad];
    [self.view addSubview:self.tableView];
    self.Btn_tag = @"1";
    //downview
    self.men_numLab.text = [NSString stringWithFormat:@"%@", self.appCache.menPiao];
    
    
    ZFRefreshGifHeader *header = [ZFRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_header = header;
    
    ZFRefreshAutoNormalFooter *footer = [ZFRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer = footer;
    
}

//初始化数据
- (void)initData {
    self.listData = [[NSMutableArray alloc] init];
    [self initListData];
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


- (void)initListData{
    if ([self.Btn_tag isEqualToString:@"1"]) {
        self.projectId = @"0";
        self.typeId = @"5";
    }else if ([self.Btn_tag isEqualToString:@"2"]){   //lol
        self.projectId = @"5";
        self.typeId = @"5";
    }else if ([self.Btn_tag isEqualToString:@"3"]){   //dota
        self.projectId = @"6";
        self.typeId = @"5";
    }else{                                            //nba
        self.projectId = @"4";
        self.typeId = @"5";
    }
    
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=room&a=roomlist&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                @"project_id":self.projectId,
                                @"type_id":self.typeId };
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
            MRListModel *listModel = [MRListModel yy_modelWithDictionary:dic];
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
            //参加*场比赛
            self.joinData = [[NSMutableArray alloc] init];
            for (MRListModelCell *model in self.listData) {
                self.joinData = [NSMutableArray arrayWithObject:model.join_num];
            }
            self.join_Lab.text = [NSString stringWithFormat:@"%@ 场",[self.joinData valueForKeyPath:@"@sum.floatValue"]];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
}
#pragma mark - 列表代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  130;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MRs_cellad];
    MRListModelCell *model = [self.listData objectAtIndex:indexPath.row];
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
    if ([model.project_id isEqualToString:@"5"] ) {  //lol
        cell.icon_backImageView .image = [UIImage imageNamed:@"lol-room-bg"];
    }
    if ([model.project_id isEqualToString:@"6"] ) {  //dota
        cell.icon_backImageView .image = [UIImage imageNamed:@"dota-room-bg"];
    }
    
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    NBAListModelCell *model = [self.listData objectAtIndex:indexPath.row];
    //    if (model.now_guess_num == model.allow_guess_num) {
    //        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"房间参与已满" preferredStyle:UIAlertControllerStyleAlert];
    //        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //        }];
    //        [alertController addAction:okAction];
    //        [self presentViewController:alertController animated:YES completion:nil];
    //    }else{
    //        RoomInfoViewController *InfoVC = [[RoomInfoViewController alloc] init];
    //        InfoVC.Id = model.Id;
    //        InfoVC.price = model.price;
    //        InfoVC.allow_uguess_num = model.allow_uguess_num;
    //        InfoVC.join_num = model.join_num;
    //        InfoVC.name = model.name;
    //        InfoVC.iconImg = model.type_img;
    //        InfoVC.lol_dota_nba = @"nba";
    //        [InfoVC setHidesBottomBarWhenPushed:YES];
    //        [self.navigationController pushViewController:InfoVC animated:YES];
    //    }
}









//筛选
- (IBAction)chooseBtnClick:(UIButton *)sender {
    self.clooseRView = [ClooseRoomView clooseTypeView];
    self.clooseRView.frame = CGRectMake(0, 0, screen_Width, screen_Height-64);
    self.clooseRView.downView.frame = CGRectMake(0, screen_Height, screen_Width, 300);
    
    [self.view addSubview:self.clooseRView];
    
    [UIView animateWithDuration:0.5 animations:^{
        // 设置view弹出来的位置
        self.clooseRView.downView.frame = CGRectMake(0, screen_Height-300, screen_Width, 300);
    }];
}

@end





@implementation MRListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [MRListModelCell class]};
}
@end

@implementation MRListModelCell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id",@"isnew_hand" : @"new_hand" };
}
@end

