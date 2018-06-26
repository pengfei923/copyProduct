//
//  AddZuanViewController.m
//  AFM
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "AddZuanViewController.h"
#import "AddZuanTableViewCell.h"
#import "PayTableViewCell.h"
#import "GiveZTableViewCell.h"
#import <StoreKit/StoreKit.h>



#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define ARedColor      [UIColor colorWithRed:215/255.0 green:56/255.0 blue:63/255.0 alpha:1]

//沙盒测试环境验证
#define SANDBOX @"https://sandbox.itunes.apple.com/verifyReceipt"
//正式环境验证
#define AppStore @"https://buy.itunes.apple.com/verifyReceipt"

@interface AddZuanViewController ()<UITableViewDelegate , UITableViewDataSource,UITextFieldDelegate,SKPaymentTransactionObserver,SKProductsRequestDelegate>{
    NSString *Name_;
    NSString *data_Return;  //传给后台的支付返回值
    UIButton *DB_Btn;
    
}
@property (nonatomic , strong) UITableView *tableView;          //列表视图
@property (nonatomic,strong) NSArray *profuctIdArr;
@property (nonatomic,copy) NSString *currentProId;

@end

@implementation AddZuanViewController
//static bool hasAddObersver = NO;

NSString *addZuan_cellid = @"AddZuanTableViewCell";
NSString *pay_cellid = @"PayTableViewCell";
NSString *give_cellid = @"GiveZTableViewCell";

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self initData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
    [self initPay];

}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"钻石充值";
}

//支付
- (void)initPay{
    //设置支付服务  - 添加一个交易队列观察者
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
 
}

//初始化数据
- (void)initData {
    NSString *urlStr = @"http://api.aifamu.com/index.php?g=api&m=user&a=first_charge&apptype=app&version=1";
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
        __weak typeof(self) weakSelf = self;
        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"error"]isEqualToNumber:@0]) {
            weakSelf.isSH_C = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"] objectForKey:@"first_charge"]];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

//初始化界面
- (void)initView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50 - 64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight ;
    [self.tableView registerClass:[AddZuanTableViewCell class] forCellReuseIdentifier:addZuan_cellid];
    [self.tableView registerClass:[PayTableViewCell class] forCellReuseIdentifier:pay_cellid];
    [self.tableView registerClass:[GiveZTableViewCell class] forCellReuseIdentifier:give_cellid];
    [self.view addSubview:self.tableView];
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.PriceL = [NSString stringWithFormat:@"6"];
    
    [self initPayView];
}


//支付按钮
- (void)initPayView {
    //底部View
    UIView *downV = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50-64, SCREEN_WIDTH, 50)];
    downV.backgroundColor = [UIColor clearColor];
    //立即支付
    DB_Btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    [DB_Btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [DB_Btn setTitle:[NSString stringWithFormat:@"立即支付%@元",self.PriceL] forState:UIControlStateNormal];
    [DB_Btn setBackgroundColor:ARedColor];
    [DB_Btn addTarget:self action:@selector(payClick:) forControlEvents:UIControlEventTouchUpInside];
    [downV addSubview:DB_Btn];
    [self.view addSubview: downV];
}

- (void)payClick:(UIButton *)btn{
    //如果app允许applepay
    //self.productIds是在开发者平台填写的产品id
    if ([self.PriceL isEqualToString:@"6"]) {
        self.productId = @"com.aifamu06";
    }else if ([self.PriceL isEqualToString:@"30"]){
        self.productId = @"com.aifamu30";
    }else if ([self.PriceL isEqualToString:@"98"]){
        self.productId = @"com.aifamu98";
    }else if ([self.PriceL isEqualToString:@"198"]){
        self.productId = @"com.aifamu198";
    }else if ([self.PriceL isEqualToString:@"328"]){
        self.productId = @"com.aifamu328";
    }else if ([self.PriceL isEqualToString:@"648"]){
        self.productId = @"com.aifamu648";
    }else{

    }

    if ([SKPaymentQueue canMakePayments]) {
        [self requestProductData:self.productId];
    }else{
        NSLog(@"不允许程序内付费");
    }
}

//请求苹果商品
- (void)requestProductData:(NSString *)productId {
    NSArray *productArr = [[NSArray alloc]initWithObjects:productId, nil];
    NSSet *productSet = [NSSet setWithArray:productArr];
    SKProductsRequest *request = [[SKProductsRequest alloc]initWithProductIdentifiers:productSet];
    request.delegate = self;
    //开始请求
    [request start];
}

// 10.接收到产品的返回信息,然后用返回的商品信息进行发起购买请求   --SKProductsRequestDelegate
- (void) productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    NSArray *product = response.products;
    
    //如果服务器没有产品
    if([product count] == 0){
        NSLog(@"没有该商品");
        return;
    }
    
    SKProduct *requestProduct = nil;
    for (SKProduct *pro in product) {
        NSLog(@"11-%@", [pro description]);
        NSLog(@"22-%@", [pro localizedTitle]);
        NSLog(@"33-%@", [pro localizedDescription]);
        NSLog(@"44-%@", [pro price]);
        NSLog(@"55-%@", [pro productIdentifier]);
        
        Name_ = [pro localizedTitle];
        // 11.如果后台消费条目的ID与我这里需要请求的一样（用于确保订单的正确性）
        if([pro.productIdentifier isEqualToString:self.productId]){
            requestProduct = pro;
        }
    }
    
    // 12.发送购买请求
    SKPayment *payment = [SKPayment paymentWithProduct:requestProduct];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"error:%@", error);
    [SVProgressHUD showErrorWithStatus:@"支付失败"];
}

//反馈请求的产品信息结束后
- (void)requestDidFinish:(SKRequest *)request{
     [SVProgressHUD dismiss];
     NSLog(@"信息反馈结束");
}

// 13.监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction{
    for(SKPaymentTransaction *tran in transaction){
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:
                NSLog(@"交易完成");
                // 发送到苹果服务器验证凭证
                [self verifyPurchaseWithPaymentTrasaction];
                //自己服务器验证
                [self initSeyseData];
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加进列表");
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"已经购买过商品");
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"交易失败");
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                break;
            default:
                break;
        }
    }
}


// 14.交易结束,当交易结束后还要去appstore上验证支付信息是否都正确,只有所有都正确后,我们就可以给用户方法我们的虚拟物品了。
- (void)verifyPurchaseWithPaymentTrasaction{
    //测试验证地址:https://sandbox.itunes.apple.com/verifyReceipt
    //正式验证地址:https://buy.itunes.apple.com/verifyReceipt

    // 验证凭据，获取到苹果返回的交易凭据
    // appStoreReceiptURL iOS7.0增加的，购买交易完成后，会将凭据存放在该地址
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    // 从沙盒中获取到购买凭据 // 把文件转成数据流
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptURL];

    NSString *encodeStr = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

    data_Return = encodeStr;

    // 设置请求参数(key是苹果规定的)
    NSDictionary *param = @{@"receipt-data":encodeStr};
    // 获取网络管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求格式为json
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 发出请求
    [manager POST:AppStore parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
        if ([[responseObject objectForKey:@"status"]isEqualToNumber:@21007]) {
            NSLog(@"%@", responseObject);
         
            [manager POST:SANDBOX parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task1, id  _Nullable responseObject1) {
                NSLog(@"responseObject111111 = %@", responseObject1);
                
            } failure:^(NSURLSessionDataTask * _Nullable task1, NSError * _Nonnull error1) {
                NSLog(@"error = %@", error1);
            }];
          
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@", error);
    }];

}

//结束后一定要销毁
- (void)dealloc{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

//返回给本地服务器--苹果支付base64位收据
- (void)initSeyseData{
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=user&a=appstore_pay&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                             @"apple_receipt":data_Return,
                             @"money":[NSString stringWithFormat:@"appsotory%@",self.PriceL] };

    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
    [manager setSecurityPolicy:[AFMHTTPSManager customSecurityPolicy]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST: urlStr parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
}


#pragma mark - 列表代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        return 200;
    }else if (indexPath.section == 1){
        return 80;
    }else{
        return 210;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        AddZuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:addZuan_cellid];
        if ([_isSH_C isEqualToString:@"1"]) { //已经首充
            if (cell.isSH_Block) {
                //将自己的值传出去，完成传值
                cell.isSH_Block( @"1" );
            }
        }else{
            if (cell.isSH_Block) {
                //将自己的值传出去，完成传值
                cell.isSH_Block( @"2" );
            }
        }

        __weak typeof(self) weakSelf = self;
        cell.PriceValueBlock = ^(NSString *Price) {
            weakSelf.PriceL = Price;
        };

        [cell.button1 addTarget:self action:@selector(payNumberClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button2 addTarget:self action:@selector(payNumberClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button3 addTarget:self action:@selector(payNumberClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button4 addTarget:self action:@selector(payNumberClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button5 addTarget:self action:@selector(payNumberClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button6 addTarget:self action:@selector(payNumberClick:) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }else if (indexPath.section == 1){
        PayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pay_cellid];
        
        [cell.alipay_Btn addTarget:self action:@selector(payTypeClick:) forControlEvents:UIControlEventTouchUpInside];
      
        return cell;
    }else{
        GiveZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:give_cellid];
        NSString *lab1R = @"首次单笔充值￥6，赠送6钻石.";
        NSString *lab2R = @"首次单笔充值￥30，赠送18钻石.";
        NSString *lab3R = @"首次单笔充值￥98，赠送58钻石.";
        NSString *lab4R = @"首次单笔充值￥198，赠送118钻石.";
        NSString *lab5R = @"首次单笔充值￥328，赠送208钻石.";
        NSString *lab6R = @"首次单笔充值￥648，赠送478钻石.";

        //1设置显示成红色
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString:lab1R];
        [str1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(11, 1)];
        cell.lab1.attributedText = str1;

        //2设置显示成红色
        NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString:lab2R];
        [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(12, 2)];
        cell.lab2.attributedText = str2;
        
        //3设置显示成红色
        NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc]initWithString:lab3R];
        [str3 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(12, 2)];
        cell.lab3.attributedText = str3;
        
        //4设置显示成红色
        NSMutableAttributedString *str4 = [[NSMutableAttributedString alloc]initWithString:lab4R];
        [str4 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(13, 3)];
        cell.lab4.attributedText = str4;
        
        //5设置显示成红色
        NSMutableAttributedString *str5 = [[NSMutableAttributedString alloc]initWithString:lab5R];
        [str5 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(13, 3)];
        cell.lab5.attributedText = str5;
        
        //6设置显示成红色
        NSMutableAttributedString *str6 = [[NSMutableAttributedString alloc]initWithString:lab6R];
        [str6 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(13, 3)];
        cell.lab6.attributedText = str6;
        return cell;
    }
}


//支付类型
- (void)payTypeClick:(UIButton *)Btn{


}

- (void)payNumberClick:(UIButton *)Btn{
    [DB_Btn setTitle:[NSString stringWithFormat:@"立即支付%@元",self.PriceL] forState:UIControlStateNormal];
   
}

@end
