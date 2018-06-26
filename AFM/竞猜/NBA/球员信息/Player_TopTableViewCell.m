//
//  Player_TopTableViewCell.m
//  AFM
//
//  Created by admin on 2017/9/14.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "Player_TopTableViewCell.h"

@implementation Player_TopTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"Player_TopTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
    
    self.Meg_LineView.hidden = YES;

    
    
}





- (IBAction)Meg_BtnClick:(UIButton *)sender {
    self.Meg_Btn.selected = YES;
    self.Meg_LineView.hidden = NO;
    self.Rizhi_Btn.selected = NO;
    self.Rizhi_LineVoew.hidden = YES;
    
    self.num = @"1";
    
    if ([_delegate respondsToSelector:@selector(refreshNum:)]) {
        [_delegate refreshNum:_num];
    }
    


    
}

- (IBAction)Rizhi_BtnClick:(UIButton *)sender {
    self.Rizhi_Btn.selected = YES;
    self.Rizhi_LineVoew.hidden = NO;
    self.Meg_Btn.selected = NO;
    self.Meg_LineView.hidden = YES;

    self.num = @"2";
    
    if ([_delegate respondsToSelector:@selector(refreshNum:)]) {
        [_delegate refreshNum:_num];
    }
    

    
}


@end
