//
//  AddressView.m
//  AFM
//
//  Created by admin on 2017/9/8.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "AddressView.h"
#import "ADessTableViewCell.h"


@interface AddressView ()<UITableViewDelegate,UITableViewDataSource>{
    int labelNumber;
    float SY_lab;     //剩余次数
    
}

@property (nonatomic , strong) NSMutableArray *addrData;        //数据

@end

@implementation AddressView
NSString *ADess_cellid = @"ADessTableViewCell";


+ (AddressView *)creatInAddressView{
    
    AddressView *view = [[[NSBundle mainBundle]loadNibNamed:@"AddressView" owner:nil options:nil] lastObject];
    return view;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.7];
    
    [self initView];
    [self initData];

}



- (void)initView {
    self.downView.layer.masksToBounds = YES;
    self.downView.layer.cornerRadius = 5;

    self.AtableView.dataSource = self;
    self.AtableView.delegate = self;
    
    self.AtableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.AtableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.AtableView registerClass:[ADessTableViewCell class] forCellReuseIdentifier:ADess_cellid];
    [self.downView addSubview:self.AtableView];

 
}


- (void)initData{
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=shop&a=show_address&version=2";
    NSDictionary *paramters = @{@"user_token":@"token",
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
            AddressListModel *Model = [AddressListModel yy_modelWithDictionary:dic];
            self.addrData = [[NSMutableArray alloc]initWithArray:Model.data];
            
            for (AddressListModelCell *model in Model.data) {
                if ([model.is_default isEqualToString:@"1"]) {   //默认
                    model.isDisP = YES;
                }
            }
        }
        [self.AtableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

    
}

#pragma mark - 列表代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.addrData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ADessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ADess_cellid];
    AddressListModelCell *model = [self.addrData objectAtIndex:indexPath.section];
    cell.name_Lab.text = model.name;
    cell.phone_Lab.text = model.phone;
    cell.address_Lab.text = model.address;
    
    cell.cloose_Btn.tag = indexPath.section;
    if ([model.is_default isEqualToString:@"1"]) {   //默认
        cell.moren_Lab.hidden = NO;
    }else{
        cell.moren_Lab.hidden = YES;
    }
    if (model.isDisP) {
        UIImageView *accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pay-icon-selected"]];
        cell.accessoryView = accessoryView;
    }else {
        UIImageView *accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pay-icon"]];
        cell.accessoryView = accessoryView;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    for (AddressListModelCell *model in self.addrData) {
        model.isDisP = NO;
    }
    AddressListModelCell *paymodel = [self.addrData objectAtIndex:indexPath.section];
    paymodel.isDisP = YES;
    [tableView reloadData];
}

- (IBAction)tureBtnClick:(UIButton *)sender {
    for (AddressListModelCell *model in self.addrData ) {
        if (model.isDisP) {
            if ([_delegate respondsToSelector:@selector(refreshAddr:with:and:andId:)]) {
                [_delegate refreshAddr:model.name with:model.address and:model.phone andId:model.Id];
            }
        }else{
        }
    }
}



@end
