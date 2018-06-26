//
//  OrderViewController.m
//  AFM
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderTableViewCell.h"
#import "OrderInfoView.h"

@interface OrderViewController ()<UITableViewDelegate , UITableViewDataSource>{
    NSInteger numPerPage;   //页数

}
@property (nonatomic , strong) UITableView *tableView;          //列表视图
@property (nonatomic , strong) NSMutableArray *listData;          //
@property (nonatomic , strong) OrderInfoView *backRView;          //


@end

@implementation OrderViewController

NSString *order_cellid = @"OrderTableViewCell";



- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
    [self initData];
}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"订单";
    
}


//初始化界面
- (void)initView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView registerClass:[OrderTableViewCell class] forCellReuseIdentifier:order_cellid];
    [self.view addSubview:self.tableView];
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    //下拉刷新
    ZFRefreshGifHeader *header = [ZFRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_header = header;
    //上拉刷新
    ZFRefreshAutoNormalFooter *footer = [ZFRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer = footer;

    
}

//初始化数据
- (void)initData {
    self.listData = [[NSMutableArray alloc] init];
    [self.tableView.mj_header beginRefreshing];

}


//下拉刷新数据
- (void)loadNewData{
    numPerPage = 1;
    [self initListData];
    [self.tableView.mj_header endRefreshing];
}

//上拉加载数据
- (void)loadMoreData {
    numPerPage ++;
    [self initListData];
    [self.tableView.mj_footer endRefreshing];
}

- (void)initListData {
    
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=shop&a=order_list&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,//
                                @"page":[NSString stringWithFormat:@"%ld",(long)numPerPage]
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
        __weak typeof(self) weakSelf = self;
        if ([[dic objectForKey:@"error"]isEqualToNumber:@0]) {
            
            OrderListModel *listModel = [OrderListModel yy_modelWithDictionary:dic];
            if (numPerPage == 1) {
                weakSelf.listData = [[NSMutableArray alloc]initWithArray:listModel.data];
                [self.tableView.mj_header endRefreshing];
            }else {
                if (listModel.data.count == 0) {
                    [AppDelegate notificationRequestSuccessWithStatus:@"数据已全部加载"];
                    numPerPage --;
                }else {
                    [weakSelf.listData addObjectsFromArray:listModel.data];
                }
                [self.tableView.mj_footer endRefreshing];
            }
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


#pragma mark - 列表代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listData.count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0.1 : 10 ;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrderListModelCell *model = [self.listData objectAtIndex:indexPath.section];
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:order_cellid];
    
    if ([model.address_id isEqualToString:@"0"]) {  //虚拟产品
        cell.see_Btn.hidden = NO;
        cell.kuaidi_Lab.hidden = YES;
        cell.state_Lab.text = @"交易完成";
        cell.state_Lab.textColor = [UIColor getColorWithTexts];
    }else{                                    //实物
        cell.see_Btn.hidden = YES;
        cell.kuaidi_Lab.hidden = NO;
        if ([model.status isEqualToString:@"1"]) { //1为未发货、2为已发货、3为已签收
            cell.state_Lab.text = @"待发货";
            cell.state_Lab.textColor = [UIColor orangeColor];
            cell.kuaidi_Lab.hidden = YES;
        }else if ([model.status isEqualToString:@"2"]){
            cell.state_Lab.text = @"已发货";
            cell.kuaidi_Lab.hidden = NO;
            cell.state_Lab.textColor = [UIColor blueColor];
        }else{
            cell.state_Lab.text = @"已签收";
            cell.kuaidi_Lab.hidden = NO;
            cell.state_Lab.textColor = [UIColor getColorWithTexts];
        }
    }
    if ([model.type isEqualToString:@"2"]) {// 木头
        [cell.hhh_Img setImage:[UIImage imageNamed:@"wood-red"]];
    }else{
        [cell.hhh_Img setImage:[UIImage imageNamed:@"Diamonds-red"]];
    }

    cell.time_Lab.text = model.addtime;
    cell.title_Lab.text = model.name;
    cell.money_Lab.text = model.price;
    cell.danh_Lab.text = [NSString stringWithFormat:@"订单号：%@",model.numbers];
    cell.number_Lab.text = [NSString stringWithFormat:@"×%@",model.goods_nums];
    [cell.icon_Img yy_setImageWithURL:[NSURL URLWithString:model.avatar_img] placeholder:[UIImage imageNamed:@" "]];
    [cell.see_Btn addTarget:self action:@selector(see_BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.see_Btn.tag = indexPath.section;
    
    return cell;


}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}

//查看按钮
- (void)see_BtnClick:(UIButton *)Btn{
    OrderListModelCell *model = [self.listData objectAtIndex:Btn.tag];
    [self initInfoData:model.Id andAddId:model.address_id andName:model.name];

}


- (void)initInfoData:(NSString *)ID andAddId:(NSString *)addId andName:(NSString *)name {
    
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=shop&a=order_detail&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,//
                                @"order_id":ID,
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
            if ([addId isEqualToString:@"0"]) {//虚拟
                
                NSDictionary *dictionary_data = [dic objectForKey:@"data"];
                OrderInfoModelCell *model = [OrderInfoModelCell yy_modelWithDictionary:dictionary_data];
                self.infoCell = model;
                //加载账号密码弹框
                [self initBackView:[[model.codes_list firstObject] objectForKey:@"codes"] andPas:[[model.codes_list firstObject]objectForKey:@"pwd"] andName:name];

            }else{
  
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

}



//账号密码弹框
- (void) initBackView :(NSString *)code andPas:(NSString *)pas andName:(NSString *)name {
    
    self.backRView = [OrderInfoView infoView];
    self.backRView.frame = CGRectMake(0, 0, screen_Width, screen_Height-64);
    self.backRView.name_Lab.text = name;
    self.backRView.kahao_Lab.text = code;
    self.backRView.pass_lab.text = pas;
    [self.view addSubview:self.backRView];
    
}


@end

@implementation OrderListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [OrderListModelCell class]};
}
@end

@implementation OrderListModelCell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id" };
}
@end

@implementation OrderInfoModelCell
@end


