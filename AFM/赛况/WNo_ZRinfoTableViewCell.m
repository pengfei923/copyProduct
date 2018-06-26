//
//  WNo_ZRinfoTableViewCell.m
//  AFM
//
//  Created by 年少 on 2017/9/30.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "WNo_ZRinfoTableViewCell.h"

@implementation WNo_ZRinfoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"WNo_ZRinfoTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        
        [self initView];
    }
    return self;
}


- (void)initView{
    self.downView.layer.masksToBounds = YES;
    self.downView.layer.cornerRadius = 6;
    self.addZ_View.layer.masksToBounds = YES;
    self.addZ_View.layer.cornerRadius = 6;

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}



@end
