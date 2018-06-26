//
//  KeyboardView.m
//  AFM
//
//  Created by 年少 on 2017/10/15.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "KeyboardView.h"

@implementation KeyboardView



+ (KeyboardView *)initKeyView{
    KeyboardView *view = [[[NSBundle mainBundle]loadNibNamed:@"KeyboardView" owner:nil options:nil] lastObject];
    return view;

}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}



- (void)initView {
    self.turn_Btn.layer.masksToBounds = YES;
    self.turn_Btn.layer.cornerRadius = 6;
    
    
    _txtInput.textColor = [UIColor getColorWithTexts];
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"请输入内容"];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:[UIColor getColorWithTextLight]
                        range:NSMakeRange(0, @"请输入内容".length)];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:14]
                        range:NSMakeRange(0, @"请输入内容".length)];
    _txtInput.attributedPlaceholder = placeholder;
    _txtInput.adjustsFontSizeToFitWidth = YES;  //文字滚动
    _txtInput.returnKeyType = UIReturnKeySend;  //确认按钮
    _txtInput.layer.cornerRadius = 10;

}



@end
