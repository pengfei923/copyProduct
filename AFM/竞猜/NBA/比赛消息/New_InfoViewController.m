//
//  New_InfoViewController.m
//  AFM
//
//  Created by admin on 2017/11/8.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "New_InfoViewController.h"

@interface New_InfoViewController ()<UIWebViewDelegate>{
    UIWebView *webview;
    NSURLRequest *repuest;
}

@end

@implementation New_InfoViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES]; //显示导航
    self.tabBarController.tabBar.hidden = YES;                    //隐藏tabBar
    
    
    [self initData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];

}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"";
}


//初始化界面
- (void)initView {
    //网页试图
    webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height)];
    webview.delegate = self;
    webview.scrollView.backgroundColor = [UIColor whiteColor];
    webview.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    webview.dataDetectorTypes = UIDataDetectorTypeAll;
    webview.backgroundColor = [UIColor redColor];
    [self.view addSubview:webview];
}


//初始化数据
- (void)initData {
    self.url = [self.url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url_str = [NSString stringWithFormat:@"%@",self.url];
    NSURL *url_obj = [NSURL URLWithString:url_str];
    repuest = [NSURLRequest requestWithURL:url_obj];
    [webview loadRequest:repuest];
    
}


#pragma mark - webview代理
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [AppDelegate notificationRequestStart:@""];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [AppDelegate notificationRequestComplete:@""];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [AppDelegate notificationRequestError:error.localizedDescription];
}


@end
