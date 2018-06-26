//
//  SuggestViewController.m
//  AFM
//
//  Created by admin on 2017/9/1.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "SuggestViewController.h"
#import "WENTextView.h"

@interface SuggestViewController ()
@property (weak, nonatomic) IBOutlet WENTextView *SuggestView;

@end

@implementation SuggestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
}


//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"意见反馈";
}


//初始化界面
- (void)initView {
    self.ture_Btn.layer.cornerRadius = 5;
    self.SuggestView.placeholder = @"请输入反馈问题";

}


- (IBAction)ture_BtnClick:(UIButton *)sender {
    
    if (self.SuggestView.text.length > 0) {
        [self initData];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"message:@"请输入反馈意见" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}


- (void)initData {
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=shop&a=customer_care&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                @"question":self.SuggestView.text,
                                @"content":self.SuggestView.text,
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
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"message:[dic objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                [self.navigationController popToRootViewControllerAnimated:YES];
            }];

            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


@end
