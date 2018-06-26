//
//  RegisterViewController.m
//  AFM
//
//  Created by admin on 2017/9/1.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "RegisterViewController.h"
#import "ZFTextField.h"
#import "AFMHTTPSManager.h"
#import "Register1ViewController.h"

#define screen_Width [UIScreen mainScreen].bounds.size.width
#define screen_Height [UIScreen mainScreen].bounds.size.height

#define AuthCodeTime 60

@interface RegisterViewController ()<UITextFieldDelegate>{
    ZFTextField *accountTF;    //账号
    ZFTextField *passwordTF;   //动态密码
    UIButton *authcodeBtn;    //验证码按钮
    UIButton *loginBtn;       //登录按钮
    int authCodeTime;        //激活码等待时间
}
@property (nonatomic , strong) NSTimer *authCodeTimer;
@property (nonatomic , strong) NSString *smsMsgId;



@end

@implementation RegisterViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor getColorWithR:230 G:233 B:232 A:1];
    self.navigationController.navigationBar.barTintColor = [UIColor getColorWithR:27 G:27 B:27 A:1];

    [self initNavigation];
    [self initView];
    [self initData];
}



- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    [self.authCodeTimer invalidate];
}



- (NSTimer *)authCodeTimer {
    if (!_authCodeTimer) {
        _authCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(sendSmsCodeonTimer:) userInfo:nil repeats:YES];
    }
    return _authCodeTimer;
}


//初始化导航栏
- (void)initNavigation {
    if ([self.type_c isEqualToString:@"1"]) {
        self.navigationItem.title = @"注册账号";
    }else{
        self.navigationItem.title = @"修改密码";
    }
}


//初始化视图
- (void)initView {
    UIView *pview = [[UIView alloc] initWithFrame:CGRectMake(0, 20,screen_Width,48)];
    pview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pview];
    
    //手机号
    UILabel *phoneL = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 50, 48)];
    phoneL.text = @"手机号";
    phoneL.font = [UIFont systemFontOfSize:14];
    phoneL.textColor = [UIColor blackColor];
    [pview addSubview:phoneL];

    //手机号输入框
    accountTF = [[ZFTextField alloc] initWithFrame:CGRectMake(60, 0, 240, 48)];
    accountTF.placeholder = @"请输入手机号";
    accountTF.font = [UIFont systemFontOfSize:14];
    accountTF.textColor = [UIColor blackColor];
    accountTF.keyboardType = UIKeyboardTypeNumberPad;
    accountTF.delegate = self;
    accountTF.clearButtonMode = UITextFieldViewModeNever;
    accountTF.layer.borderColor = [[UIColor clearColor] CGColor];
    accountTF.leftViewMode = UITextFieldViewModeAlways;
    accountTF.returnKeyType = UIReturnKeyNext;
    [accountTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [pview addSubview:accountTF];
    
    
    //第二行
    UIView *yview = [[UIView alloc] initWithFrame:CGRectMake(0, 69,screen_Width,48)];
    yview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:yview];

    //验证码
    UILabel *numL = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 50, 48)];
    numL.text = @"验证码";
    numL.font = [UIFont systemFontOfSize:14];
    numL.textColor = [UIColor blackColor];
    [yview addSubview:numL];
    
    
    //密码输入框
    passwordTF = [[ZFTextField alloc] initWithFrame:CGRectMake(60, 0, 200, 48)];
    passwordTF.placeholder = @"请输入验证码";
    passwordTF.font = [UIFont systemFontOfSize:14];
    passwordTF.textColor = [UIColor blackColor];
    passwordTF.keyboardType = UIKeyboardTypeNumberPad;
    passwordTF.secureTextEntry = NO;//密码可见
    passwordTF.delegate = self;
    passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTF.layer.borderColor = [[UIColor clearColor] CGColor];
    passwordTF.leftViewMode = UITextFieldViewModeAlways;
    passwordTF.returnKeyType = UIReturnKeyJoin;
    [passwordTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [yview addSubview:passwordTF];
    [self.view addSubview:[self getauthCodeBtn:passwordTF]];

    

    
    
    //登录按钮
    loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 240, screen_Width - 40, 44)];
    loginBtn.layer.cornerRadius = 5;
    loginBtn.layer.masksToBounds = YES;
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [loginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor redColor]];

    [loginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor] andHeight:50] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor] andHeight:50] forState:UIControlStateHighlighted];
    [loginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor getColorWithTheme] andHeight:50] forState:UIControlStateSelected];
    [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
   
}

//初始化数据
- (void)initData {
    accountTF.text = self.appCache.accountPhone;
    authCodeTime = AuthCodeTime;
    
    if (accountTF.text.length >= 11) {
        authcodeBtn.selected = YES;
    }else {
        authcodeBtn.selected = NO;
    }
}


//验证码按钮
- (UIButton *)getauthCodeBtn:(UIView *)view{
    if (!authcodeBtn) {
        authcodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view.frame)-30, CGRectGetMidY(view.frame) + 50, (CGRectGetWidth(view.frame))/2.5, 35)];
        authcodeBtn.layer.masksToBounds = YES;
        authcodeBtn.layer.cornerRadius = 5;
        authcodeBtn.layer.borderWidth = 1.0;
        authcodeBtn.layer.borderColor = [[UIColor grayColor]CGColor];

        [authcodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [authcodeBtn.titleLabel setFont:[UIFont systemFontOfSize:11.0]];
        [authcodeBtn.titleLabel setTextColor:[UIColor getColorWithTheme]];
    
        [authcodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [authcodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [authcodeBtn setTitleColor:[UIColor getColorWithTheme] forState:UIControlStateSelected];
        
        [authcodeBtn addTarget:self action:@selector(getSmsCode:) forControlEvents:UIControlEventTouchUpInside];
    }
    return authcodeBtn;
}



#pragma mark - 输入框代理
- (void)textFieldDidChange:(UITextField *)textField{
    if (textField == accountTF) {
        if (textField.text.length >= 11) {
            textField.text = [textField.text substringToIndex:11];
            authcodeBtn.selected = YES;
            authcodeBtn.layer.borderColor = [[UIColor getColorWithTheme]CGColor];

        }else {
            authcodeBtn.selected = NO;
            authcodeBtn.layer.borderColor = [[UIColor grayColor]CGColor];

        }
        
    }else if (textField == passwordTF) {
        if (textField.text.length >= 4) {
            loginBtn.selected = YES;
        }else {
            loginBtn.selected = NO;
        }
    }
}



//隐藏键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 1) {
        
    }else if (textField.tag == 2) {
        [self loginClick];
    }
    return YES;
}




//定时器方法
- (void)sendSmsCodeonTimer:(NSTimer *)timer{
    authCodeTime -- ;
    if (authCodeTime <= 0) {
        [authcodeBtn setUserInteractionEnabled:YES];
        [authcodeBtn setTitle:@"获取密码" forState:UIControlStateNormal];
        authCodeTime = AuthCodeTime;
        self.authCodeTimer = nil;
        [timer invalidate];
    }else{
        [authcodeBtn setUserInteractionEnabled:NO];
        NSString *title = [NSString stringWithFormat:@"%d秒", authCodeTime];
        [authcodeBtn setTitle:title forState:UIControlStateNormal];
    }
}



//下一步
- (void)loginClick {
    if (loginBtn.selected == NO) {
        [AppDelegate notificationRequestInfoWithStatus:@"请输入动态密码"];
    }else if (accountTF.text.length <= 0){
        [AppDelegate notificationRequestInfoWithStatus:@"账号不能为空"];
    }else if(passwordTF.text.length <= 0){
        [AppDelegate notificationRequestInfoWithStatus:@"密码不能为空"];
    }else{
        [self requestLogin:@"phone"];
        [accountTF resignFirstResponder];
        [passwordTF resignFirstResponder];
    }
}



#pragma mark - 登陆
//获取密码
-(void)getSmsCode:(UIButton *)send{
    
    if (!send.selected) {
        return;
    }else {
        NSLog(@"电话号码满足要求");
    }
    
    if (![self.authCodeTimer isValid]) {
        return;
    }
//注册
    NSString *urlStr = @"http://api.aifamu.com/index.php?version=1&apptype=app&g=api&m=sms&a=send";
    if ([self.type_c isEqualToString:@"1"]) {
        //网络请求
        NSDictionary *paramters = @{@"phoneNum":accountTF.text,
                                    @"todo":@"1"
                                    };
        AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
        [manager setSecurityPolicy:[AFMHTTPSManager customSecurityPolicy]];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:urlStr parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            if (![[dic objectForKey:@"error"]isEqualToNumber:@0]) {
                UIAlertView *alerV = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"msg"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alerV show];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];

//忘记密码
    }else{
        NSDictionary *paramters = @{@"phoneNum":accountTF.text,
                                    @"todo":@"2"
                                    };
        AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
        [manager setSecurityPolicy:[AFMHTTPSManager customSecurityPolicy]];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:urlStr parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            if (![[dic objectForKey:@"error"]isEqualToNumber:@0]) {
                UIAlertView *alerV = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"msg"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alerV show];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }
}


//下一步
- (void)requestLogin:(NSString *)loginType{
    //网络请求
    NSString *urlStr = @"http://api.aifamu.com/index.php?version=1&apptype=app&g=api&m=sms&a=verify";
    
    NSDictionary *paramters = @{   @"phoneNum":accountTF.text,
                                   @"smsCode":passwordTF.text};
    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
    [manager setSecurityPolicy:[AFMHTTPSManager customSecurityPolicy]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST: urlStr parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        if (![[dic objectForKey:@"error"]isEqualToNumber:@0]) {
            UIAlertView *alerV = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"msg"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alerV show];
        }else{
            Register1ViewController *regVC = [[Register1ViewController alloc]init];
            regVC.type_c = self.type_c;
            regVC.phoneNum = accountTF.text;
            [self.navigationController pushViewController:regVC animated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}




@end
