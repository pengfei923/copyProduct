//
//  TJZR_BackView.h
//  AFM
//
//  Created by admin on 2017/9/25.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^turnBlock) (NSString *success,NSString *num);

@interface TJZR_BackView : UIView
@property(nonatomic, copy) turnBlock turnblock;

+ (TJZR_BackView *)cloosePayView;

@property (weak, nonatomic) IBOutlet UIView *down_View;
@property (weak, nonatomic) IBOutlet UIView *down_View2;
@property (weak, nonatomic) IBOutlet UILabel *JCDJ_Lab;
@property (weak, nonatomic) IBOutlet UILabel *FJ_Lab;
@property (weak, nonatomic) IBOutlet UIButton *Min_Btn;
@property (weak, nonatomic) IBOutlet UIButton *Max_Btn;
@property (weak, nonatomic) IBOutlet UILabel *num_Lab;
@property (weak, nonatomic) IBOutlet UILabel *zong_lab;
@property (weak, nonatomic) IBOutlet UILabel *maxNum_Lab;
@property (weak, nonatomic) IBOutlet UILabel *DQYY_Lab;
@property (weak, nonatomic) IBOutlet UIButton *turnBtn;

@property (strong, nonatomic) UIViewController *controller;
@property (nonatomic , strong) NSString *price;                 //单个门票数
@property (nonatomic , strong) NSString *menPiao;               //门票总数
@property (nonatomic , strong) NSString *allow_uguess_num;      //允许用户投注总数


@property (assign, nonatomic)int MaxNum;

@end
