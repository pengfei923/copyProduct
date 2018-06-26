//
//  HeadImgTableViewCell.m
//  AFM
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "HeadImgTableViewCell.h"

@interface HeadImgTableViewCell ()
@property(nonatomic, strong)UITableView *tableView;          //列表视图
@property(nonatomic, strong)NSMutableArray *dataArray;          //

@end
@implementation HeadImgTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HeadImgTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
    
    
    self.icon_Img.layer.masksToBounds = YES;
    self.icon_Img.layer.cornerRadius = 25;
    

    
}


@end
