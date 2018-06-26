//
//  HeadImgTableViewCell.h
//  AFM
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadImgTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *icon_Img;
@property (weak, nonatomic) IBOutlet UILabel *text_Lab;
@property (weak, nonatomic) IBOutlet UILabel *name_Lab;
@property (nonatomic, strong) UIViewController *controller;

@end
