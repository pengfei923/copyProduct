//
//  Biao_TopTableViewCell.m
//  AFM
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "Biao_TopTableViewCell.h"

@implementation Biao_TopTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"Biao_TopTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}



@end
