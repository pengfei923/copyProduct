//
//  OrderView.m
//  AFM
//
//  Created by admin on 2017/9/8.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "OrderView.h"
#import "AddressView.h"


@interface OrderView ()


@end


@implementation OrderView

+ (OrderView *)creatInorderView{
    OrderView *view = [[[NSBundle mainBundle]loadNibNamed:@"OrderView" owner:nil options:nil] lastObject];
    return view;

}



- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.7];
    
    [self initView];
    [self initData];
    
}



- (void)initView {
    self.downView.layer.masksToBounds = YES;
    self.downView.layer.cornerRadius = 5;
    
    
    
}


- (void)initData{

    
}





@end
