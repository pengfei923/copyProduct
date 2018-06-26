//
//  ADessTableViewCell.m
//  AFM
//
//  Created by admin on 2017/9/8.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "ADessTableViewCell.h"

@implementation ADessTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ADessTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
    //默认
    self.moren_Lab.layer.masksToBounds = YES;
    self.moren_Lab.layer.cornerRadius = 3;
    self.moren_Lab.layer.borderWidth = 0.5;
    self.moren_Lab.layer.borderColor = [UIColor getColorWithTheme].CGColor;
    
    [self.cloose_Btn addTarget:self action:@selector(clooseAddressClick:) forControlEvents:UIControlEventTouchUpInside];


    
}


//选择地址
- (void)clooseAddressClick:(UIButton *)Btn {
    if ((self.cloose_Btn.selected = YES)) {
        self.cloose_Btn.selected = NO;
    }else{
        self.cloose_Btn.selected = YES;
    }
    
}




@end
