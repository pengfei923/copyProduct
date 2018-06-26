//
//  TJZR_BackView.m
//  AFM
//
//  Created by admin on 2017/9/25.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "TJZR_BackView.h"
#import "MenpiaoViewController.h"


@interface TJZR_BackView () {
    int labelNumber;
    float SY_lab;  //剩余次数
    
}


@end

@implementation TJZR_BackView

+ (TJZR_BackView *)cloosePayView{
    
    TJZR_BackView *view = [[[NSBundle mainBundle]loadNibNamed:@"TJZR_BackView" owner:nil options:nil] lastObject];
    return view;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.7];
    
    [self initView];
    [self initData];
}



- (void)initView {
    self.down_View.layer.masksToBounds = YES;
    self.down_View.layer.cornerRadius = 6;
    self.down_View2.layer.masksToBounds = YES;
    self.down_View2.layer.cornerRadius = 6;
    [self.num_Lab.layer setCornerRadius:12.0]; //设置矩圆角半径
    [self.num_Lab.layer setBorderWidth:1];  //边框宽度
    
    self.down_View2.hidden = YES;
    //边框颜色
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 173/255.0, 173/255.0, 173/255.0, 1 });
    [self.num_Lab.layer setBorderColor:colorref];
    labelNumber = 1;
    
}


- (void)initData {


}



- (IBAction)minBtn_BtnClick:(UIButton *)sender {
    if (!(labelNumber <= 1) && (labelNumber <= self.MaxNum)) {
        labelNumber --;
        if (labelNumber == 0) {
            self.num_Lab.text = @"1";
            [SVProgressHUD showInfoWithStatus:@"超过最小值"];
        }
        //数量
        self.num_Lab.text = [NSString stringWithFormat:@"%d",labelNumber];
        float FNum = [[NSString stringWithFormat:@"%d",labelNumber] floatValue];
        float FPrice = [[NSString stringWithFormat:@"%@",self.JCDJ_Lab.text] floatValue];
        //总计消耗
        self.zong_lab.text = [NSString stringWithFormat:@"%0.0f",FPrice * FNum] ;
    }
}


- (IBAction)maxBtn_BtnClick:(UIButton *)sender {
    labelNumber ++;
    float FNum = [[NSString stringWithFormat:@"%d",labelNumber] floatValue];
    float FPrice = [[NSString stringWithFormat:@"%@",self.JCDJ_Lab.text] floatValue];

    if (labelNumber < self.MaxNum) {
        self.num_Lab.text = [NSString stringWithFormat:@"%d",labelNumber];
        self.zong_lab.text = [NSString stringWithFormat:@"%0.0f",FPrice * FNum];
    }else if (labelNumber == self.MaxNum){
        self.num_Lab.text = [NSString stringWithFormat:@"%d",self.MaxNum];
        self.zong_lab.text = [NSString stringWithFormat:@"%0.0f",FPrice * self.MaxNum];
    }else{
        labelNumber --;
        [SVProgressHUD showInfoWithStatus:@"超过最大值"];
        self.num_Lab.text = [NSString stringWithFormat:@"%d",self.MaxNum];
    }

}

//取消
- (IBAction)cancel_BtnClick:(UIButton *)sender {
    
    self.hidden = YES;
}


//确认
- (IBAction)ture_BtnClick:(UIButton *)sender {
    float FZJXH = [[NSString stringWithFormat:@"%@",self.zong_lab.text] floatValue];
    if (FZJXH > [self.DQYY_Lab.text intValue]) {  //总及消耗 > 当前拥有
        self.down_View.hidden = YES;
        self.down_View2.hidden = NO;
    }else{
        self.hidden = YES;
        if (self.turnblock) {
            self.turnblock(@"success",self.num_Lab.text);
        }

        
    }
}

//第二次确认（跳到购买门票页面）
- (IBAction)ture2_BtnClick:(UIButton *)sender {
    MenpiaoViewController *menpVC = [[MenpiaoViewController alloc] init];
    [menpVC setHidesBottomBarWhenPushed:YES];
    [self.controller.navigationController pushViewController:menpVC animated:YES];
 
}


@end
