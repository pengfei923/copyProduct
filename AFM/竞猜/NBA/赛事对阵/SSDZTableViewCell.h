//
//  SSDZTableViewCell.h
//  AFM
//
//  Created by admin on 2017/9/13.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSDZTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Left_Img;
@property (weak, nonatomic) IBOutlet UILabel *left_Lab;
@property (weak, nonatomic) IBOutlet UIImageView *right_Img;
@property (weak, nonatomic) IBOutlet UILabel *right_Lab;
@property (weak, nonatomic) IBOutlet UILabel *time_lab;
@property (weak, nonatomic) IBOutlet UILabel *title_Lab;
@property (weak, nonatomic) IBOutlet UILabel *VS_Lab;

@end
