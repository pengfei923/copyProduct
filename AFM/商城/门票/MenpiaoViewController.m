//
//  MenpiaoViewController.m
//  AFM
//
//  Created by 年少 on 2017/10/6.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "MenpiaoViewController.h"
#import "Menpiao_GoodsTableViewCell.h"
#import "GoodsInfo1TableViewCell.h"
#import "AddZuanViewController.h"


@interface MenpiaoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong) UITableView *tableView;            //列表视图

@end

@implementation MenpiaoViewController
NSString *MPgoods_cellad  = @"Menpiao_GoodsTableViewCell";
NSString *Tiele_cellad = @"GoodsInfo1TableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"购买门票";
    
}

//初始化界面
- (void)initView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView registerClass:[Menpiao_GoodsTableViewCell class] forCellReuseIdentifier:MPgoods_cellad];
    [self.tableView registerClass:[GoodsInfo1TableViewCell class] forCellReuseIdentifier:Tiele_cellad];
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.NumF = [NSString stringWithFormat:@"10"];
    [self.view addSubview:self.tableView];
    [self initDPayView];

}


// 支付
- (void)initDPayView{
    //底部View
    UIView *downV = [[UIView alloc] initWithFrame:CGRectMake(0, screen_Height-50-64, screen_Width, 50)];
    downV.backgroundColor = [UIColor clearColor];
    //立即支付
    UIButton *DB_Btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, screen_Width, 50)];
    [DB_Btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [DB_Btn setTitle:[NSString stringWithFormat:@"立即支付"] forState:UIControlStateNormal];
    [DB_Btn setBackgroundColor:[UIColor getColorWithTheme]];
    [DB_Btn addTarget:self action:@selector(payMPClick:) forControlEvents:UIControlEventTouchUpInside];
    [downV addSubview:DB_Btn];
    [self.view addSubview: downV];
    
}

- (void)payMPClick:(UIButton *)Btn{
    NSString *AlertT = [NSString stringWithFormat:@"需支付%@钻石是否确认购买",self.NumF];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:AlertT preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (self.appCache.Zuanshi >= self.NumF) {
            [self initPay];
        }else{
            [self initChong];  //上架原因
        }
    }];

    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

}

//确认支付
- (void)initPay{
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=shop&a=ticket_pay&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                @"nums":self.NumF,
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
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[dic objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:[dic objectForKey:@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
}

//前往充值
- (void)initChong{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"钻石不够是否去充值" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AddZuanViewController *addZ = [[AddZuanViewController alloc]init];
        addZ.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:addZ animated:YES];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


//单元格数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

//单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 345;
    }else if (indexPath.row == 1) {
        return 40;
    }else{
        return 80;
    }
}


//单元格视图
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        Menpiao_GoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MPgoods_cellad];
        cell.mpValueBlock = ^(NSString *MPvalue) {
            self.NumF = MPvalue;
        };
        return cell;
        
    }else if (indexPath.row == 1) {
        GoodsInfo1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Tiele_cellad];
        return cell;
    }else{
        static NSString *CellIdentifier =@"Cell";
        UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:CellIdentifier];
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, [UIScreen mainScreen].bounds.size.width - 20, 60)];
            lable.text = @"参加各种竞猜所需要的通行证，不同竞猜模式所消耗的门票数各不相同";
            lable.font = [UIFont systemFontOfSize:14];
            lable.numberOfLines = 0;
            [cell addSubview:lable];
        }
        
        return cell;
    }
    
}





@end
