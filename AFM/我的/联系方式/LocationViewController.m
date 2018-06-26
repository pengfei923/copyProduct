//
//  LocationViewController.m
//  AFM
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "LocationViewController.h"
#import "AddressTableViewCell.h"
#import "AddContactViewController.h"

@interface LocationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;          //列表视图
@property (nonatomic , strong) NSMutableArray *addressData;        //数据

@end

@implementation LocationViewController
NSString *address_cellid = @"AddressTableViewCell";

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
    [self initData];
}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"联系方式";
    
}


//初始化界面
- (void)initView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height-50) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView registerClass:[AddressTableViewCell class] forCellReuseIdentifier:address_cellid];
    [self.view addSubview:self.tableView];
    [self initAddView];
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
}





//添加按钮
- (void)initAddView {
    
    //底部View
    UIView *downV = [[UIView alloc] initWithFrame:CGRectMake(0, screen_Height-50-64, screen_Width, 50)];
    downV.backgroundColor = [UIColor clearColor];
    //立即支付
    UIButton *DB_Btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, screen_Width, 50)];
    [DB_Btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [DB_Btn setTitle:[NSString stringWithFormat:@"立即添加"] forState:UIControlStateNormal];
    [DB_Btn setBackgroundColor:[UIColor getColorWithTheme]];
    [DB_Btn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    [downV addSubview:DB_Btn];
    [self.view addSubview: downV];
    
    
}

//初始化数据
- (void)initData {
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=shop&a=show_address&version=2";
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
            AddressListModel *systemModel = [AddressListModel yy_modelWithDictionary:dic];
            self.addressData = [[NSMutableArray alloc]initWithArray:systemModel.data];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

}


#pragma mark - 列表代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.addressData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:address_cellid];
    AddressListModelCell *model = [self.addressData objectAtIndex:indexPath.section];
    cell.name_Lab.text = model.name;
    cell.phone_Lab.text = model.phone;
    cell.address_Lab.text = model.address;
    cell.deleteBtn.tag = indexPath.section;
    cell.palyBtn.tag = indexPath.section;
    cell.morenBtn.tag = indexPath.section;
    [cell.deleteBtn addTarget:self action:@selector(deleteAddressClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.palyBtn addTarget:self action:@selector(palyAddressClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.morenBtn addTarget:self action:@selector(morenAddressClick:) forControlEvents:UIControlEventTouchUpInside];

    if ([model.is_default isEqualToString:@"1"]) {   //默认
        cell.morenBtn.selected = YES;
    }else{
        cell.morenBtn.selected = NO;

    }
    return cell;

}


//默认
- (void)morenAddressClick:(UIButton *)Btn {
    AddressListModelCell *model = [self.addressData objectAtIndex:Btn.tag];
 
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=shop&a=set_address_status&version=2";
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
            [self initData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];

}


//编辑
- (void)palyAddressClick:(UIButton *)Btn {
    AddressListModelCell *model = [self.addressData objectAtIndex:Btn.tag];
    AddContactViewController *addVC = [[AddContactViewController alloc] init];
    addVC.Id = model.Id;
    addVC.name_L = model.name;
    addVC.Phone_L = model.phone;
    addVC.address_L = model.address;
    [addVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:addVC animated:YES];

}


//删除
- (void)deleteAddressClick:(UIButton *)Btn {
    AddressListModelCell *model = [self.addressData objectAtIndex:Btn.tag];

    NSString *urlStr = @"http://api.aifamu.com/index.php?m=shop&a=delete_address&version=2";
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
            [self.addressData removeAllObjects];
            [self initData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//添加事件
- (void)addClick:(UIButton *)btn{
    AddContactViewController *addVC = [[AddContactViewController alloc] init];
    [addVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:addVC animated:YES];

}


@end




@implementation AddressListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [AddressListModelCell class]};
}
@end


//
@implementation AddressListModelCell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}
@end
