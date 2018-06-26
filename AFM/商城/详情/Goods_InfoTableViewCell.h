//
//  Goods_InfoTableViewCell.h
//  AFM
//
//  Created by admin on 2017/9/8.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoHeaderView.h"
#import "GoodsInfoViewController.h"

typedef void (^ReturnValueBlock) (NSString *strValue);

@interface Goods_InfoTableViewCell : UITableViewCell
@property(nonatomic, copy) ReturnValueBlock returnValueBlock;


@property (weak, nonatomic) IBOutlet InfoHeaderView *headerview;
@property (weak, nonatomic) IBOutlet UILabel *name_Lab;
@property (weak, nonatomic) IBOutlet UILabel *price_Lab;
@property (weak, nonatomic) IBOutlet UIImageView *priceImg_View;


@property (weak, nonatomic) IBOutlet UITextField *DBField;
@property (weak, nonatomic) IBOutlet UIButton *minBtn;
@property (weak, nonatomic) IBOutlet UIButton *maxBtn;

@property (assign, nonatomic)int MaxNum;

@property (nonatomic , strong) GoodsInfoViewController *goodsViewController;
@property (nonatomic , strong) GoodsInfoModel *goodsmodel;


@end
