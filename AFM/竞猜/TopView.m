//
//  TopView.m
//  AFM
//
//  Created by admin on 2017/9/12.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "TopView.h"

@implementation TopView



- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"TopView" owner:nil options:nil] firstObject];
    }
    [self initView];
    return self;
}

- (void)initView{
    self.lineView2.hidden = YES;
    self.lineView3.hidden = YES;
    self.lineView4.hidden = YES;


    
}

- (IBAction)button1Click:(UIButton *)sender {
    self.button2.selected = NO;
    self.button3.selected = NO;
    self.button4.selected = NO;
    self.button1.selected = YES;
    
    self.lineView1.hidden = NO;
    self.lineView2.hidden = YES;
    self.lineView3.hidden = YES;
    self.lineView4.hidden = YES;
    
    self.Btn_tag = @"1";
    
    if ([_delegate respondsToSelector:@selector(btnBackBlcok:)]) {
        [_delegate btnBackBlcok:self.Btn_tag];
    }

}

- (IBAction)button2Click:(UIButton *)sender {
    self.button2.selected = YES;
    self.button3.selected = NO;
    self.button4.selected = NO;
    self.button1.selected = NO;
    
    self.lineView1.hidden = YES;
    self.lineView2.hidden = NO;
    self.lineView3.hidden = YES;
    self.lineView4.hidden = YES;

    self.Btn_tag = @"2";
    
    if ([_delegate respondsToSelector:@selector(btnBackBlcok:)]) {
        [_delegate btnBackBlcok:self.Btn_tag];
    }
}
- (IBAction)button3Click:(UIButton *)sender {
    self.button2.selected = NO;
    self.button3.selected = YES;
    self.button4.selected = NO;
    self.button1.selected = NO;
    
    self.lineView1.hidden = YES;
    self.lineView2.hidden = YES;
    self.lineView3.hidden = NO;
    self.lineView4.hidden = YES;
  
    self.Btn_tag = @"3";
    
    if ([_delegate respondsToSelector:@selector(btnBackBlcok:)]) {
        [_delegate btnBackBlcok:self.Btn_tag];
    }
}
- (IBAction)button4Click:(UIButton *)sender {
    self.button2.selected = NO;
    self.button3.selected = NO;
    self.button4.selected = YES;
    self.button1.selected = NO;
    
    self.lineView1.hidden = YES;
    self.lineView2.hidden = YES;
    self.lineView3.hidden = YES;
    self.lineView4.hidden = NO;
   
    self.Btn_tag = @"4";
    
    if ([_delegate respondsToSelector:@selector(btnBackBlcok:)]) {
        [_delegate btnBackBlcok:self.Btn_tag];
    }
}






@end
