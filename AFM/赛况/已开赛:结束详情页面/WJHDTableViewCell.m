//
//  WJHDTableViewCell.m
//  AFM
//
//  Created by admin on 2017/9/22.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "WJHDTableViewCell.h"

@implementation WJHDTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"WJHDTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
    
    self.my_img.layer.masksToBounds = YES;
    self.my_img.layer.cornerRadius = 16;
    self.you_img.layer.masksToBounds = YES;
    self.you_img.layer.cornerRadius = 16;
    self.my_view.layer.cornerRadius = 6;

}



@end
