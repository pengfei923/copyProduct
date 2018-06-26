//
//  ChengHViewController.m
//  AFM
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "ChengHViewController.h"
#import "ChengHTableViewCell.h"
#import "MyCHTableViewCell.h"

@interface ChengHViewController ()<UITableViewDataSource,UITableViewDelegate>{

}

@property(nonatomic, strong)UITableView *tableView;          //列表视图
@property(nonatomic, strong)NSMutableArray *dataArray;          //
@property(nonatomic, strong)NSMutableArray *myRankArray;          //

@end

@implementation ChengHViewController
NSString *chengHao_cellId = @"ChengHTableViewCell";
NSString *mygHao_cellId   = @"MyCHTableViewCell";

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES]; //显示导航
    self.tabBarController.tabBar.hidden = YES;                    //隐藏tabBar
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
    [self initData];
    [self loadData];
}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"我的称号";
    
}


//初始化界面
- (void)initView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.tableView registerClass:[MyCHTableViewCell class] forCellReuseIdentifier:mygHao_cellId];
    [self.tableView registerClass:[ChengHTableViewCell class] forCellReuseIdentifier:chengHao_cellId];
    
    [self.view addSubview:self.tableView];
    

}

-(void)loadData{
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=user&a=get_user_rank&version=2";
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
            MyChengHaoModel *Model = [MyChengHaoModel yy_modelWithDictionary:dic];
            self.myRankArray = [[NSMutableArray alloc]initWithArray:Model.data];
        }
        
        [self.tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
 }

//初始化全部数据
- (void)initData {
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=user&a=show_all_rank&version=2";
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
            AllChengHaoModel *Model = [AllChengHaoModel yy_modelWithDictionary:dic];
            self.dataArray = [[NSMutableArray alloc]initWithArray:Model.data];
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
    if (section == 0) {
        return self.myRankArray.count/2 + self.myRankArray.count%2;
        
    }else{
        return self.dataArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 38;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_Width, 36.0)];
    bgView.backgroundColor = [UIColor whiteColor];
    UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, screen_Width, 35.0)];
    nameL.textColor = [UIColor getColorWithTextTheme];
    nameL.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:nameL];
    if (section == 0) {
        nameL.text = @"我的勋章称号";
    }else
    {
        nameL.text = @"全部勋章称号";
    }
    UILabel *lineL = [[UILabel alloc]initWithFrame:CGRectMake(0, 35.0, screen_Width, 1)];
    lineL.backgroundColor = [UIColor colorWithRed:231 green:232 blue:232 alpha:1];
    [bgView addSubview:lineL];
    return bgView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.myRankArray.count > 2 ? 168 : 84;
    }else{
        return 84;
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 ) {
        MyCHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mygHao_cellId];
        cell.myRankArray = self.myRankArray;
        cell.RANK = self.RANK;

        cell.Token_cell = self.appCache.loginViewModel.token;
        return cell;
 
    }else{
        ChengHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:chengHao_cellId];
        AllChengHaoModelCell *model = [self.dataArray objectAtIndex:indexPath.row];
      
        [cell.img_View yy_setImageWithURL:[NSURL URLWithString:model.avatar_img] placeholder:[UIImage imageNamed:@""]];
        cell.name_Lab.text = model.name;
        cell.info_Lab.text = model.depict;
        
        return cell;
    }

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}




@end
@implementation AllChengHaoModel
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"data" : [AllChengHaoModelCell class]};
}
@end

@implementation AllChengHaoModelCell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}
@end
@implementation MyChengHaoModel
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"data" : [MyChengHaoModelCell class]};
}
@end

@implementation MyChengHaoModelCell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}
@end







