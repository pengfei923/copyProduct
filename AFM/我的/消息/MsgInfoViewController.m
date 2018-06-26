//
//  MsgInfoViewController.m
//  AFM
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "MsgInfoViewController.h"

@interface MsgInfoViewController ()<UITextViewDelegate>

@end

@implementation MsgInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
    [self initData];
    [self initInfoMsg];
}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"消息中心";
    
}


//初始化界面
- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.tureTextView.delegate = self;
    self.tureTextView.editable = NO;
}


- (void)initInfoMsg{
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=user&a=notice_detail&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                @"id":self.Id,
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
            NSDictionary *dictionary_data = [dic objectForKey:@"data"];
            self.tureTextView.text = [dictionary_data objectForKey:@"notice"];
            self.title_Lab.text = [dictionary_data objectForKey:@"title"];
            self.time_Lab.text = [dictionary_data objectForKey:@"time"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}



//已读
- (void)initData {
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=user&a=set_notice_state&version=2";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                @"id":self.Id,
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
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}



@end
