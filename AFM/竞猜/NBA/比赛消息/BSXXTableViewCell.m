//
//  BSXXTableViewCell.m
//  AFM
//
//  Created by admin on 2017/9/13.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BSXXTableViewCell.h"

@implementation BSXXTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"BSXXTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
    
}

@end
