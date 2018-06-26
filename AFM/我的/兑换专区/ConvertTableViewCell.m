//
//  ConvertTableViewCell.m
//  AFM
//
//  Created by admin on 2017/10/16.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "ConvertTableViewCell.h"

@implementation ConvertTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ConvertTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

- (void)initView{

    
}

@end
