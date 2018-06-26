//
//  JCPMTableViewCell.m
//  AFM
//
//  Created by admin on 2017/9/22.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "JCPMTableViewCell.h"

@implementation JCPMTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"JCPMTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
    self.downView.layer.cornerRadius = 6;
    self.CH_View.layer.cornerRadius = 3;
    self.icon_Img.layer.masksToBounds = YES;
    self.icon_Img.layer.cornerRadius = 21;
}

@end
