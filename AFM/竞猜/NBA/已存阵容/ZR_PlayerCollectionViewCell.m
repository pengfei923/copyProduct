//
//  ZR_PlayerCollectionViewCell.m
//  AFM
//
//  Created by admin on 2017/9/15.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "ZR_PlayerCollectionViewCell.h"

@implementation ZR_PlayerCollectionViewCell


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ZR_PlayerCollectionViewCell" owner:nil options:nil];
        self = [nib firstObject];
        [self initView];
    }
    return self;
}

- (void)initView {
    

    self.downView.layer.cornerRadius = 5;
    self.biao_Lab.layer.cornerRadius = 4;
    self.biao_Lab.layer.masksToBounds = YES;
    
    
    self.downView.layer.shadowColor = [UIColor getColorWithTextTheme].CGColor;
    self.downView.layer.shadowOpacity = 0.6f;
    self.downView.layer.shadowRadius = 1.f;
    self.downView.layer.shadowOffset = CGSizeMake(1,1);

    
}
@end
