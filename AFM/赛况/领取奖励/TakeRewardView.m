//
//  TakeRewardView.m
//  AFM
//
//  Created by admin on 2017/10/13.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "TakeRewardView.h"

@implementation TakeRewardView

+ (TakeRewardView *)turnTRView{
    
    
    TakeRewardView *view = [[[NSBundle mainBundle]loadNibNamed:@"TakeRewardView" owner:nil options:nil] lastObject];
    return view;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.7];
    
    [self initView];
}



- (void)initView {
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 6;
    

}


//取消
- (IBAction)cancelClick:(UIButton *)sender {
    
    self.hidden = YES;
}

//确认
- (IBAction)turnBtnClick:(UIButton *)sender {
    
    self.hidden = YES;

}

@end
