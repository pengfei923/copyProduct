//
//  OrderInfoView.m
//  AFM
//
//  Created by admin on 2017/10/11.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "OrderInfoView.h"

@implementation OrderInfoView

+ (OrderInfoView *)infoView{
    
    OrderInfoView *view = [[[NSBundle mainBundle]loadNibNamed:@"OrderInfoView" owner:nil options:nil] lastObject];
    return view;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.7];
    
    [self initView];
}



- (void)initView {
    self.down_View.layer.masksToBounds = YES;
    self.down_View.layer.cornerRadius = 6;
    [self.ka_Btn.layer setCornerRadius:4.0]; //设置矩圆角半径
    [self.pas_Btn.layer setCornerRadius:4.0]; //设置矩圆角半径
    
}


//复制卡号
- (IBAction)Ka_BtnClick:(UIButton *)sender {
    [SVProgressHUD showInfoWithStatus:@"卡号复制成功"];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.kahao_Lab.text;
}

//复制密码
- (IBAction)Pas_BtnClick:(UIButton *)sender {
    [SVProgressHUD showInfoWithStatus:@"密码复制成功"];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.pass_lab.text;
}

//取消
- (IBAction)disClick:(UIButton *)sender {
    self.hidden = YES;
    
}

@end
