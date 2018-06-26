//
//  No_ZRinfoTableViewCell.m
//  AFM
//
//  Created by admin on 2017/9/26.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "No_ZRinfoTableViewCell.h"


@implementation No_ZRinfoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"No_ZRinfoTableViewCell" owner:nil options:nil];
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
    self.myIcon_Img.layer.masksToBounds = YES;
    self.myIcon_Img.layer.cornerRadius = 10;
    self.my_Lab.layer.masksToBounds = YES;
    self.my_Lab.layer.cornerRadius = 5;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
