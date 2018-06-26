//
//  ZRXQTableViewCell.m
//  AFM
//
//  Created by admin on 2017/9/22.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "ZRXQTableViewCell.h"

@implementation ZRXQTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ZRXQTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
    
    self.biao_Lab.layer.masksToBounds = YES;
    self.biao_Lab.layer.cornerRadius = 4;
    self.DaiD_Lab.layer.masksToBounds = YES;
    self.DaiD_Lab.layer.cornerRadius = 4;
    self.DaiD_Lab.hidden = YES;
    
}
@end
