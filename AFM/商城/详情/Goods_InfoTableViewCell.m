//
//  Goods_InfoTableViewCell.m
//  AFM
//
//  Created by admin on 2017/9/8.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "Goods_InfoTableViewCell.h"

@interface Goods_InfoTableViewCell ()<UITextFieldDelegate>{
    int labelNumber;
    float SY_lab;  //剩余
}

@end

@implementation Goods_InfoTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"Goods_InfoTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
    
    labelNumber = 1;
    self.DBField.delegate = self;
    self.price_Lab.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];

}
//减小
- (IBAction)minBtnClick:(UIButton *)sender {
    if (!(labelNumber <= 1)) {
        labelNumber --;
        if (labelNumber == 0) {
            self.DBField.text = @"1";
            [SVProgressHUD showInfoWithStatus:@"超过最小值"];
        }
        self.DBField.text = [NSString stringWithFormat:@"%d",labelNumber];
        if (self.returnValueBlock) {
            //将自己的值传出去，完成传值
            self.returnValueBlock(self.DBField.text);
        }

    }
}
//增大
- (IBAction)maxBtnClick:(UIButton *)sender {
    labelNumber ++;

    if (labelNumber < self.MaxNum) {
        self.DBField.text = [NSString stringWithFormat:@"%d",labelNumber];
    }else if (labelNumber == self.MaxNum){
        self.DBField.text = [NSString stringWithFormat:@"%d",self.MaxNum];
    }else{
        labelNumber --;
        [SVProgressHUD showInfoWithStatus:@"超过最大值"];
        self.DBField.text = [NSString stringWithFormat:@"%d",self.MaxNum];
    }
    
    if (self.returnValueBlock) {
        //将自己的值传出去，完成传值
        self.returnValueBlock(self.DBField.text );
    }

}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    labelNumber = [self.DBField.text intValue];
    if (labelNumber <= self.MaxNum) {
        self.DBField.text = [NSString stringWithFormat:@"%d",labelNumber];
    }else{
        [SVProgressHUD showInfoWithStatus:@"超过最大值"];
        self.DBField.text = [NSString stringWithFormat:@"%d",self.MaxNum];
        labelNumber = [self.DBField.text intValue];
    }
    if (self.returnValueBlock) {
        //将自己的值传出去，完成传值
        self.returnValueBlock(self.DBField.text );
    }

    
    return YES;
}



//- (void)setGoodsmodel:(GoodsInfoModel *)goodsmodel{
//    if (goodsmodel) {
//        _goodsmodel = goodsmodel;
//        self.name_Lab.text = goodsmodel.goodsInfo.name;
//        self.price_Lab.text = goodsmodel.goodsInfo.price;
//
//        
//    }
//}

@end
