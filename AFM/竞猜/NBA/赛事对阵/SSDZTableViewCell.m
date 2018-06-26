//
//  SSDZTableViewCell.m
//  AFM
//
//  Created by admin on 2017/9/13.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "SSDZTableViewCell.h"

@implementation SSDZTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SSDZTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
    self.Left_Img.layer.masksToBounds = YES;
    self.Left_Img.layer.cornerRadius = 29;
    self.right_Img.layer.masksToBounds = YES;
    self.right_Img.layer.cornerRadius = 29;

}

@end
