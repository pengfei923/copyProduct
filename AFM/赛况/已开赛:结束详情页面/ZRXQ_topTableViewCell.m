//
//  ZRXQ_topTableViewCell.m
//  AFM
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "ZRXQ_topTableViewCell.h"

@implementation ZRXQ_topTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ZRXQ_topTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
    
}

@end
