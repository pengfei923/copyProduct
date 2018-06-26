//
//  OrderTableViewCell.h
//  AFM
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *time_Lab;
@property (weak, nonatomic) IBOutlet UILabel *danh_Lab;
@property (weak, nonatomic) IBOutlet UILabel *state_Lab;

@property (weak, nonatomic) IBOutlet UIImageView *icon_Img;
@property (weak, nonatomic) IBOutlet UILabel *title_Lab;
@property (weak, nonatomic) IBOutlet UIImageView *hhh_Img;
@property (weak, nonatomic) IBOutlet UILabel *money_Lab;
@property (weak, nonatomic) IBOutlet UILabel *number_Lab;
@property (weak, nonatomic) IBOutlet UILabel *kuaidi_Lab;
@property (weak, nonatomic) IBOutlet UIButton *see_Btn;

@end
