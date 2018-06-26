//
//  JCPM_topTableViewCell.m
//  AFM
//
//  Created by admin on 2017/9/22.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "JCPM_topTableViewCell.h"

@implementation JCPM_topTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"JCPM_topTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
    self.icon_Img.layer.cornerRadius = 10;
    
}

@end
