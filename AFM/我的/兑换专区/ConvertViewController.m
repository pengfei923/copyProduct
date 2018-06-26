//
//  ConvertViewController.m
//  AFM
//
//  Created by admin on 2017/9/11.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "ConvertViewController.h"
#import "ConvertTableViewCell.h"


@interface ConvertViewController ()<UITableViewDelegate,UITableViewDataSource>{

}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *turn_TF;
@property (weak, nonatomic) IBOutlet UIView *noView;
@property (nonatomic , strong) NSMutableArray *listData;

@end

@implementation ConvertViewController
NSString *Con_cellId = @"ConvertTableViewCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
    [self initData];
}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"兑换专区";
    
}


//初始化界面
- (void)initView {
    self.turn_Btn.layer.masksToBounds = YES;
    self.turn_Btn.layer.cornerRadius = 6;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor getColorWithdown];
    [self.tableView registerClass:[ConvertTableViewCell class] forCellReuseIdentifier:Con_cellId];
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    if (self.listData.count == 0) {
        self.noView.hidden = NO;
    }else{
        self.noView.hidden = YES;

    }

}

//初始化数据
- (void)initData {
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=award&a=redcode_list&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token};
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
            ConvertModel *listModel = [ConvertModel yy_modelWithDictionary:dic];
            self.listData = [[NSMutableArray alloc]initWithArray:listModel.data];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

    
}
//兑换按钮
- (IBAction)turn_BtnClick:(UIButton *)sender {
    if (!(self.turn_TF.text.length == 0)) {
        NSString *urlStr = @"http://api.aifamu.com/index.php?m=award&a=check_redcode&apptype=app&version=1";
        NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                    @"codes":self.turn_TF.text};
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
            }else{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"message:[dic objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"message:@"请输入正确的兑换码" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - 列表代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ConvertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Con_cellId];
    ConvertModelCell *model = [self.listData objectAtIndex:indexPath.row];
    cell.time_Lab.text = model.updatetime;
    
    if ([model.type isEqualToString:@"1"]) {//1为门票，2为砖石，3为木头
        cell.type_Img.image = [UIImage imageNamed:@"ticket-red@"];
        cell.title_Lab.text = [NSString stringWithFormat:@"门票 x %@",model.prize];
    }else if ([model.type isEqualToString:@"2"]){
        cell.type_Img.image = [UIImage imageNamed:@"Diamonds-red"];
        cell.title_Lab.text = [NSString stringWithFormat:@"钻石 x %@",model.prize];
    }else{
        cell.type_Img.image = [UIImage imageNamed:@"wood-red"];
        cell.title_Lab.text = [NSString stringWithFormat:@"木头 x %@",model.prize];
    }
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
}





@end



@implementation ConvertModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [ConvertModelCell class]};
}
@end

@implementation ConvertModelCell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}

@end








