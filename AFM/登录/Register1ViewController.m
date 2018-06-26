//
//  Register1ViewController.m
//  AFM
//
//  Created by admin on 2017/9/4.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "Register1ViewController.h"
#import "LoginViewController.h"
#import "AFMHTTPSManager.h"


#define screen_Width [UIScreen mainScreen].bounds.size.width

@interface Register1ViewController ()<UIAlertViewDelegate>

@end

@implementation Register1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self creatUI];
}

- (void)creatUI{
    
    UILabel *topTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    topTitleLabel.text  = @"修改密码";
    topTitleLabel.textAlignment = NSTextAlignmentCenter;
    topTitleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = topTitleLabel;
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *textArray = @[@"新密码",@"确认密码"];
    NSArray *placeH = @[@"输入密码",@"再次输入密码"];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 170.0/375.0*screen_Width, screen_Width, 1)];
    lineLabel.backgroundColor = [UIColor getColorWithR:238 G:238 B:237 A:1];
    [self.view addSubview:lineLabel];
   
    
    for (int i = 0; i < 2; i++) {
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20.0/375.0*screen_Width +50.0/375.0*screen_Width*i, screen_Width, 1)];
        lineLabel.backgroundColor = [UIColor getColorWithR:238 G:238 B:237 A:1];
        [self.view addSubview:lineLabel];
        
        UILabel *lineLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 20.0/375.0*screen_Width +50.0/375.0*screen_Width*(i+1), screen_Width, 1)];
        lineLabel2.backgroundColor = [UIColor getColorWithR:238 G:238 B:237 A:1];
        [self.view addSubview:lineLabel2];
       
        UILabel *im = [[UILabel alloc]initWithFrame:CGRectMake(10.0/375.0*screen_Width, 35.0/375.0*screen_Width + 50.0/375.0*screen_Width*i, 90.0/375.0*screen_Width, 20.0/375.0*screen_Width)];
        im.text = textArray[i];
        im.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:im];
        
        UITextField *textF = [[UITextField alloc]initWithFrame:CGRectMake(110.0/375.0*screen_Width, 37.0/375.0*screen_Width + 50.0/375.0*screen_Width*i, screen_Width - 120.0/375.0*screen_Width, 20.0/375.0*screen_Width)];
        textF.tag = 9670 + i;
        textF.secureTextEntry = NO;
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:placeH[i]];
        [placeholder addAttribute:NSForegroundColorAttributeName
                            value:[UIColor getColorWithR:174 G:174 B:174 A:1]
                            range:NSMakeRange(0, [placeH[i] length])];
        [placeholder addAttribute:NSFontAttributeName
                            value:[UIFont systemFontOfSize:14]
                            range:NSMakeRange(0, [placeH[i] length])];
        textF.attributedPlaceholder = placeholder;
        [self.view addSubview:textF];
    }
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(10.0/375.0*screen_Width ,170.0/375.0*screen_Width, screen_Width - 20.0/375.0*screen_Width, 50.0/375.0*screen_Width);
    [nextBtn setTitle:@"完成" forState:UIControlStateNormal];
    [nextBtn  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.backgroundColor = [UIColor getColorWithTheme];
    nextBtn.layer.cornerRadius = 3;
    [nextBtn addTarget:self action:@selector(registerBtnClick1) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.layer.masksToBounds = YES;
    [self.view addSubview:nextBtn];
}

//完成按钮
-(void)registerBtnClick1{
    NSString *urlStr = @"http://api.aifamu.com/index.php?version=1&apptype=app&g=api&m=public&a=register";
    NSString *urlStr1 = @"http://api.aifamu.com/index.php?version=1&apptype=app&g=api&m=public&a=forget";

    UITextField *textf1 = (UITextField *)[self.view viewWithTag:9670];
    UITextField *textf2 = (UITextField *)[self.view viewWithTag:9671];
    if ([textf1.text isEqualToString:textf2.text]) {
        //整体数据请求
        if ([self.type_c isEqualToString:@"1"]) {//注册
            NSDictionary *paramters = @{   @"pass1":textf1.text,
                                        @"pass2":textf2.text,
                                        @"phone":self.phoneNum,
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
                if (![[dic objectForKey:@"error"]isEqualToNumber:@0]) {
                    UIAlertView *alerV = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"msg"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    alerV.tag = 8642;
                    [alerV show];
                }
                else
                {
                    UIAlertView *alerV = [[UIAlertView alloc]initWithTitle:nil message:@"注册成功！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    alerV.tag = 5973;
                    alerV.delegate = self;
                    [alerV show];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }else{  //忘记密码
                NSDictionary *paramters = @{   @"pass1":textf1.text,
                                            @"pass2":textf2.text,
                                            @"phone":self.phoneNum,
                                            };
                AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
                [manager setSecurityPolicy:[AFMHTTPSManager customSecurityPolicy]];
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                
                [manager POST: urlStr1 parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSError *err;
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                        options:NSJSONReadingMutableContainers
                                                                          error:&err];
                    if (![[dic objectForKey:@"error"]isEqualToNumber:@0]) {
                        UIAlertView *alerV = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"msg"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                        [alerV show];

                    }else{
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dic objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            LoginViewController *LogV = [[LoginViewController alloc]init];
                            LogV.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:LogV animated:YES];
                        }];
                        [alertController addAction:okAction];
                        [self presentViewController:alertController animated:YES completion:nil];

                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                }];
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 5973) {
        UITextField *textf = (UITextField *)[self.view viewWithTag:9670];
        
        LoginViewController *loginVC =  self.navigationController.childViewControllers[1];
        loginVC.resultBlock(self.phoneNum,textf.text);
        [self.navigationController popToViewController:self.navigationController.childViewControllers[1] animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
