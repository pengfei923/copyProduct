//
//  MessageViewController.m
//  AFM
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "MsgInfoViewController.h"

@interface MessageViewController ()<UITableViewDelegate , UITableViewDataSource>{

}
@property (nonatomic , strong) UITableView *tableView;          //列表视图
@property (nonatomic , strong) NSMutableArray *messageData;        //数据

@end

@implementation MessageViewController

NSString *message_cellid = @"MessageTableViewCell";

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES]; //显示导航
    self.tabBarController.tabBar.hidden = YES;                    //隐藏tabBar
    [self initData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"消息中心";
    
}

//初始化界面
- (void)initView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:message_cellid];
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
   
}

//初始化数据
- (void)initData {
    self.messageData = [[NSMutableArray alloc] init];
    [self.tableView.mj_header beginRefreshing];
}

//下拉刷新数据
- (void)loadNewData{
    [self initMegData];
    [self.tableView.mj_header endRefreshing];
}


- (void)initMegData {
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=user&a=notice_list&apptype=app&version=1";
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
        __weak typeof(self) weakSelf = self;
        if ([[dic objectForKey:@"error"]isEqualToNumber:@0]) {
            MessageListModel *systemModel = [MessageListModel yy_modelWithDictionary:dic];
            weakSelf.messageData = [[NSMutableArray alloc]initWithArray:systemModel.data];
            [self.tableView.mj_header endRefreshing];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


#pragma mark - 列表代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.messageData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 145;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:message_cellid];
    MessageListModelCell *model = [self.messageData objectAtIndex:indexPath.section];
    cell.Model = model;
    cell.title_Lab.text = model.title;
    cell.msg_Lab.text = model.depict;
    cell.time_Lab.text = model.time;
    cell.delete_Btn.tag = indexPath.section;
    [cell.delete_Btn addTarget:self action:@selector(deleteMsgClick:) forControlEvents:UIControlEventTouchUpInside];
   
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MessageListModelCell *model = [self.messageData objectAtIndex:indexPath.section];
    MsgInfoViewController *msgInfoVC = [[MsgInfoViewController alloc] init];
    msgInfoVC.Mtitle = model.title;
    msgInfoVC.Mdepict = model.depict;
    msgInfoVC.Mtime = model.time;
    msgInfoVC.Id = model.Id;

    [msgInfoVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:msgInfoVC animated:YES];

}


//删除
- (void)deleteMsgClick:(UIButton *)Btn {
    MessageListModelCell *model = [self.messageData objectAtIndex:Btn.tag];
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=user&a=delete_notice&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                @"id":model.Id,
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
            [self.messageData removeAllObjects];
            [self initData];

        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


@end




@implementation MessageListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [MessageListModelCell class]};
}
@end


//
@implementation MessageListModelCell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}
@end

