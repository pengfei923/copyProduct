//
//  AFMRankCell1.h
//  ifarm
//
//  Created by 蒙傅 on 2017/8/14.
//  Copyright © 2017年 蒙傅. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AFMRankModel.h"
#import "ChengHViewController.h"

@interface AFMRankCell1 : UITableViewCell

@property (nonatomic,strong) UIImageView *rank_imgV;

@property (nonatomic,strong) UILabel *rank_nameL;

@property (nonatomic,strong) UIButton *rankUseBtn;

@property (nonatomic,strong) UIImageView *rank_imgV1;

@property (nonatomic,strong) UILabel *rank_nameL1;

@property (nonatomic,strong) UIButton *rankUseBtn1;

@property (nonatomic,strong)MyChengHaoModelCell *model;

@property (nonatomic,strong)MyChengHaoModelCell *model1;

@end
