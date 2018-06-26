//
//  ViewController_Page3.m
//  CarServiceO2O
//
//  Created by 华四MAC on 16/7/18.
//  Copyright © 2016年 华四MAC. All rights reserved.
//

#import "ViewController_Page3.h"
#import "StoreTopTableViewCell.h"
#import "StoreTableHeaderView.h"
#import "GoodsTableViewCell.h"
#import "MoreGoodsViewController.h"
#import "OrderViewController.h"
#import "AddZuanViewController.h"
#import "GoodsInfoViewController.h"
#import "MenpiaoViewController.h"
#import "RotaryViewController.h"


@interface ViewController_Page3 ()<UITableViewDataSource,UITableViewDelegate>{
    
}
@property (nonatomic , strong) NSMutableArray <GoodsListModelCell *> *dataArray;
@property (nonatomic , strong) UITableView *tableView;            //列表视图
@property (nonatomic , strong) StoreTableHeaderView *myheaderview;
@property (nonatomic , strong) GoodsModel_Info *goodsModel;

@end

@implementation ViewController_Page3
NSString *StoreTop_cellad = @"StoreTopTableViewCell";
NSString *Goods_cellad = @"GoodsTableViewCell";

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES]; //显示导航
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"商城";
//    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"订单" style:UIBarButtonItemStyleDone target:self action:@selector(order_tapClick:)];
//    self.navigationItem.rightBarButtonItem = rightBtn;
//    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
//    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName, nil] forState:UIControlStateNormal];

}

//初始化界面
- (void)initView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = self.myheaderview;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView registerClass:[StoreTopTableViewCell class] forCellReuseIdentifier:StoreTop_cellad];
    [self.tableView registerClass:[GoodsTableViewCell class] forCellReuseIdentifier:Goods_cellad];
    [self.view addSubview:self.tableView];
}

//bandana
- (StoreTableHeaderView *)myheaderview {
    if (!_myheaderview) {
        _myheaderview = [[StoreTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.mainWidth, (self.mainWidth/5) *2)];
        _myheaderview.controller = self;
    }
    return _myheaderview;
}

//初始化数据
- (void)initData {
    [self upDataAll];
    NSLog(@"-----%@",self.appCache.Status );
}

//请求网络
- (void)upDataAll{
    NSString *urlStr = ApiUserGoods_home;
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
            GoodsListModel *newListModel = [GoodsListModel yy_modelWithDictionary:dic];
            self.dataArray = [[NSMutableArray alloc]initWithArray:newListModel.data];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


#pragma mark - 列表代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dataArray.count ;
    return self.dataArray.count +1 ;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        if (screen_Height == 812) {
            return (screen_Height - 320);
        }else{
            return (screen_Height - 240);
        }
    }else if (indexPath.row == 1){
        if ([self.appCache.Status isEqualToString:@"1"]) {
            return 195;
        }else{
            return 0.1;
        }
    }else{
        if ([self.appCache.Status isEqualToString:@"1"]) {
            return 345;
        }else{
            return 0.1;
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
    if (indexPath.row == 0) {
        StoreTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:StoreTop_cellad];
        if (self.appCache.Zuanshi.length == 0) {
           cell.zuan_Lab.text = [NSString stringWithFormat:@"钻石：%@",self.appCache.loginViewModel.diamond];
           cell.mu_Lab.text = [NSString stringWithFormat:@"木头：%@",self.appCache.loginViewModel.gold];
        }else{
           cell.zuan_Lab.text = [NSString stringWithFormat:@"钻石：%@",self.appCache.Zuanshi];
           cell.mu_Lab.text = [NSString stringWithFormat:@"木头：%@",self.appCache.gold];
        }
        [cell.button1 addTarget:self action:@selector(button1Click:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button2 addTarget:self action:@selector(button2Click:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button3 addTarget:self action:@selector(button3Click:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }else{
        NSString *cellIdent = [NSString stringWithFormat:@"cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
        GoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
        if (cell == nil) {
            cell = [[GoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Goods_cellad];
            GoodsListModelCell *model = [self.dataArray objectAtIndex:indexPath.row - 1];
            cell.model = model;
            cell.controller = self;
            cell.Top_Lab.text = model.list;
            if (indexPath.row == 2) {
                cell.more_Btn.tag = 1;
                [cell.more_Btn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }else if(indexPath.row == 3){
                cell.more_Btn.tag = 2;
                [cell.more_Btn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                cell.more_Btn.hidden = YES;
            }
        }
        return cell;
    }
}

#pragma mark - 按钮点击事件
//更多
- (void)moreBtnClick:(UIButton *)Btn{
    GoodsListModelCell *gModel = [self.dataArray objectAtIndex:Btn.tag];
    MoreGoodsViewController *InfoView = [[MoreGoodsViewController alloc] init];
    InfoView.typeName = gModel.list;
    [InfoView setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:InfoView animated:YES];
}

//导航栏--订单
//- (void)order_tapClick:(UIButton *)Btn {
//    OrderViewController *orserVC = [[OrderViewController alloc] init];
//    [orserVC setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:orserVC animated:YES];
//}

//充值
- (void)button1Click:(UIButton *)Btn {
     //上架原因
    AddZuanViewController *addZ = [[AddZuanViewController alloc]init];
    addZ.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addZ animated:YES];
}

//兑换门票
- (void)button2Click:(UIButton *)Btn {
    MenpiaoViewController *infoView = [[MenpiaoViewController alloc]init];
    infoView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:infoView animated:YES];   
}

//大转盘
- (void)button3Click:(UIButton *)Btn {
    RotaryViewController *ZPView = [[RotaryViewController alloc]init];
    ZPView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ZPView animated:YES];

}


@end





//
@implementation GoodsListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [GoodsListModelCell class]};
}
@end


//
@implementation GoodsListModelCell
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"goods":[GoodsModel_Info class]};
    
}

@end


//
@implementation GoodsModel_Info
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}
@end






