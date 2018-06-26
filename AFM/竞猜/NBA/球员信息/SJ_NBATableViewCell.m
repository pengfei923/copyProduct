//
//  SJ_NBATableViewCell.m
//  AFM
//
//  Created by admin on 2017/11/14.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "SJ_NBATableViewCell.h"

@implementation SJ_NBATableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SJ_NBATableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
@end
