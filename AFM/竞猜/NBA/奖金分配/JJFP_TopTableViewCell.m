//
//  JJFP_TopTableViewCell.m
//  AFM
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "JJFP_TopTableViewCell.h"

@implementation JJFP_TopTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"JJFP_TopTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
    
}
@end
