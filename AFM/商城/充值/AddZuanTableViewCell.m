//
//  AddZuanTableViewCell.m
//  AFM
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 sgamer. All rights reserved.
//


#import "AddZuanTableViewCell.h"
#import "AppCache.h"
#define ARedColor [UIColor colorWithRed:215/255.0 green:56/255.0 blue:63/255.0 alpha:1]

@interface AddZuanTableViewCell ()<UITextFieldDelegate>{
    
}
@end

@implementation AddZuanTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AddZuanTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}



- (void)initView{
    self.SC_View1.hidden = NO;
    self.SC_View2.hidden = YES;
    self.SC_View3.hidden = YES;
    self.SC_View4.hidden = YES;
    self.SC_View5.hidden = YES;
    self.SC_View6.hidden = YES;
    
    __weak typeof(self) weakSelf = self;

    self.isSH_Block = ^(NSString *isSH_C) {
        weakSelf.isSH_C = isSH_C;        
        if ([weakSelf.isSH_C isEqualToString:@"1"]) { //已经首充
            weakSelf.SzLab1.hidden = YES;
            weakSelf.ZandP1.constant = 10;
            weakSelf.SC_View1.hidden = YES;
            weakSelf.SzLab2.hidden = YES;
            weakSelf.ZandP2.constant = 10;
            weakSelf.SC_View2.hidden = YES;
            weakSelf.SzLab3.hidden = YES;
            weakSelf.ZandP3.constant = 10;
            weakSelf.SC_View3.hidden = YES;
            weakSelf.SzLab4.hidden = YES;
            weakSelf.ZandP4.constant = 10;
            weakSelf.SC_View4.hidden = YES;
            weakSelf.SzLab5.hidden = YES;
            weakSelf.ZandP5.constant = 10;
            weakSelf.SC_View5.hidden = YES;
            weakSelf.SzLab6.hidden = YES;
            weakSelf.ZandP6.constant = 10;
            weakSelf.SC_View6.hidden = YES;

        }else{
            weakSelf.SzLab1.hidden = NO;
            weakSelf.ZandP1.constant = 2;
            weakSelf.SC_View1.hidden = NO;
            weakSelf.SzLab2.hidden = NO;
            weakSelf.ZandP2.constant = 2;
            weakSelf.SC_View2.hidden = YES;
            weakSelf.SzLab3.hidden = NO;
            weakSelf.ZandP3.constant = 2;
            weakSelf.SC_View3.hidden = YES;
            weakSelf.SzLab4.hidden = NO;
            weakSelf.ZandP4.constant = 2;
            weakSelf.SC_View4.hidden = YES;
            weakSelf.SzLab5.hidden = NO;
            weakSelf.ZandP5.constant = 2;
            weakSelf.SC_View5.hidden = YES;
            weakSelf.SzLab6.hidden = NO;
            weakSelf.ZandP6.constant = 2;
            weakSelf.SC_View6.hidden = YES;
        }
    };
    
    if ((self.button1.selected = YES)) {
        if (self.PriceValueBlock) {
            //将自己的值传出去，完成传值
            self.PriceValueBlock( @"6" );
        }
    }
}


- (IBAction)but1Click:(UIButton *)sender {
    if ([_isSH_C isEqualToString:@"1"]) {  //已首充
        self.SC_View1.hidden = YES;
    }else{
        self.SC_View1.hidden = NO;
    }
    self.button1.selected = YES;
    self.button2.selected = NO;
    self.button3.selected = NO;
    self.button4.selected = NO;
    self.button5.selected = NO;
    self.button6.selected = NO;
    
    self.SC_View2.hidden = YES;
    self.SC_View3.hidden = YES;
    self.SC_View4.hidden = YES;
    self.SC_View5.hidden = YES;
    self.SC_View6.hidden = YES;

    self.SzLab1.textColor = ARedColor;
    self.zLab1.textColor = ARedColor;
    self.mLab1.textColor = ARedColor;
    
    self.zLab2.textColor = [UIColor grayColor];
    self.mLab2.textColor = [UIColor grayColor];
    self.SzLab2.textColor = [UIColor grayColor];

    self.zLab3.textColor = [UIColor grayColor];
    self.mLab3.textColor = [UIColor grayColor];
    self.SzLab3.textColor = [UIColor grayColor];

    self.zLab4.textColor = [UIColor grayColor];
    self.mLab4.textColor = [UIColor grayColor];
    self.SzLab4.textColor = [UIColor grayColor];

    self.zLab5.textColor = [UIColor grayColor];
    self.mLab5.textColor = [UIColor grayColor];
    self.SzLab5.textColor = [UIColor grayColor];

    self.zLab6.textColor = [UIColor grayColor];
    self.mLab6.textColor = [UIColor grayColor];
    self.SzLab6.textColor = [UIColor grayColor];


    if (self.PriceValueBlock) {
        //将自己的值传出去，完成传值
        self.PriceValueBlock( @"6" );
    }

}
- (IBAction)but2Click:(UIButton *)sender {
    if ([_isSH_C isEqualToString:@"1"]) {  //已首充
        self.SC_View2.hidden = YES;
    }else{
        self.SC_View2.hidden = NO;
    }
    self.button1.selected = NO;
    self.button2.selected = YES;
    self.button3.selected = NO;
    self.button4.selected = NO;
    self.button5.selected = NO;
    self.button6.selected = NO;

    self.SC_View1.hidden = YES;
    self.SC_View3.hidden = YES;
    self.SC_View4.hidden = YES;
    self.SC_View5.hidden = YES;
    self.SC_View6.hidden = YES;

    self.zLab1.textColor = [UIColor grayColor];
    self.mLab1.textColor = [UIColor grayColor];
    self.SzLab1.textColor = [UIColor grayColor];

    self.zLab2.textColor = ARedColor;
    self.mLab2.textColor = ARedColor;
    self.SzLab2.textColor = ARedColor;

    self.zLab3.textColor = [UIColor grayColor];
    self.mLab3.textColor = [UIColor grayColor];
    self.SzLab3.textColor = [UIColor grayColor];
    
    self.zLab4.textColor = [UIColor grayColor];
    self.mLab4.textColor = [UIColor grayColor];
    self.SzLab4.textColor = [UIColor grayColor];
    
    self.zLab5.textColor = [UIColor grayColor];
    self.mLab5.textColor = [UIColor grayColor];
    self.SzLab5.textColor = [UIColor grayColor];
    
    self.zLab6.textColor = [UIColor grayColor];
    self.mLab6.textColor = [UIColor grayColor];
    self.SzLab6.textColor = [UIColor grayColor];


    if (self.PriceValueBlock) {
        //将自己的值传出去，完成传值
        self.PriceValueBlock( @"30" );
    }

}
- (IBAction)but3Click:(UIButton *)sender {
    if ([_isSH_C isEqualToString:@"1"]) {  //已首充
        self.SC_View3.hidden = YES;
    }else{
        self.SC_View3.hidden = NO;
    }
    self.button1.selected = NO;
    self.button2.selected = NO;
    self.button3.selected = YES;
    self.button4.selected = NO;
    self.button5.selected = NO;
    self.button6.selected = NO;

    self.SC_View1.hidden = YES;
    self.SC_View2.hidden = YES;
    self.SC_View4.hidden = YES;
    self.SC_View5.hidden = YES;
    self.SC_View6.hidden = YES;

    self.zLab1.textColor = [UIColor grayColor];
    self.mLab1.textColor = [UIColor grayColor];
    self.SzLab1.textColor = [UIColor grayColor];
    
    self.zLab2.textColor = [UIColor grayColor];
    self.mLab2.textColor = [UIColor grayColor];
    self.SzLab2.textColor = [UIColor grayColor];

    self.zLab3.textColor = ARedColor;
    self.mLab3.textColor = ARedColor;
    self.SzLab3.textColor = ARedColor;
    
    self.zLab4.textColor = [UIColor grayColor];
    self.mLab4.textColor = [UIColor grayColor];
    self.SzLab4.textColor = [UIColor grayColor];
    
    self.zLab5.textColor = [UIColor grayColor];
    self.mLab5.textColor = [UIColor grayColor];
    self.SzLab5.textColor = [UIColor grayColor];
    
    self.zLab6.textColor = [UIColor grayColor];
    self.mLab6.textColor = [UIColor grayColor];
    self.SzLab6.textColor = [UIColor grayColor];


    if (self.PriceValueBlock) {
        //将自己的值传出去，完成传值
        self.PriceValueBlock( @"98" );
    }

}

- (IBAction)but4Click:(UIButton *)sender {
    if ([_isSH_C isEqualToString:@"1"]) {  //已首充
        self.SC_View4.hidden = YES;
    }else{
        self.SC_View4.hidden = NO;
    }
    self.button1.selected = NO;
    self.button2.selected = NO;
    self.button3.selected = NO;
    self.button4.selected = YES;
    self.button5.selected = NO;
    self.button6.selected = NO;

    self.SC_View1.hidden = YES;
    self.SC_View2.hidden = YES;
    self.SC_View3.hidden = YES;
    self.SC_View5.hidden = YES;
    self.SC_View6.hidden = YES;

    self.SzLab1.textColor = [UIColor grayColor];
    self.zLab1.textColor = [UIColor grayColor];
    self.mLab1.textColor = [UIColor grayColor];
    
    self.zLab2.textColor = [UIColor grayColor];
    self.mLab2.textColor = [UIColor grayColor];
    self.SzLab2.textColor = [UIColor grayColor];

    self.zLab3.textColor = [UIColor grayColor];
    self.mLab3.textColor = [UIColor grayColor];
    self.SzLab3.textColor = [UIColor grayColor];

    self.zLab4.textColor = ARedColor;
    self.mLab4.textColor = ARedColor;
    self.SzLab4.textColor = ARedColor;

    self.zLab5.textColor = [UIColor grayColor];
    self.mLab5.textColor = [UIColor grayColor];
    self.SzLab5.textColor = [UIColor grayColor];
    
    self.zLab6.textColor = [UIColor grayColor];
    self.mLab6.textColor = [UIColor grayColor];
    self.SzLab6.textColor = [UIColor grayColor];


    if (self.PriceValueBlock) {
        //将自己的值传出去，完成传值
        self.PriceValueBlock( @"198" );
    }

}

- (IBAction)but5Click:(UIButton *)sender {
    if ([_isSH_C isEqualToString:@"1"]) {  //已首充
        self.SC_View5.hidden = YES;
    }else{
        self.SC_View5.hidden = NO;
    }
    self.button1.selected = NO;
    self.button2.selected = NO;
    self.button3.selected = NO;
    self.button4.selected = NO;
    self.button5.selected = YES;
    self.button6.selected = NO;

    self.SC_View1.hidden = YES;
    self.SC_View2.hidden = YES;
    self.SC_View3.hidden = YES;
    self.SC_View4.hidden = YES;
    self.SC_View6.hidden = YES;

    self.SzLab1.textColor = [UIColor grayColor];
    self.zLab1.textColor = [UIColor grayColor];
    self.mLab1.textColor = [UIColor grayColor];
    
    self.zLab2.textColor = [UIColor grayColor];
    self.mLab2.textColor = [UIColor grayColor];
    self.SzLab2.textColor = [UIColor grayColor];
    
    self.zLab3.textColor = [UIColor grayColor];
    self.mLab3.textColor = [UIColor grayColor];
    self.SzLab3.textColor = [UIColor grayColor];
    
    self.zLab4.textColor = [UIColor grayColor];
    self.mLab4.textColor = [UIColor grayColor];
    self.SzLab4.textColor = [UIColor grayColor];

    self.zLab5.textColor = ARedColor;
    self.mLab5.textColor = ARedColor;
    self.SzLab5.textColor = ARedColor;

    self.zLab6.textColor = [UIColor grayColor];
    self.mLab6.textColor = [UIColor grayColor];
    self.SzLab6.textColor = [UIColor grayColor];


    if (self.PriceValueBlock) {
        //将自己的值传出去，完成传值
        self.PriceValueBlock( @"328" );
    }

}

- (IBAction)but6Click:(UIButton *)sender {
    if ([_isSH_C isEqualToString:@"1"]) {  //已首充
        self.SC_View6.hidden = YES;
    }else{
        self.SC_View6.hidden = NO;
    }
    self.button1.selected = NO;
    self.button2.selected = NO;
    self.button3.selected = NO;
    self.button4.selected = NO;
    self.button5.selected = NO;
    self.button6.selected = YES;

    self.SC_View1.hidden = YES;
    self.SC_View2.hidden = YES;
    self.SC_View3.hidden = YES;
    self.SC_View4.hidden = YES;
    self.SC_View5.hidden = YES;

    self.SzLab1.textColor = [UIColor grayColor];
    self.zLab1.textColor = [UIColor grayColor];
    self.mLab1.textColor = [UIColor grayColor];
    
    self.zLab2.textColor = [UIColor grayColor];
    self.mLab2.textColor = [UIColor grayColor];
    self.SzLab2.textColor = [UIColor grayColor];
    
    self.zLab3.textColor = [UIColor grayColor];
    self.mLab3.textColor = [UIColor grayColor];
    self.SzLab3.textColor = [UIColor grayColor];
    
    self.zLab4.textColor = [UIColor grayColor];
    self.mLab4.textColor = [UIColor grayColor];
    self.SzLab4.textColor = [UIColor grayColor];
    
    self.zLab5.textColor = [UIColor grayColor];
    self.mLab5.textColor = [UIColor grayColor];
    self.SzLab5.textColor = [UIColor grayColor];

    self.zLab6.textColor = ARedColor;
    self.mLab6.textColor = ARedColor;
    self.SzLab6.textColor = ARedColor;
    

    if (self.PriceValueBlock) {
        //将自己的值传出去，完成传值
        self.PriceValueBlock( @"648" );
    }

}







@end
