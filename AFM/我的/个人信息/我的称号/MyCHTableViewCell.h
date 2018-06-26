//
//  MyCHTableViewCell.h
//  AFM
//
//  Created by admin on 2017/9/7.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChengHViewController.h"
#import "ChengHViewController.h"

typedef void(^SelectedBtnBlock)(NSString *Tag);

@interface MyCHTableViewCell : UITableViewCell
@property (nonatomic, copy) SelectedBtnBlock selectedBlock;

@property (strong, nonatomic)MyChengHaoModelCell *model;
@property (strong, nonatomic)NSMutableArray *myRankArray;          //
@property (strong, nonatomic)NSString *Token_cell;          //
@property (strong, nonatomic)NSString *RANK;          //

@end
