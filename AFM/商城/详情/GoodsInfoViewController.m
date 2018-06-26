//
//  GoodsInfoViewController.m
//  AFM
//
//  Created by admin on 2017/9/6.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "GoodsInfoViewController.h"
#import <WebKit/WebKit.h>
#import "Goods_InfoTableViewCell.h"
#import "AddressView.h"
#import "OrderView.h"
#import "AddContactViewController.h"
#import "GoodsInfo1TableViewCell.h"

@interface GoodsInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,WKUIDelegate, WKNavigationDelegate,addressDelegate>{
    
}
@property (nonatomic , strong) UITableView *tableView;            //列表视图
@property (nonatomic , strong) AddressView *addressView;          //选择View
@property (nonatomic , strong) OrderView   *orderView;            //订单View
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, assign) CGFloat webViewHeight;


@end

@implementation GoodsInfoViewController

NSString *goodsInfo_cellad  = @"Goods_InfoTableViewCell";
NSString *goodsInfo1_cellad = @"GoodsInfo1TableViewCell";

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES]; //显示导航
    self.tabBarController.tabBar.hidden = YES;                    //隐藏tabBar
    if (self.goods_ID.length != 0) {
        [self initData];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"商品详情";
}


//初始化界面
- (void)initView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView registerClass:[Goods_InfoTableViewCell class] forCellReuseIdentifier:goodsInfo_cellad];
    [self.tableView registerClass:[GoodsInfo1TableViewCell class] forCellReuseIdentifier:goodsInfo1_cellad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"WebViewCell"];
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
    [self initDPayView];
    
    self.webViewHeight = 0.0;

    [self createWebView];

}

- (void)dealloc{
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)createWebView{
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    wkWebConfig.userContentController = wkUController;
    // 自适应屏幕宽度js
    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    // 添加js调用
    [wkUController addUserScript:wkUserScript];
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1) configuration:wkWebConfig];
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.opaque = NO;
    self.webView.userInteractionEnabled = NO;
    self.webView.scrollView.bounces = NO;
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.webView sizeToFit];
    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.aifamu.com/index.php?m=other&a=goodsdetail&apptype=app&version=1&id=%@",self.goods_ID]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    [self.scrollView addSubview:self.webView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentSize"]) {
        UIScrollView *scrollView = (UIScrollView *)object;
        CGFloat height = scrollView.contentSize.height;
        self.webViewHeight = height;
        self.webView.frame = CGRectMake(0, 0, self.view.frame.size.width, height);
        self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, height);
        self.scrollView.contentSize =CGSizeMake(self.view.frame.size.width, height);
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:2 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    }
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
    [DB_Btn addTarget:self action:@selector(payClick:) forControlEvents:UIControlEventTouchUpInside];
    [downV addSubview:DB_Btn];
    [self.view addSubview: downV];
    
}


//初始化数据
- (void)initData {
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=shop&a=goods_show&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                @"id":self.goods_ID };
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
            NSMutableDictionary *Dic = [[NSMutableDictionary alloc]initWithDictionary:[dic objectForKey:@"data"]];
            GoodsInfoModel *goodsnfoModel = [GoodsInfoModel yy_modelWithDictionary:Dic];
            self.GoodsInfoModel = goodsnfoModel;
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"message:[dic objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
        [self.tableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


#pragma mark - 按钮点击事件
//请求支付---网络
- (void)payClick:(UIButton *)Btn{
    self.addressView = [AddressView creatInAddressView];
    self.addressView.frame = CGRectMake(0, 0, screen_Width, screen_Height-64);
    self.addressView.delegate = self;   //
    [self.view addSubview:self.addressView];
    [self.addressView.addAd_Btn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.addressView.ture_Btn addTarget:self action:@selector(tureClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.addressView.button1 addTarget:self action:@selector(hiddenAddressClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.addressView.button2 addTarget:self action:@selector(hiddenAddressClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)refreshAddr:(NSString *)name with:(NSString *)addr and:(NSString *)phone andId:(NSString *)Id {
    self.name_L = name;
    self.phone_L = phone;
    self.addr_L = addr;
    self.ID_L = Id;
}

//添加地址
- (void)addClick:(UIButton *)Btn{
    AddContactViewController *addVC = [[AddContactViewController alloc] init];
    [addVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:addVC animated:YES];
}


//确认
- (void)tureClick:(UIButton *)Btn{
    self.addressView.hidden = YES;
   
    self.orderView = [OrderView creatInorderView];
    self.orderView.frame = CGRectMake(0, 0, screen_Width, screen_Height-64);
    [self.view addSubview:self.orderView];
    //总消耗
    if (self.NumF) {
        float FNum = [[NSString stringWithFormat:@"%@",self.NumF] floatValue];
        float FPrice = [[NSString stringWithFormat:@"%@",self.GoodsInfoModel.price] floatValue];
        self.orderView.price_Lab.text = [NSString stringWithFormat:@"%0.f",FPrice * FNum] ;
    }else{
        self.NumF = @"1";
        float FNum = [[NSString stringWithFormat:@"%@",self.NumF] floatValue];
        float FPrice = [[NSString stringWithFormat:@"%@",self.GoodsInfoModel.price] floatValue];
        self.orderView.price_Lab.text = [NSString stringWithFormat:@"%0.f",FPrice * FNum] ;
    }
    

    self.orderView.name_lab.text = self.GoodsInfoModel.name;
    self.orderView.guige_lab.text = @"规格：虚拟商品";
    self.orderView.num_Lab.text = [NSString stringWithFormat:@"数量：%@",self.NumF];
    self.orderView.name_phone.text = [NSString stringWithFormat:@"地址：%@ %@",self.name_L,self.phone_L];
    self.orderView.address_L.text = self.addr_L;

    [self.orderView.button1 addTarget:self action:@selector(hiddenOrderClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView.button2 addTarget:self action:@selector(hiddenOrderClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView.cancelBtn addTarget:self action:@selector(hiddenOrderClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView.tureBtn addTarget:self action:@selector(tureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    

}


// 确认兑换
- (void)tureBtnClick:(UIButton *)Btn{
    [UIView animateWithDuration:0.5f animations:^{
        self.orderView.hidden = YES;
    }];
    
    [self payGoods];
}


- (void)payGoods{
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=shop&a=goods_buy&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                @"goods_id":self.goods_ID,       //商品Id
                                @"nums":self.NumF,             //数量
                                @"value":@"默认",               //规格
                                @"address_id":self.ID_L,         //地址Id
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
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[dic objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//隐藏地址
- (void)hiddenAddressClick:(UIButton *)Btn{
    self.addressView.hidden = YES;
}

//隐藏订单
- (void)hiddenOrderClick:(UIButton *)Btn{
    self.orderView.hidden = YES;
}



#pragma mark - 列表代理

//Header高度
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

//单元格数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

//单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return (self.mainWidth/5) *2 + 115;
    }else if (indexPath.row == 1) {
        return 40;
    }else{
        return _webViewHeight;
    }
}


//单元格视图
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        Goods_InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsInfo_cellad];
        cell.name_Lab.text = self.GoodsInfoModel.name;
        cell.price_Lab.text = self.GoodsInfoModel.price;
        cell.MaxNum = [self.GoodsInfoModel.has_nums intValue];
        //数量
        cell.returnValueBlock = ^(NSString *strValue){
            self.NumF = strValue;
        };
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];  //取消点击效果
        //轮播
        if (self.GoodsInfoModel.album.count > 0) {
            cell.headerview.ad_array = self.GoodsInfoModel.album;
        }
        if ([self.GoodsInfoModel.type isEqualToString:@"1"]) { // 钻石
            cell.priceImg_View.image = [UIImage imageNamed:@"Diamonds-red"];
        }else{
            cell.priceImg_View.image = [UIImage imageNamed:@"wood-red"];
        }
        return cell;

    }else if (indexPath.row == 1) {
        GoodsInfo1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsInfo1_cellad];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消点击效果
        cell.title_Lab.text = self.GoodsInfoModel.intro;
        return cell;
            
    }else{
        UITableViewCell *webCell = [tableView dequeueReusableCellWithIdentifier:@"WebViewCell" forIndexPath:indexPath];
        [webCell.contentView addSubview:self.scrollView];
        return webCell;
    }
   
}





@end





@implementation GoodsInfoModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}
@end
@implementation GoodsInfoIMGModelCell
@end


