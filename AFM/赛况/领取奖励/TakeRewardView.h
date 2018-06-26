//
//  TakeRewardView.h
//  AFM
//
//  Created by admin on 2017/10/13.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakeRewardView : UIView

+ (TakeRewardView *)turnTRView;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *MP_view;



@property (weak, nonatomic) IBOutlet UIView *num_View;
@property (weak, nonatomic) IBOutlet UILabel *MP_Lab;
@property (weak, nonatomic) IBOutlet UILabel *type_Lab;
@property (weak, nonatomic) IBOutlet UIImageView *type_Img;


//一键
@property (weak, nonatomic) IBOutlet UIView *YJ_View;
@property (weak, nonatomic) IBOutlet UILabel *Y_mpLab;
@property (weak, nonatomic) IBOutlet UILabel *Y_mtLab;


@property (weak, nonatomic) IBOutlet UIButton *turn_Btn;
@property (weak, nonatomic) IBOutlet UIButton *esc_Btn;

@end
