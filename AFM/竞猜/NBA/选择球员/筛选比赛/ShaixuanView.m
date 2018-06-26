//
//  ShaixuanView.m
//  AFM
//
//  Created by admin on 2017/9/15.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "ShaixuanView.h"

@implementation ShaixuanView

+ (ShaixuanView *)chooseGameView{
    
    ShaixuanView *view = [[[NSBundle mainBundle]loadNibNamed:@"ShaixuanView" owner:nil options:nil] lastObject];
    return view;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.7];
    
    [self initView];
    [self initData];
    
    
}

- (void)initView {
    self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.7];

    
}


- (void)initData {

}




@end
