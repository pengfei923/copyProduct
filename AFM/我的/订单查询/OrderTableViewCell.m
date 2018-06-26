//
//  OrderTableViewCell.m
//  AFM
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"OrderTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
    
    [self.see_Btn.layer setMasksToBounds:YES];
    [self.see_Btn.layer setCornerRadius:3.0]; //设置矩圆角半径
    [self.see_Btn.layer setBorderWidth:1.0];   //边框宽度
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 214/255.0, 76/255.0, 63/255.0, 1 });
    [self.see_Btn.layer setBorderColor:colorref];//边框颜色

}

@end
