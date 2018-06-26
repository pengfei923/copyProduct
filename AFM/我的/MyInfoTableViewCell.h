//
//  MyInfoTableViewCell.h
//  AFM
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon_Img;   //头像
@property (weak, nonatomic) IBOutlet UILabel *name_Lab;      //昵称
@property (weak, nonatomic) IBOutlet UILabel *tit_Lab;       //标签
@property (weak, nonatomic) IBOutlet UIImageView *tit_Img;    //标签图标

@property (weak, nonatomic) IBOutlet UIButton *zuan_Btn;
@property (weak, nonatomic) IBOutlet UIButton *men_Btn;
@property (weak, nonatomic) IBOutlet UIButton *mu_Btn;

@property (weak, nonatomic) IBOutlet UILabel *zuan_Lab;
@property (weak, nonatomic) IBOutlet UILabel *men_Lab;
@property (weak, nonatomic) IBOutlet UILabel *mu_Lab;

@property (weak, nonatomic) IBOutlet UIImageView *CZ_Img;

@property (strong , nonatomic) UIViewController *controller;

@end
