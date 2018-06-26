//
//  RotaryViewController.m
//  AFM
//
//  Created by admin on 2017/10/19.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "RotaryViewController.h"

@interface RotaryViewController ()<UIWebViewDelegate>{
    
    NSURLRequest *repuest;
}

@property (nonatomic , strong)  UIWebView *webview;
@property (nonatomic , strong)  UIScrollView *scrollView;

@end

@implementation RotaryViewController
- (NSString *)url {
    if (!_url) {
        _url = [NSString stringWithFormat:@"http://act.aifamu.com/raffle/?user_token=%@",self.appCache.loginViewModel.token];
    }
    return _url;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES]; //显示导航
    self.tabBarController.tabBar.hidden = YES;                          //隐藏tabBar
    [self initData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
}


//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"大转盘";
}


//初始化界面
- (void)initView {

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_Width , screen_Height-64)];
    [self.view addSubview: self.scrollView];

    
    //网页试图
    self.webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height +60)];
    self.webview.delegate = self;

    self.webview.scrollView.backgroundColor = [UIColor whiteColor];
    self.webview.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    self.webview.dataDetectorTypes = UIDataDetectorTypeAll;
    self.webview.backgroundColor = [UIColor redColor];

    [self.scrollView addSubview:self.webview];
    self.scrollView.contentSize = self.webview.bounds.size;


    
}


//初始化数据
- (void)initData {
    self.url = [self.url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url_str = [NSString stringWithFormat:@"%@",self.url];
    NSURL *url_obj = [NSURL URLWithString:url_str];
    repuest = [NSURLRequest requestWithURL:url_obj];
    [self.webview loadRequest:repuest];
    
    NSArray *arr = [self.webview subviews];
    UIScrollView *scrollView = [arr objectAtIndex:0];
}



#pragma mark - webview代理
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [AppDelegate notificationRequestStart:@""];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [AppDelegate notificationRequestComplete:@""];

//    CGFloat height = [[self.webview stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
//    self.webview.frame = CGRectMake(0, 0, 375, height);

}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [AppDelegate notificationRequestError:error.localizedDescription];
}





@end
