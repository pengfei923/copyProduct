//
//  GoodsInfo1TableViewCell.m
//  AFM
//
//  Created by 年少 on 2017/10/5.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "GoodsInfo1TableViewCell.h"

@interface GoodsInfo1TableViewCell ()<UIWebViewDelegate>{

}

@end


@implementation GoodsInfo1TableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"GoodsInfo1TableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
   
    
}
@end
