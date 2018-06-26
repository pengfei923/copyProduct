//
//  ShuJtop_TableViewCell.m
//  AFM
//
//  Created by admin on 2017/11/9.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "ShuJtop_TableViewCell.h"

@implementation ShuJtop_TableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ShuJtop_TableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end
