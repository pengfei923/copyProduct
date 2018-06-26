//
//  JfenViewController.m
//  AFM
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "JfenViewController.h"

@interface JfenViewController ()

@end

@implementation JfenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
    [self initData];
}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"积分规则";
    
}


//初始化界面
- (void)initView {
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height - 44)];
    scroll.contentSize = CGSizeMake(0, 2000.5/375.0*screen_Width);
    [self.view addSubview:scroll];
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screen_Width, 1981.5/375.0*screen_Width)];
    imgV.image = [UIImage imageNamed:@"rules"];
    [scroll addSubview:imgV];

    
    
}

//初始化数据
- (void)initData {
}



@end
