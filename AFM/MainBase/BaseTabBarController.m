//
//  BaseTabBarController.m
//  LepeiLeshu
//
//  Created by admin on 2017/8/28.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BaseTabBarController.h"
#import "ViewController_Page1.h"            //竞猜
#import "ViewController_Page2.h"            //赛况
#import "ViewController_Page3.h"            //商城
#import "ViewController_Page4.h"            //我的
#import "LoginViewController.h"             //登录


NSString *const BaseNotificationLogin   = @"BaseNotificationLogin";



//======================================================================================
@interface BaseTabBarController ()<UITabBarControllerDelegate>{
    NSString *trackViewUrl;
    NSDictionary *userInfo;
}
@end

@implementation BaseTabBarController
#pragma mark - 引导页

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self start_Launch];
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
}

//引导页
- (void)start_Launch {
    AppCache *cache = [AppCache sharedInstance];
    if(cache.deviceFirst == NO){
        //LaunchAnimationViewController *launchAnimation = [[LaunchAnimationViewController alloc]init];
        //[self presentViewController:launchAnimation animated:NO completion:nil];
        NSLog(@"第一次启动");
        cache.deviceFirst = YES;
    }
}

#pragma mark - 初始化
//初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewControllers];
    [self initViewControllersData];
    [self AddAction];
}

//
- (void)dealloc {
    [self RemoveAction];
}


#pragma mark - 初始化主界面

//初始化主界面
-(void)initViewControllers{
	
    //竞猜
    ViewController_Page1 *page1 = [[ViewController_Page1 alloc] init];
    BaseNavigationController *navpage1 = [[BaseNavigationController alloc] initWithRootViewController:page1];
    navpage1.title = @"竞猜";
    navpage1 = [self getNavigationControllerSeting:navpage1];
	navpage1.tabBarItem.image = [[UIImage imageNamed:@"guess-icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	navpage1.tabBarItem.selectedImage = [[UIImage imageNamed:@"guess-icon-active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

	
    //赛况
    ViewController_Page2 *page2 = [[ViewController_Page2 alloc] init];
    BaseNavigationController *navpage2 = [[BaseNavigationController alloc] initWithRootViewController:page2];
    navpage2.title = @"赛况";
    navpage2 = [self getNavigationControllerSeting:navpage2];
	navpage2.tabBarItem.image = [[UIImage imageNamed:@"event-icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	navpage2.tabBarItem.selectedImage = [[UIImage imageNamed:@"event-icon-active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

	
    //商城
    ViewController_Page3 *page3 = [[ViewController_Page3 alloc] init];
    BaseNavigationController *navpage3 = [[BaseNavigationController alloc] initWithRootViewController:page3];
    navpage3.title = @"商城";
    navpage3 = [self getNavigationControllerSeting:navpage3];
	navpage3.tabBarItem.image = [[UIImage imageNamed:@"mall-icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	navpage3.tabBarItem.selectedImage = [[UIImage imageNamed:@"mall-icon-active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

	
    //我的
    ViewController_Page4 *page4 = [[ViewController_Page4 alloc] init];
    BaseNavigationController *navpage4 = [[BaseNavigationController alloc] initWithRootViewController:page4];
    navpage4.title = @"我的";
    navpage4 = [self getNavigationControllerSeting:navpage4];
	navpage4.tabBarItem.image = [[UIImage imageNamed:@"user-icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	navpage4.tabBarItem.selectedImage = [[UIImage imageNamed:@"user-icon-active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	
	
    //添加控制器
    self.tabBar.translucent = NO;
    self.tabBar.backgroundImage = [[UIImage alloc]init];
    self.tabBar.tintColor = [UIColor getColorWithTheme];  //点击 bar字体颜色
    self.tabBar.shadowImage = [UIImage imageWithColor:[UIColor getColorWithNva] andHeight:0.3];//设置阴影线颜色
    self.viewControllers = @[navpage1,navpage2,navpage3,navpage4];
    self.view.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    
}

//设置统一的导航栏
- (BaseNavigationController *)getNavigationControllerSeting:(BaseNavigationController *)nav {
   
    [nav.navigationBar setTranslucent:NO];
    [nav.navigationBar setTintColor:[UIColor whiteColor]];//navigationBar返回颜色
    [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [nav.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor getColorWithNva] andHeight:45] forBarMetrics:UIBarMetricsDefault];
    [nav.navigationBar setShadowImage:[UIImage new]];//设置阴影线颜色

    return nav;
}

#pragma mark - 获取APP基本信息
- (void)initViewControllersData {
    AppCache *cache = [AppCache sharedInstance];
    cache.bundleName = [NSString getAppName];   //获取APP名字
    cache.bundleShortVersion = [NSString getVersion]; //获取外部版本号
    cache.bundleVersion = [NSString getBuild];  // 版本
}



#pragma mark ============================ 添加广播 ============================
//注册接口列表广播
- (void)AddAction {
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BaseNotificationLogin:) name:BaseNotificationLogin object:nil];
   
}

//移除接口列表广播
- (void)RemoveAction{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BaseNotificationLogin object:nil];
}

//登录
+ (void)notificationLogin {
    [[NSNotificationCenter defaultCenter]postNotificationName:BaseNotificationLogin object:nil userInfo:[NSDictionary dictionaryWithObject:@"" forKey:@"data"]];
}


//跳转登录页面
-(void)BaseNotificationLogin:(NSNotification *)notification {
    LoginViewController *login = [[LoginViewController alloc]init];
    BaseNavigationController *navlogin = [[BaseNavigationController alloc] initWithRootViewController:login];
    navlogin = [self getNavigationControllerSeting:navlogin];
    [self presentViewController:navlogin animated:YES completion:nil];
}


@end

