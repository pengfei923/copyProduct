//
//  OrderInfoView.h
//  AFM
//
//  Created by admin on 2017/10/11.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderInfoView : UIView


+ (OrderInfoView *)infoView;

@property (weak, nonatomic) IBOutlet UIView *down_View;
@property (weak, nonatomic) IBOutlet UIButton *ka_Btn;
@property (weak, nonatomic) IBOutlet UIButton *pas_Btn;
@property (weak, nonatomic) IBOutlet UILabel *name_Lab;
@property (weak, nonatomic) IBOutlet UILabel *kahao_Lab;
@property (weak, nonatomic) IBOutlet UILabel *pass_lab;

@end
