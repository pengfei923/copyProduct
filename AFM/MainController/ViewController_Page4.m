
//  ViewController_Page4.m
//  CarServiceO2O
//
//  Created by 华四MAC on 16/7/18.
//  Copyright © 2016年 华四MAC. All rights reserved.
//
#import "ViewController_Page4.h"
#import "MyInfoTableViewCell.h"
#import "MyInfoViewController.h"
#import "MessageViewController.h"
#import "SignViewController.h"
#import "OrderViewController.h"
#import "SettingViewController.h"
#import "HelpViewController.h"
#import "LocationViewController.h"
#import "JfenViewController.h"
#import "ConvertViewController.h"
#import "ChengHViewController.h"


#import "LoginViewController.h"

@interface ViewController_Page4 ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>{
    NSMutableArray *sectionSetArr0;  //列表图标
    NSMutableArray *sectionSetArr1;  //列表文字
    NSMutableArray *sectionSetArr2;  //列表文字
    NSMutableArray *sectionSetArr3;  //列表文字
    
}
@property(nonatomic, strong)UITableView *tableView;          //列表视图

@end

@implementation ViewController_Page4
NSString *myInfo_cellId = @"MyInfoTableViewCell";


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES]; //显示导航

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
    [self initData];
    [self initAllData];

}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"我的";
}


- (void)initView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerClass:[MyInfoTableViewCell class] forCellReuseIdentifier:myInfo_cellId];
    
    [self.view addSubview:self.tableView];
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    
    ZFRefreshGifHeader *header = [ZFRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_header = header;

}

//初始化数据
- (void)initData {
    sectionSetArr0 = [[NSMutableArray alloc]init];
    sectionSetArr1 = [[NSMutableArray alloc]init];
    Page4Model *model0 = [[Page4Model alloc]init];
    model0.celltitle = @"消息";
    model0.celllogoimg = @"user-email";
    [sectionSetArr1 addObject:model0];
    
    Page4Model *model1 = [[Page4Model alloc]init];
    model1.celltitle = @"签到";
    model1.celllogoimg = @"user-sign";
    [sectionSetArr1 addObject:model1];
    
    Page4Model *model2 = [[Page4Model alloc]init];
    model2.celltitle = @"勋章称号";
    model2.celllogoimg = @"user-title";
    [sectionSetArr1 addObject:model2];
    [sectionSetArr0 addObject:sectionSetArr1];

    
    sectionSetArr2 = [[NSMutableArray alloc]init];
    Page4Model *model3 = [[Page4Model alloc]init];
    model3.celltitle = @"积分规则";
    model3.celllogoimg = @"user-rule";
    [sectionSetArr2 addObject:model3];

    Page4Model *model4 = [[Page4Model alloc]init];
    model4.celltitle = @"联系方式";
    model4.celllogoimg = @"user-tel";
    [sectionSetArr2 addObject:model4];

//    Page4Model *model5 = [[Page4Model alloc]init];
//    model5.celltitle = @"兑换专区";
//    model5.celllogoimg = @"user-gift";
//    [sectionSetArr2 addObject:model5];
    
    Page4Model *model6 = [[Page4Model alloc]init];
    model6.celltitle = @"订单查询";
    model6.celllogoimg = @"user-order";
    [sectionSetArr2 addObject:model6];
    [sectionSetArr0 addObject:sectionSetArr2];
    
    
    sectionSetArr3 = [[NSMutableArray alloc]init];
    Page4Model *model7 = [[Page4Model alloc]init];
    model7.celltitle = @"帮助";
    model7.celllogoimg = @"user-help";
    [sectionSetArr3 addObject:model7];
   
    Page4Model *model8 = [[Page4Model alloc]init];
    model8.celltitle = @"设置";
    model8.celllogoimg = @"user-set";
    [sectionSetArr3 addObject:model8];
    [sectionSetArr0 addObject:sectionSetArr3];
    
    }

//下拉刷新数据
- (void)loadNewData{
    [self initAllData];
    [self.tableView.mj_header endRefreshing];
}
//加载个人信息
- (void)initAllData{
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=public&a=check_token&apptype=app&version=1";
    if (self.appCache.loginViewModel.token) {
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
                NSDictionary *dictionary_data = [dic objectForKey:@"data"];
                UserInfoModel *userInfoModel = [UserInfoModel yy_modelWithDictionary:dictionary_data];
                self.infoModelCell = userInfoModel;
                self.appCache.Zuanshi = self.infoModelCell.diamond;
                self.appCache.gold = self.infoModelCell.gold;
                self.appCache.menPiao = self.infoModelCell.entrance_ticket;
            }
            
            [self.tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }
   }


#pragma mark - 列表代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        NSMutableArray *array = [sectionSetArr0 objectAtIndex:section - 1];
        return array.count;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 180.0f;
    }else{
        return 50.0f;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MyInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myInfo_cellId];
        cell.controller = self;
        
        cell.name_Lab.text = self.infoModelCell.username;
        cell.tit_Lab.text = self.infoModelCell.rank_name;
        [cell.icon_Img yy_setImageWithURL:[NSURL URLWithString:self.infoModelCell.avatar_img] options:YYWebImageOptionRefreshImageCache];
        cell.zuan_Lab.text = self.infoModelCell.diamond;
        cell.men_Lab.text = self.infoModelCell.entrance_ticket;
        cell.mu_Lab.text = self.infoModelCell.gold;
        return cell;
        
    }else{
        NSMutableArray *array = [sectionSetArr0 objectAtIndex:indexPath.section-1];
        Page4Model *model = [array objectAtIndex:indexPath.row];
        
        static NSString *cellIndef = @"cellindef";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndef];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndef];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text = model.celltitle;
        cell.imageView.image = [UIImage imageNamed:model.celllogoimg];
        
        return cell;
        
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0){
        MyInfoViewController *myinfoVC = [[MyInfoViewController alloc] init];
        
        [myinfoVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:myinfoVC animated:YES];

        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
           MessageViewController *messageVC = [[MessageViewController alloc] init];
           [messageVC setHidesBottomBarWhenPushed:YES];
           [self.navigationController pushViewController:messageVC animated:YES];
        
        }else if (indexPath.row == 1){
            SignViewController *signVC = [[SignViewController alloc] init];
            [signVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:signVC animated:YES];
            
        }else{//称号
            ChengHViewController *myinfoVC = [[ChengHViewController alloc] init];
            myinfoVC.RANK = self.infoModelCell.rank;
            [myinfoVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:myinfoVC animated:YES];   
        }
            
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            if (![self getUpLoginBool]) {
                return;
            }else { //积分
                JfenViewController *jfenVC = [[JfenViewController alloc] init];
                [jfenVC setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:jfenVC animated:YES];
            }
        }else if (indexPath.row == 1){   //联系地址
            LocationViewController *myinfoVC = [[LocationViewController alloc] init];
            [myinfoVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:myinfoVC animated:YES];
//        }else if (indexPath.row == 2){   //兑换专区
//            ConvertViewController *orserVC = [[ConvertViewController alloc] init];
//            [orserVC setHidesBottomBarWhenPushed:YES];
//            [self.navigationController pushViewController:orserVC animated:YES];
        }else{//订单
            OrderViewController *orserVC = [[OrderViewController alloc] init];
            [orserVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:orserVC animated:YES];
        }
    }else{
        if (indexPath.row == 0) {
            HelpViewController *helpVC = [[HelpViewController alloc] init];
            [helpVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:helpVC animated:YES];
        }else{
            SettingViewController *settingVC = [[SettingViewController alloc] init];
            [settingVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:settingVC animated:YES];

        }
    }
}



@end


@implementation Page4Model
@end

