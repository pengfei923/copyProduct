//
//  MyPlayer_ZRTableViewCell.m
//  AFM
//
//  Created by admin on 2017/9/21.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "MyPlayer_ZRTableViewCell.h"

@implementation MyPlayer_ZRTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MyPlayer_ZRTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
    
    self.biao_lab.layer.masksToBounds = YES;
    self.biao_lab.layer.cornerRadius = 4;

    
}


@end
