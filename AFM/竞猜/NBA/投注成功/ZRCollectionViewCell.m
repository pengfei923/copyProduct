//
//  ZRCollectionViewCell.m
//  AFM
//
//  Created by admin on 2017/9/14.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "ZRCollectionViewCell.h"

@implementation ZRCollectionViewCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ZRCollectionViewCell" owner:nil options:nil];
        self = [nib firstObject];
        [self initView];
    }
    return self;
}

- (void)initView {
    

}

@end
