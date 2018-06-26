//
//  Top_JCTableViewCell.m
//  AFM
//
//  Created by admin on 2017/9/12.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "Top_JCTableViewCell.h"

@implementation Top_JCTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"Top_JCTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
    self.line2.hidden = YES;
    self.line3.hidden = YES;
    self.line4.hidden = YES;


    
}


- (IBAction)button1Click:(UIButton *)sender {
    
    self.button1.selected = YES;
    self.line1.hidden = NO;
    self.button2.selected = NO;
    self.line2.hidden = YES;
    self.button3.selected = NO;
    self.line3.hidden = YES;
    self.button4.selected = NO;
    self.line4.hidden = YES;
    
    self.Tag = @"1";
    
    if ([_delegate respondsToSelector:@selector(refreshHead:)]) {
        [_delegate refreshHead:_Tag];
    }

   
    

}


- (IBAction)button2Click:(UIButton *)sender {
    self.button1.selected = NO;
    self.line1.hidden = YES;
    self.button2.selected = YES;
    self.line2.hidden = NO;
    self.button3.selected = NO;
    self.line3.hidden = YES;
    self.button4.selected = NO;
    self.line4.hidden = YES;

    self.Tag = @"2";
    
    if ([_delegate respondsToSelector:@selector(refreshHead:)]) {
        [_delegate refreshHead:_Tag];
    }

    
    
}

- (IBAction)button3Click:(UIButton *)sender {
    self.button1.selected = NO;
    self.line1.hidden = YES;
    self.button2.selected = NO;
    self.line2.hidden = YES;
    self.button3.selected = YES;
    self.line3.hidden = NO;
    self.button4.selected = NO;
    self.line4.hidden = YES;

    self.Tag = @"3";
    
    if ([_delegate respondsToSelector:@selector(refreshHead:)]) {
        [_delegate refreshHead:_Tag];
    }
    

    
}

- (IBAction)button4Click:(UIButton *)sender {
    self.button1.selected = NO;
    self.line1.hidden = YES;
    self.button2.selected = NO;
    self.line2.hidden = YES;
    self.button3.selected = NO;
    self.line3.hidden = YES;
    self.button4.selected = YES;
    self.line4.hidden = NO;

    self.Tag = @"4";
    
    if ([_delegate respondsToSelector:@selector(refreshHead:)]) {
        [_delegate refreshHead:_Tag];
    }
    

}



@end
