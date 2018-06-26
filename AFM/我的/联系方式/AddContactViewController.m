//
//  AddContactViewController.m
//  AFM
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "AddContactViewController.h"

@interface AddContactViewController ()

@end

@implementation AddContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
}

//初始化导航栏
- (void)initNavigation {
    
    if (self.Id.length == 0 ) {
        self.navigationItem.title = @"添加联系方式";
    }else{
        self.navigationItem.title = @" 编辑联系方式";
    }
    
}


//初始化界面
- (void)initView {
    self.name_TF.text = self.name_L;
    self.phone_TF.text = self.Phone_L;
    self.address_TF.text = self.address_L;
    
}



//保存按钮
- (IBAction)addButtonClick:(UIButton *)sender {
    if (self.name_TF.text.length < 1) {
        [AppDelegate notificationRequestInfoWithStatus:@"请填写真实姓名"];
        return;
    }
    if (self.address_TF.text.length < 1){
        [AppDelegate notificationRequestInfoWithStatus:@"请填写真实地址"];
        return;

    }
    
    if (self.Id.length == 0) {
        [self initAddData];

    }else{     // 编辑
        [self initPlayData];

    }

}


//编辑---网络请求
- (void)initPlayData {
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=shop&a=edit_address&version=2";
    
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                @"id":self.Id,
                                @"name":self.name_TF.text,
                                @"phone":self.phone_TF.text,
                                @"address":self.address_TF.text,
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
            UIViewController *vc = self.navigationController.viewControllers[1];
            [self.navigationController popToViewController:vc animated:YES];
        }else if ([[dic objectForKey:@"error"]isEqualToNumber:@7]){
            [AppDelegate notificationRequestInfoWithStatus:[dic objectForKey:@"msg"]];
        }else{
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

//添加---网络请求
- (void)initAddData {
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=shop&a=add_address&apptype=app&version=1";
    
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                @"name":self.name_TF.text,
                                @"phone":self.phone_TF.text,
                                @"address":self.address_TF.text,
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

            [self.navigationController popViewControllerAnimated:YES];
        }else if ([[dic objectForKey:@"error"]isEqualToNumber:@7]){
             [AppDelegate notificationRequestInfoWithStatus:[dic objectForKey:@"msg"]];
        }else{
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}
    
@end
