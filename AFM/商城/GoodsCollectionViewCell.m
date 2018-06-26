//
//  GoodsCollectionViewCell.m
//  AFM
//
//  Created by admin on 2017/9/5.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "GoodsCollectionViewCell.h"

@implementation GoodsCollectionViewCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"GoodsCollectionViewCell" owner:nil options:nil];
        self = [nib firstObject];
        [self initView];
    }
    return self;
}

- (void)initView {

    self.num_Lab.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
}


@end
