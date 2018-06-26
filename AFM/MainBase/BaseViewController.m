//
//  BaseViewController.m
//  CarServiceO2O
//
//  Created by admin on 2017/8/28.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BaseViewController.h"

NSString *const BaseViewUpUpLocation = @"BaseViewUpUpLocation";
NSString *const BaseViewUpUpMessage = @"BaseViewUpUpMessage";
@interface BaseViewController ()
@end

@implementation BaseViewController
-(void)BackViewAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self BaseInitView];
    [self BaseInitData];
    [self addAction];
}

- (void)dealloc {

}
    
    
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
    
    
- (void)BaseInitView {
    self.view.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
	if (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
		self.automaticallyAdjustsScrollViewInsets = NO;
	}
    
    if (self.navigationController.viewControllers.count > 1) {
        UIBarButtonItem *myBackButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(BackViewAction:)];
        self.navigationItem.leftBarButtonItem = myBackButton;
    }
}


    
- (void)BaseInitData {
	self.appCache = [AppCache sharedInstance];
	self.mainWidth = self.view.bounds.size.width;
	self.mainHeight = self.view.bounds.size.height;
}


//判断是否登录
- (BOOL)getUpLoginBool {
    if (self.appCache.loginViewModel) {
        if (![self.appCache.loginViewModel.token isEqualToString:@""]) {
            return YES;
        }else {
            [BaseTabBarController notificationLogin];
            return NO;
        }
    }else {
        [BaseTabBarController notificationLogin];
        return NO;
    }
}


#pragma mark - 添加广播
//更新位置信息
+ (void)notificationBaseViewUpUpLocation {
    [[NSNotificationCenter defaultCenter]postNotificationName:BaseViewUpUpLocation object:nil userInfo:[NSDictionary dictionaryWithObject:@"" forKey:@"data"]];
}

//更新消息数量
+ (void)notificationBaseViewUpUpMessage {
    [[NSNotificationCenter defaultCenter]postNotificationName:BaseViewUpUpMessage object:nil userInfo:[NSDictionary dictionaryWithObject:@"" forKey:@"data"]];
}

//注册接口列表广播
- (void) addAction {

}

//移除接口列表广播
- (void) removeAction{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BaseViewUpUpLocation object:nil];
}

@end
