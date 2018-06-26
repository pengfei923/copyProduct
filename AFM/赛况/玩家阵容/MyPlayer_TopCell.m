//
//  MyPlayer_TopCell.m
//  AFM
//
//  Created by admin on 2017/9/21.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "MyPlayer_TopCell.h"

@implementation MyPlayer_TopCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MyPlayer_TopCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
    
    
    
    
}

@end
