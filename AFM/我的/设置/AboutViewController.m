//
//  AboutViewController.m
//  AFM
//
//  Created by admin on 2017/9/1.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()


@end

@implementation AboutViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
    [self initData];
}


//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"关于我们";
}


//初始化界面
- (void)initView {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 10; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName: [UIFont fontWithName:@"Arial-ItalicMT" size:12.0], NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:self.title_Lab.text attributes:dic];
    self.title_Lab.attributedText = attributeStr;

}


//初始化数据
- (void)initData {
   

}


#pragma mark - 代理

@end
