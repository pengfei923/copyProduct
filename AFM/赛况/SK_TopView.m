//
//  SK_TopView.m
//  AFM
//
//  Created by admin on 2017/9/21.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "SK_TopView.h"

@implementation SK_TopView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"SK_TopView" owner:nil options:nil] firstObject];
    }
    [self initView];
    return self;
}

- (void)initView{
    self.line_view2.hidden = YES;
    self.line_view3.hidden = YES;
}


- (IBAction)Button1Click:(UIButton *)sender {
    self.button2.selected = NO;
    self.button3.selected = NO;
    self.button1.selected = YES;
    
    self.line_view1.hidden = NO;
    self.line_view2.hidden = YES;
    self.line_view3.hidden = YES;
    self.SK_Tag = @"1";
    
    if ([_delegate respondsToSelector:@selector(refreshSK_TOP:)]) {
        [_delegate refreshSK_TOP:_SK_Tag];
    }


}


- (IBAction)Button2Click:(UIButton *)sender {
    self.button2.selected = YES;
    self.button3.selected = NO;
    self.button1.selected = NO;
    
    self.line_view1.hidden = YES;
    self.line_view2.hidden = NO;
    self.line_view3.hidden = YES;
    self.SK_Tag = @"2";
    
    if ([_delegate respondsToSelector:@selector(refreshSK_TOP:)]) {
        [_delegate refreshSK_TOP:_SK_Tag];
    }


}


- (IBAction)Button3Click:(UIButton *)sender {
    self.button2.selected = NO;
    self.button3.selected = YES;
    self.button1.selected = NO;
    
    self.line_view1.hidden = YES;
    self.line_view2.hidden = YES;
    self.line_view3.hidden = NO;
    self.SK_Tag = @"3";
    
    if ([_delegate respondsToSelector:@selector(refreshSK_TOP:)]) {
        [_delegate refreshSK_TOP:_SK_Tag];
    }


}

@end
