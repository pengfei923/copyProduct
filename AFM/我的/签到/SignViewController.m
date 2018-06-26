//
//  SignViewController.m
//  AFM
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "SignViewController.h"
#import "SignTableViewCell.h"

@interface SignViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSString *dayNum;
    NSMutableArray *dataArray;

}
@property (nonatomic , strong) UITableView *tableView;            //列表视图


@end

@implementation SignViewController

NSString *Sign_cellad = @"SignTableViewCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
    [self initData];
}


//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"新手奖励";
}


//初始化界面
- (void)initView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView registerClass:[SignTableViewCell class] forCellReuseIdentifier:Sign_cellad];
    [self.view addSubview:self.tableView];
    
    
}


//初始化数据
- (void)initData {
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=award&a=attendance&version=1";
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
            NSDictionary *dict = [dic objectForKey:@"data"];
            dayNum = [dict objectForKey:@"attend_day"];
            dataArray = [dict objectForKey:@"is_get"];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}



#pragma mark - 列表代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, 160)];//
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, 160)];
    imgView.image = [UIImage imageNamed:@"sign-img"];
    
    [topView addSubview:imgView];
    
    return topView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 160;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SignTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Sign_cellad];
    
    cell.index = (int)indexPath.row;
    cell.YandN_Btn.tag = indexPath.row + 1;
    [cell.YandN_Btn addTarget:self action:@selector(QianClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.day_Lab.text = [NSString stringWithFormat:@"第%ld天",(long)indexPath.row + 1];
    
    cell.YandN_Btn.selected = NO;
    cell.YandN_Btn.backgroundColor = [UIColor colorWithRed:215/255.0 green:56/255.0 blue:63/255.0 alpha:1];
    
    if (dataArray) {
        for (id object in dataArray) {
            if (indexPath.row == [object integerValue] - 1) {
                cell.YandN_Btn.selected = YES;
                cell.YandN_Btn.backgroundColor = [UIColor lightGrayColor];
            }
        }
    }
    
   
    //天数彩色
    NSInteger dayn = (long)indexPath.row + 1;//
    NSString *daynum = [NSString stringWithFormat:@"第  %@  天",[NSString stringWithFormat: @"%ld", (long)dayn]];
    NSMutableAttributedString *day = [[NSMutableAttributedString alloc] initWithString:daynum];
    [day addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:215/255.0 green:56/255.0 blue:63/255.0 alpha:1] range:NSMakeRange(2, 3)];
    cell.day_Lab.attributedText = day;

    return cell;
    
}

- (void)QianClick:(UIButton *)Btn{
    NSString *ID = [NSString stringWithFormat:@"%ld",(long)Btn.tag];
    
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=award&a=get_attendance&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                @"id": ID  };
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
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"message:@"领取成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}


@end
