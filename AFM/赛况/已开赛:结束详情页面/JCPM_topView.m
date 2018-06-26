//
//  JCPM_topView.m
//  AFM
//
//  Created by admin on 2017/9/22.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "JCPM_topView.h"

@implementation JCPM_topView


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"JCPM_topView" owner:nil options:nil] firstObject];
    }
    [self initView];
    return self;
}



- (void)initView{
    
    self.icon_Img.layer.cornerRadius = 10;
    
}


@end
