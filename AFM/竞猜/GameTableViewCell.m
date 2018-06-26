//
//  GameTableViewCell.m
//  AFM
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "GameTableViewCell.h"

@implementation GameTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"GameTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        
        [self initView];
    }
    return self;
}


- (void)initView{
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 6;

    
}


@end
