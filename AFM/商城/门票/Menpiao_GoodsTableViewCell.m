//
//  Menpiao_GoodsTableViewCell.m
//  AFM
//
//  Created by 年少 on 2017/10/6.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "Menpiao_GoodsTableViewCell.h"
@interface Menpiao_GoodsTableViewCell ()<UITextFieldDelegate>{
    int labelNumber;

}
@end

@implementation Menpiao_GoodsTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"Menpiao_GoodsTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
    labelNumber = 10;
    self.MP_field.delegate = self;
    [self.MP_field addTarget:self  action:@selector(textFieldDidChange:)  forControlEvents:UIControlEventAllEditingEvents];

    
}


- (IBAction)minBtnClick:(UIButton *)sender {
    if (!(labelNumber <= 10)) {
        labelNumber --;
        if (labelNumber <10) {
            self.MP_field.text = @"10";
        }
        self.MP_field.text = [NSString stringWithFormat:@"%d",labelNumber];
    }else{
        [SVProgressHUD showInfoWithStatus:@"购买数量不能少于10"];
    }
    if (self.mpValueBlock) {
        //将自己的值传出去，完成传值
        self.mpValueBlock(self.MP_field.text );
    }


}

- (IBAction)maxBtnClick:(UIButton *)sender {
    labelNumber ++;
    if (labelNumber < 10000) {
        self.MP_field.text = [NSString stringWithFormat:@"%d",labelNumber];
    }else if (labelNumber == 10000){
        self.MP_field.text = @"10000";
    }else{
        labelNumber --;
        [SVProgressHUD showInfoWithStatus:@"超过最大值"];
        self.MP_field.text = @"10000";
    }
    if (self.mpValueBlock) {
        //将自己的值传出去，完成传值
        self.mpValueBlock(self.MP_field.text );
    }
}


-(void)textFieldDidChange:(UITextField *)textField {
    labelNumber = [self.MP_field.text intValue];
    if (labelNumber < 10) {
        [SVProgressHUD showInfoWithStatus:@"购买数量不能少于10"];
        labelNumber = 10;
    }else if (labelNumber <= 10000) {
        self.MP_field.text = [NSString stringWithFormat:@"%d",labelNumber];
    }else{
        [SVProgressHUD showInfoWithStatus:@"超过最大值"];
        self.MP_field.text = @"10000";
        labelNumber = [self.MP_field.text intValue];
    }
    if (self.mpValueBlock) {
        //将自己的值传出去，完成传值
        self.mpValueBlock(self.MP_field.text );
    }
}



- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    labelNumber = [self.MP_field.text intValue];
    if (labelNumber < 10) {
        [SVProgressHUD showInfoWithStatus:@"购买数量不能少于10"];
        self.MP_field.text = [NSString stringWithFormat:@"10"];
    }else if (labelNumber <= 10000) {
        self.MP_field.text = [NSString stringWithFormat:@"%d",labelNumber];
    }else{
        [SVProgressHUD showInfoWithStatus:@"超过最大值"];
        self.MP_field.text = @"10000";
        labelNumber = [self.MP_field.text intValue];
    }
    if (self.mpValueBlock) {
        //将自己的值传出去，完成传值
        self.mpValueBlock(self.MP_field.text );
    }
    return YES;
}


@end
