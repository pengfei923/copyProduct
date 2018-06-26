//
//  NameViewController.m
//  AFM
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "NameViewController.h"

@interface NameViewController ()

@end

@implementation NameViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
    [self initData];
}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"修改昵称";
    
}


//初始化界面
- (void)initView {
    self.ture_Btn.layer.masksToBounds = YES;
    self.ture_Btn.layer.cornerRadius = 5;

}

//初始化数据
- (void)initData {
    
    
    
    
}


//保存按钮
- (IBAction)tureBtnClick:(UIButton *)sender {
    
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=user&a=change_username&apptype=app&version=1";
    
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                             @"username":self.name_TextField.text,   };
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
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

}

@end
