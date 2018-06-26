//
//  LoginViewController.m
//  AFM
//
//  Created by admin on 2017/9/1.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "AFMHTTPSManager.h"



@interface LoginViewController ()

@end

@implementation LoginViewController


- (void)CloseLogin{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor getColorWithR:230 G:233 B:232 A:1];
    self.navigationController.navigationBar.barTintColor = [UIColor getColorWithR:27 G:27 B:27 A:1];
    self.navigationController.navigationBar.translucent = NO;
    [self creatUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)creatUI{
    //top 账号登录
    UILabel *topTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    topTitleLabel.text  = @"账号登录";
    topTitleLabel.font = [UIFont systemFontOfSize:20];
    topTitleLabel.textAlignment = NSTextAlignmentCenter;
    topTitleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = topTitleLabel;
    
    //登录栏
    NSArray *imageArray = @[@"login-user",@"login-pwd"];
    NSArray *placeH = @[@"请输入手机号码",@"请输入登录密码"];
    NSArray *btnTitle = @[@"注册账号",@"忘记密码"];
    
    for (int i = 0; i < 2; i++) {
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20.0/375.0 *screen_Width+50.0/375.0 *screen_Width*i, screen_Width, 1)];
        lineLabel.backgroundColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1];
        [self.view addSubview:lineLabel];
        
        UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(20.0/375.0 *screen_Width, 32.0/375.0 *screen_Width + 50.0/375.0 *screen_Width*i, 17.0/375.0 *screen_Width, 19.0/375.0 *screen_Width)];
        im.image = [UIImage imageNamed:imageArray[i]];
        [self.view addSubview:im];
        //密码TextField
        UITextField *textF = [[UITextField alloc]initWithFrame:CGRectMake(60.0/375.0 *screen_Width, 34.0/375.0 *screen_Width +50.0/375.0 *screen_Width*i, screen_Width - 120.0/375.0 *screen_Width, 20.0/375.0 *screen_Width)];
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:placeH[i]];
        [placeholder addAttribute:NSForegroundColorAttributeName
                            value:[UIColor getColorWithR:174 G:174 B:174 A:1]
                            range:NSMakeRange(0, [placeH[i] length])];
        [placeholder addAttribute:NSFontAttributeName
                            value:[UIFont boldSystemFontOfSize:14]
                            range:NSMakeRange(0, [placeH[i] length])];
        textF.attributedPlaceholder = placeholder;
        textF.tag = 6589+i;
        if (i == 1) {
            textF.secureTextEntry = YES;
        }
        textF.font = [UIFont systemFontOfSize:12];
        [textF addTarget:self action:@selector(passwordChanged:) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:textF];
        
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame = CGRectMake(screen_Width - 150.0/375.0 *screen_Width + 70.0/375.0 *screen_Width * i, 132.0/375.0 *screen_Width , 70.0/375.0 *screen_Width, 20.0/375.0 *screen_Width);
        [btn setTitle:btnTitle[i] forState:UIControlStateNormal];
        
        btn.tag = 7899 + i;
        [btn setTitleColor:[UIColor colorWithRed:123/255.0 green:139/255.0 blue:170/255.0 alpha:1] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(reBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.view addSubview:btn];
    }
    
    //分割线
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 118.0/375.0 *screen_Width, screen_Width, 1)];
    lineLabel.backgroundColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1];
    [self.view addSubview:lineLabel];
    
    UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(screen_Width - 81.0/375.0 *screen_Width, 135.0/375.0 *screen_Width, 2, 12.0/375.0 *screen_Width)];
    lineLabel1.backgroundColor = [UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1];
    [self.view addSubview:lineLabel1];
    
    //登录按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.userInteractionEnabled = NO;
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    loginBtn.backgroundColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1];
    loginBtn.frame = CGRectMake(10.0/375.0 *screen_Width, 170.0/375.0 *screen_Width, screen_Width - 20.0/375.0 *screen_Width, 47.0/375.0 *screen_Width);
    loginBtn.layer.cornerRadius = 8;
    loginBtn.tag = 6654;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    /**
    //上架原因
    //分割线
    UILabel *lineLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(10.0/375.0 *screen_Width,323/375.0*screen_Width, screen_Width - 20.0/375.0 *screen_Width, 1)];
    lineLabel2.backgroundColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1];
    [self.view addSubview:lineLabel2];
    
    UILabel *lineLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(screen_Width/2 - 50.0/375.0 *screen_Width , 320.0/375.0*screen_Width, 100.0/375.0 *screen_Width, 20.0/375.0 *screen_Width)];
    lineLabel3.text = @"第三方登录";
    lineLabel3.textAlignment = NSTextAlignmentCenter;
    lineLabel3.backgroundColor = [UIColor getColorWithR:230 G:233 B:232 A:1];
    lineLabel3.font = [UIFont boldSystemFontOfSize:13];
    lineLabel3.textColor = [UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1];
    [self.view addSubview:lineLabel3];
    
    NSArray *cooperationArray = @[@"qq",@"wx",@"wb"];
    
    for (int i = 0; i < 3; i ++) {
        UIButton *cooperationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cooperationBtn.frame = CGRectMake(screen_Width / 2 - 104.0/375.0*screen_Width + 85.0/375.0 *screen_Width * i,
                                          354.0/375.0*screen_Width,
                                          49.0/375.0 *screen_Width,
                                          49.0/375.0 *screen_Width);
        [cooperationBtn setBackgroundImage:[UIImage imageNamed:cooperationArray[i]] forState:UIControlStateNormal];
        cooperationBtn.layer.cornerRadius = 3;
        cooperationBtn.tag = 5644 + i;
        [cooperationBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cooperationBtn.layer.masksToBounds = YES;
        [self.view addSubview:cooperationBtn];
    }
    UITextField *textF = (UITextField *)[self.view viewWithTag:6589];
    UITextField *textF1 = (UITextField *)[self.view viewWithTag:6590];
    [self setResultBlock:^(NSString *str, NSString *str1) {
        textF.text = str;
        textF1.text = str1;
    }];
    */
}

#pragma mark -----------密码键盘点击事件
-(void)passwordChanged:(UITextField *)textF{
    UITextField *textField = (UITextField *)[self.view viewWithTag:6589];
    UITextField *textField1 = (UITextField *)[self.view viewWithTag:6590];
    if (textF.tag == 6590) {
        if (textF.text.length > 0) {
            if (textField.text.length > 0) {
                UIButton *loginBtn = (UIButton *)[self.view viewWithTag:6654];
                loginBtn.backgroundColor = [UIColor colorWithRed:100/255.0 green:121/255.0 blue:161/255.0 alpha:1];
                loginBtn.userInteractionEnabled = YES;
            }
        }
    }
    if (textF.tag == 6589) {
        if (textF.text.length > 0) {
            if (textField1.text.length > 0) {
                UIButton *loginBtn = (UIButton *)[self.view viewWithTag:6654];
                loginBtn.backgroundColor = [UIColor colorWithRed:100/255.0 green:121/255.0 blue:161/255.0 alpha:1];
                loginBtn.userInteractionEnabled = YES;
                
            }
        }
    }
    
}

//判断手机号码格式是否正确
- (BOOL)valiMobile:(NSString *)mobile{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11){
        return NO;
    }else{
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

#pragma mark -----------登录按钮
- (void)loginBtnClick:(UIButton *)loginBtn{
    [AppDelegate notificationRequestComplete:@""];
    NSString *urlStr = @"http://api.aifamu.com/index.php?version=1&apptype=app&g=api&m=public&a=login_do";

    //     [self loginToBBS];
    UITextField *textF = (UITextField *)[self.view viewWithTag:6589];
    UITextField *textF1 = (UITextField *)[self.view viewWithTag:6590];
    //账号密码登录
    if (loginBtn.tag == 6654) {
        //整体数据请求
        if ([self valiMobile:textF.text]) {
            NSDictionary *paramters = @{@"phone":textF.text,
                                        @"pwd":textF1.text,
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
                    NSMutableDictionary *Dic = [[NSMutableDictionary alloc]initWithDictionary:[dic objectForKey:@"data"]];
                    
                    UserInfoModel *loginModel  = [UserInfoModel yy_modelWithDictionary:Dic];
                    self.appCache.loginViewModel = loginModel;
                    self.appCache.token = loginModel.token;
                    self.appCache.menPiao = loginModel.entrance_ticket;
                    self.appCache.Zuanshi = loginModel.diamond;
                    self.appCache.gold = loginModel.gold;

                    [self CloseLogin];
                    [UIApplication sharedApplication].keyWindow.rootViewController = [[BaseTabBarController alloc]init];

                }else{
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:[dic objectForKey:@"msg"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alertView show];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

            }];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"错误" message:@"请输入正确的手机号" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        }
    }
    
    //qq登录
    if (loginBtn.tag == 5644){
        [[UMSocialManager defaultManager]  authWithPlatform:UMSocialPlatformType_QQ currentViewController:self completion:^(id result, NSError *error) {
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[error.userInfo objectForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alertView show];
            } else {
                UMSocialAuthResponse *authresponse = result;
                [self sendInfoWithType:@"qq" andWithOpenID:authresponse.openid andWith:authresponse.accessToken];
            }
        }];
        
//            [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
//                if (error) {
//                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[error.userInfo objectForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//                    [alertView show];
//  
//                } else {
//                    UMSocialUserInfoResponse *resp = result;
//                    [self sendInfoWithType:@"qq" andWithOpenID:resp.openid andWith:resp.accessToken];
// 
//                    // 授权信息
//                    NSLog(@"Sina uid: %@", resp.uid);
//                    NSLog(@"Sina accessToken: %@", resp.accessToken);
//                    NSLog(@"Sina refreshToken: %@", resp.refreshToken);
//                    NSLog(@"Sina expiration: %@", resp.expiration);
//                    
//                    // 用户信息
//                    NSLog(@"Sina name: %@", resp.name);
//                    NSLog(@"Sina iconurl: %@", resp.iconurl);
//                    NSLog(@"Sina gender: %@", resp.unionGender);
//                    
//                    // 第三方平台SDK源数据
//                    NSLog(@"Sina originalResponse: %@", resp.originalResponse);
//                }
//            }];
        
            
    }
    //微信登录
    if (loginBtn.tag == 5645) {
        [[UMSocialManager defaultManager]  authWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[error.userInfo objectForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alertView show];
            } else {
                UMSocialAuthResponse *authresponse = result;
                [self sendInfoWithType:@"wx" andWithOpenID:authresponse.uid andWith:authresponse.accessToken];
            }
        }];
    }
    //微博登录
    if (loginBtn.tag == 5646) {
        [[UMSocialManager defaultManager]  authWithPlatform:UMSocialPlatformType_Sina currentViewController:self completion:^(id result, NSError *error) {
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[error.userInfo objectForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alertView show];
            } else {
                UMSocialAuthResponse *authresponse = result;
                [self sendInfoWithType:@"wb" andWithOpenID:authresponse.uid andWith:authresponse.accessToken];
            }
        }];
    }
}


    
//三方登录类型
-(void)sendInfoWithType:(NSString *)type andWithOpenID:(NSString *)openid andWith:(NSString *)accessToken{
    NSString *urlStr = @" http://api.aifamu.com/index.php?m=public&a=alllogin&apptype=app&version=1";
    NSDictionary *paramters = @{  @"openid":openid,
                                  @"access_token":accessToken,
                                  @"type_con":type
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
            NSMutableDictionary *Dic = [[NSMutableDictionary alloc]initWithDictionary:[dic objectForKey:@"data"]];
            UserInfoModel *loginModel  = [UserInfoModel yy_modelWithDictionary:Dic];
            self.appCache.loginViewModel = loginModel;
            self.appCache.token = loginModel.token;
            self.appCache.menPiao = loginModel.entrance_ticket;
            self.appCache.Zuanshi = loginModel.diamond;
            self.appCache.gold = loginModel.gold;
            
            [self CloseLogin];
            
            CATransition *animate = [CATransition animation];
            animate.type = kCATransitionPush;
            animate.subtype = kCATransitionFromRight;
            animate.duration = 0.2;
            [[UIApplication sharedApplication].keyWindow.layer addAnimation:animate forKey:nil];
            
            [UIApplication sharedApplication].keyWindow.rootViewController = [[BaseTabBarController alloc]init];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:[dic objectForKey:@"msg"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

    
}

#pragma mark 删除cookie
- (void)deleteCookie
{
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    
    //删除cookie
    for (NSHTTPCookie *tempCookie in cookies) {
        [cookieStorage deleteCookie:tempCookie];
    }
}

- (void)getUserInfo{
    
//    //#warning tokenStr
//    NSDictionary *paramters = @{
//                                };
//    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
//    [manager setSecurityPolicy:[AFMHTTPSManager customSecurityPolicy]];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    [manager POST: URLHEADER1(@"g=app&m=user&a=getuserinfo") parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSError *err;
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
//                                                            options:NSJSONReadingMutableContainers
//                                                              error:&err];
//        NSLog(@"%@",[dic objectForKey:@"errorMsg"]);
//        if ([[dic objectForKey:@"error"]isEqualToNumber:@0]) {
//            [self endprogress];
//            NSMutableDictionary *mDict = [[NSMutableDictionary alloc]initWithDictionary:[dic objectForKey:@"items"]];
//            AFMUserInfo *userinfo = [[AFMUserInfo alloc]init];
//            [userinfo saveUserInfoToDiskWith:mDict];
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//        else
//        {
//            
//        }
//        
//        //        NSLog(@"%@",[dic objectForKey:@"errorMsg"]);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //登录成功之后
    if (alertView.tag == 9483) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark ------------注册按钮/忘记密码按钮点击
- (void)reBtnClick:(UIButton *)reBtn{
    //注册账号
    if (reBtn.tag == 7899) {
        RegisterViewController *registVC = [[RegisterViewController alloc]init];
        registVC.type_c = @"1";
        [self.navigationController pushViewController:registVC animated:YES];
    }
    //忘记密码
    if (reBtn.tag == 7900) {
        RegisterViewController *registVC = [[RegisterViewController alloc]init];
        registVC.type_c = @"2";
        [self.navigationController pushViewController:registVC animated:YES];
    }
}

@end
