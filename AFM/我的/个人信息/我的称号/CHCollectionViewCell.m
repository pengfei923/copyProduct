//
//  CHCollectionViewCell.m
//  AFM
//
//  Created by admin on 2017/9/7.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "CHCollectionViewCell.h"

@implementation CHCollectionViewCell


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CHCollectionViewCell" owner:nil options:nil];
        self = [nib firstObject];
        [self initView];
    }
    return self;
}

- (void)initView {
 
    self.use_Btn.layer.cornerRadius = 4;

}








@end
