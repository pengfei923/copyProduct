//
//  AFMRankCell1.m
//  ifarm
//
//  Created by 蒙傅 on 2017/8/14.
//  Copyright © 2017年 蒙傅. All rights reserved.
//

#import "AFMRankCell1.h"

@implementation AFMRankCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
    }
    return self;
}

-(void)rankUseBtnClick:(UIButton *)rankUseBtn{
    
}

-(void)rankUseBtn1Click:(UIButton *)rankUseBtn{
    
}



- (void)setModel:(MyChengHaoModelCell *)model {
    self.model = model;
    self.rank_nameL.text = model.name;
    [self.rank_imgV yy_setImageWithURL:[NSURL URLWithString:model.avatar_img]placeholder:[UIImage imageNamed:@""]];
//    if ([model.type isEqualToNumber:@1]) {
//        self.rankUseBtn.selected = YES;
//        self.rankUseBtn.hidden = NO;
//        self.rankUseBtn.backgroundColor = [UIColor getColorWithTextLight];
//    }else{
//        self.rankUseBtn.selected = NO;
//        self.rankUseBtn.hidden = NO;
//        self.rankUseBtn.backgroundColor = [UIColor getColorWithTheme];
//    }
}

-(void)setModel1:(MyChengHaoModelCell *)model1{
    _model1 = model1;
    self.rank_nameL1.text = model1.name;
    [self.rank_imgV1 yy_setImageWithURL:[NSURL URLWithString:model1.avatar_img]placeholder:[UIImage imageNamed:@""]];
//    if ([model1.type isEqualToNumber:@1]) {
//        self.rankUseBtn1.selected = YES;
//        self.rankUseBtn.hidden = NO;
//    }else{
//        self.rankUseBtn1.selected = NO;
//        self.rankUseBtn.hidden = NO;
//    }
}

-(UILabel *)rank_nameL{
    if (_rank_nameL == nil) {
        UILabel *rank_nameL = [UILabel new];
        rank_nameL.text = @"伐木新手";
//        rank_nameL.textAlignment = NSTextAlignmentCenter;
        rank_nameL.textColor = [UIColor getColorWithTextTheme];
        rank_nameL.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:rank_nameL];
        _rank_nameL = rank_nameL;
    }
    return _rank_nameL;
}

-(UILabel *)rank_nameL1{
    if (_rank_nameL1 == nil) {
        UILabel *rank_nameL1 = [UILabel new];
        rank_nameL1.text = @"伐木新手";
        rank_nameL1.textColor = [UIColor getColorWithTextTheme];
        rank_nameL1.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:rank_nameL1];
        _rank_nameL1 = rank_nameL1;
    }
    return _rank_nameL1;
}

-(UIImageView *)rank_imgV{
    if (_rank_imgV == nil) {
        UIImageView *rank_imgV = [UIImageView new];
        [self.contentView addSubview:rank_imgV];
        _rank_imgV = rank_imgV;
    }
    return _rank_imgV;
}

-(UIImageView *)rank_imgV1{
    if (_rank_imgV1 == nil) {
        UIImageView *rank_imgV1 = [UIImageView new];
        [self.contentView addSubview:rank_imgV1];
        _rank_imgV1 = rank_imgV1;
    }
    return _rank_imgV1;
}

-(UIButton *)rankUseBtn
{
    if (_rankUseBtn == nil) {
        UIButton *rankUseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rankUseBtn setTitle:@"使用" forState:UIControlStateNormal];
        rankUseBtn.backgroundColor = [UIColor getColorWithTheme];
        rankUseBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        rankUseBtn.layer.cornerRadius = 4;
        rankUseBtn.hidden = YES;
        rankUseBtn.layer.masksToBounds = YES;
        [rankUseBtn setTitle:@"使用中" forState:UIControlStateSelected];
        [rankUseBtn addTarget:self action:@selector(rankUseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:rankUseBtn];
        _rankUseBtn = rankUseBtn;
    }
    return _rankUseBtn;
}

-(UIButton *)rankUseBtn1
{
    if (_rankUseBtn1 == nil) {
        UIButton *rankUseBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [rankUseBtn1 setTitle:@"使用" forState:UIControlStateNormal];
        rankUseBtn1.backgroundColor = [UIColor getColorWithTheme];
        rankUseBtn1.titleLabel.font = [UIFont systemFontOfSize:12];
        rankUseBtn1.layer.cornerRadius = 4;
        rankUseBtn1.hidden = YES;
        rankUseBtn1.layer.masksToBounds = YES;
        [rankUseBtn1 setTitle:@"使用中" forState:UIControlStateSelected];
        [rankUseBtn1 addTarget:self action:@selector(rankUseBtn1Click:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:rankUseBtn1];
        _rankUseBtn1 = rankUseBtn1;
    }
    return _rankUseBtn1;
}

-(void)layoutSubviews{
    self.rank_imgV.frame = CGRectMake(20.0/375.0*screen_Width, 10.0/375.0*screen_Width, 45.5/375.0*screen_Width, 64.0/375.0*screen_Width);
    self.rank_nameL.frame = CGRectMake(85.5/375.0*screen_Width, 10.0, 55.0/375.0*screen_Width, 15);
    self.rankUseBtn.frame = CGRectMake(85.5/375.0*screen_Width, 41.0/375.0*screen_Width, 48.0/375.0*screen_Width, 24.0/375.0*screen_Width);
    self.rank_imgV1.frame = CGRectMake(20.0/375.0*screen_Width+screen_Width/2, 10.0/375.0*screen_Width, 45.5/375.0*screen_Width, 64.0/375.0*screen_Width);
    self.rank_nameL1.frame = CGRectMake(85.5/375.0*screen_Width+screen_Width/2, 10.0, 55.0/375.0*screen_Width, 15);
    self.rankUseBtn1.frame = CGRectMake(85.5/375.0*screen_Width+screen_Width/2, 41.0/375.0*screen_Width, 48.0/375.0*screen_Width, 24.0/375.0*screen_Width);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
