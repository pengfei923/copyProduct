//
//  SK_EndTableViewCell.m
//  AFM
//
//  Created by admin on 2017/9/20.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "SK_EndTableViewCell.h"

@implementation SK_EndTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SK_EndTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        
        [self initView];
    }
    return self;
}


- (void)initView{
    self.turnBtn.layer.masksToBounds = YES;
    self.turnBtn.layer.cornerRadius = 6;
    
}



- (void)setModel:(Home2_ENDListModelCell *)model {
    
    if (model) {
        
        [self.left_Img yy_setImageWithURL:[NSURL URLWithString:model.room_info.type_img] placeholder:[UIImage imageNamed:@" "]];
        self.title_Lab.text = model.room_info.name;
        self.PM_Lab.text = model.ranking;
        self.ZRJF_Lab.text = [NSString stringWithFormat:@"%0.1f",model.lineup_score];
        if ([model.is_reward isEqualToString:@"0"]) {
            self.JL_Lab.text = @"无";
        }else{
            self.JL_Lab.text = model.is_reward;
        }
        self.MP_Lab.text = model.room_info.price;
        self.ZS_Lab.text = [NSString stringWithFormat:@"%@/%@",model.room_info.now_guess_num,model.room_info.allow_guess_num];
        if ([model.get_status isEqualToString:@"0"]) {///领奖状态 0未领取 1已领取 2未获奖
            [self.turnBtn setTitle:@"领取奖励" forState:UIControlStateNormal];
            [self.turnBtn setBackgroundColor:[UIColor orangeColor]];
            self.turnBtn.hidden = NO;
        }else if ([model.get_status isEqualToString:@"1"]){
            [self.turnBtn setTitle:@"已领取" forState:UIControlStateNormal];
            [self.turnBtn setBackgroundColor:[UIColor grayColor]];
            self.turnBtn.hidden = NO;
        }else{
            self.turnBtn.hidden = YES;
        }
        
    }
    
}






@end
