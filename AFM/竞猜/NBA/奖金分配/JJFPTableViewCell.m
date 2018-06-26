//
//  JJFPTableViewCell.m
//  AFM
//
//  Created by admin on 2017/9/13.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "JJFPTableViewCell.h"

@implementation JJFPTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"JJFPTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
    
}

@end
