//
//  StoreTopTableViewCell.m
//  AFM
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "StoreTopTableViewCell.h"

@implementation StoreTopTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"StoreTopTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
    
    
    
    
}


@end
