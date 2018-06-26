//
//  ClooseRoomView.h
//  AFM
//
//  Created by admin on 2017/9/12.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClooseRoomView : UIView



+ (ClooseRoomView *)clooseTypeView;

@property (weak, nonatomic) IBOutlet UIView *downView;
@property (weak, nonatomic) IBOutlet UIButton *hidden_Btn;

//-----------------房间类型------------------
@property (weak, nonatomic) IBOutlet UIButton *xiaBtn;
@property (weak, nonatomic) IBOutlet UIButton *bikaiBtn;
@property (weak, nonatomic) IBOutlet UIButton *playerBtn;



//-----------------门票------------------
@property (weak, nonatomic) IBOutlet UIView *sliderView;
@property (weak, nonatomic) IBOutlet UILabel *minLab;
@property (weak, nonatomic) IBOutlet UILabel *maxLab;


//-----------------排序------------------
@property (weak, nonatomic) IBOutlet UIButton *menBtn;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (weak, nonatomic) IBOutlet UIButton *jiangBtn;



@property (weak, nonatomic) IBOutlet UIButton *refresh_Btn;//重置
@property (weak, nonatomic) IBOutlet UIButton *ture_Btn;   //确认

@end
