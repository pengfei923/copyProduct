//
//  SaveZRViewController.m
//  AFM
//
//  Created by admin on 2017/9/15.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "SaveZRViewController.h"
#import "ZRTableViewCell.h"
#import "Player_TopTableViewCell.h"

@interface SaveZRViewController ()<UITableViewDelegate , UITableViewDataSource, topChooseDelegate>{
    
}
@property (nonatomic , strong) UITableView *tableView;          //列表视图
@property (nonatomic , strong) NSMutableArray *ZRnumData;
@property (nonatomic , strong) NSMutableArray *allData;          //
@property (nonatomic , strong) ZR_ModelDataCell *allmodel;

@end


@implementation SaveZRViewController

NSString *ZR_cellid = @"ZRTableViewCell";
NSString *ZRtop_cellid = @"Player_TopTableViewCell";



- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
    [self initData];
}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"已存阵容";
    
}


//初始化界面
- (void)initView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.mainWidth, self.mainHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;  // 滚动条
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线
    self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView registerClass:[Player_TopTableViewCell class] forCellReuseIdentifier:ZRtop_cellid];
    [self.tableView registerClass:[ZRTableViewCell class] forCellReuseIdentifier:ZR_cellid];
    [self.view addSubview:self.tableView];
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.type_TT isEqual: @"2"];
}

//初始化数据
- (void)initData {
    self.ZRnumData = [[NSMutableArray alloc] init];
    
    [self initTypeData:@"2"];    //2已存
    
    
}
- (void)initTypeData :(NSString *)type {
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=bet&a=userlineup&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                @"id":self.ID,
                                @"type":type, // 获取阵容类型2已存1推荐
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
            ZR_ModelData *listModel = [ZR_ModelData yy_modelWithDictionary:dic];
            self.allData = [[NSMutableArray alloc]initWithArray:listModel.data];
            if ([type isEqualToString:@"2"]) {
                if (self.numZRblock) {
                    self.numZRblock([NSString stringWithFormat:@"%lu",(unsigned long)self.allData.count]);
                }
            }
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 列表代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.allData.count +1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 0 ? 40 : 153;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 0 ? 0.1 : 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        Player_TopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZRtop_cellid];
        [cell.Meg_Btn setTitle:@"已存阵容" forState:UIControlStateNormal];
        [cell.Meg_Btn setTitle:@"已存阵容" forState:UIControlStateSelected];
        [cell.Rizhi_Btn setTitle:@"推荐阵容" forState:UIControlStateNormal];
        [cell.Rizhi_Btn setTitle:@"推荐阵容" forState:UIControlStateSelected];
        cell.delegate = self;
        [cell.Meg_Btn addTarget:self action:@selector(YC_BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.Rizhi_Btn addTarget:self action:@selector(TJ_BtnClick:) forControlEvents:UIControlEventTouchUpInside];

        return cell;

    }else{
        ZRTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZR_cellid];
        ZR_ModelDataCell *model = [self.allData objectAtIndex:indexPath.section - 1];
        cell.model = model;
        cell.ZR_lab.text = [NSString stringWithFormat:@"阵容%ld",indexPath.section];
        cell.XZ_Lab.text = [NSString stringWithFormat:@"下注：%@",model.join_room_num];
        cell.ZRJF_Lab.text = [NSString stringWithFormat:@"%0.1f",model.lineup_score];
        cell.GZ_Lab.text = model.salary_sum;
        cell.nba_lol_data = self.nba_lol_data;//竞猜类型
        cell.ZR_Btn.tag = indexPath.section;
        [cell.ZR_Btn addTarget:self action:@selector(ZR_BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
   
}




//选择阵容
- (void)ZR_BtnClick:(UIButton *)Btn{
    ZR_ModelDataCell *model = [self.allData objectAtIndex:Btn.tag-1];
    if (self.chooseZRblock) {
        self.chooseZRblock(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


//已存阵容
- (void)YC_BtnClick:(UIButton *)Btn{
    
    [self initTypeData:@"2"];
    
    
}

//推荐阵容
- (void)TJ_BtnClick:(UIButton *)Btn{
    
    [self initTypeData:@"1"];

  
}






@end



@implementation ZR_ModelData
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [ZR_ModelDataCell class]};
}
@end

@implementation ZR_ModelDataCell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id" };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{ @"lineup_info":[lineup_ModelInfo class]};
    
}
@end

@implementation lineup_ModelInfo
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id" };
}
@end



