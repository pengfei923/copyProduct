//
//  OrderView.h
//  AFM
//
//  Created by admin on 2017/9/8.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderView : UIView

@property (weak, nonatomic) IBOutlet UIView *downView;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *tureBtn;

+ (OrderView *)creatInorderView;
@property (weak, nonatomic) IBOutlet UILabel *guige_lab;

@property (weak, nonatomic) IBOutlet UILabel *num_Lab;
@property (weak, nonatomic) IBOutlet UILabel *price_Lab;

@property (weak, nonatomic) IBOutlet UILabel *name_lab;
@property (weak, nonatomic) IBOutlet UILabel *name_phone;
@property (weak, nonatomic) IBOutlet UILabel *address_L;

@end
