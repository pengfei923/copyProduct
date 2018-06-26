//
//  Help1TableViewCell.m
//  AFM
//
//  Created by admin on 2017/10/20.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "Help1TableViewCell.h"

@implementation Help1TableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"Help1TableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
    
    
    
}
@end
