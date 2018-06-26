//
//  JCPMTableViewCell.h
//  AFM
//
//  Created by admin on 2017/9/22.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCPMTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *downView;
@property (weak, nonatomic) IBOutlet UIImageView *left_Img;
@property (weak, nonatomic) IBOutlet UIImageView *icon_Img;
@property (weak, nonatomic) IBOutlet UILabel *PM_Lab;
@property (weak, nonatomic) IBOutlet UILabel *PMnum_Lab;
@property (weak, nonatomic) IBOutlet UILabel *name_Lab;
@property (weak, nonatomic) IBOutlet UIView *CH_View;
@property (weak, nonatomic) IBOutlet UIImageView *CH_Img;
@property (weak, nonatomic) IBOutlet UILabel *CH_Lab;

@property (weak, nonatomic) IBOutlet UILabel *lable1;
@property (weak, nonatomic) IBOutlet UILabel *lable2;
@property (weak, nonatomic) IBOutlet UILabel *lable3;

@end
