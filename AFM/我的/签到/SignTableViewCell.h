//
//  SignTableViewCell.h
//  AFM
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *YandN;//已签到/未签到
@property (weak, nonatomic) IBOutlet UILabel *day_Lab;
@property (weak, nonatomic) IBOutlet UIImageView *piao_Img;
@property (weak, nonatomic) IBOutlet UILabel *piao_Lab;
@property (weak, nonatomic) IBOutlet UIButton *YandN_Btn;

@property (nonatomic,assign) int index;
@property (nonatomic , strong) NSMutableArray *dataArray;            //
@property (nonatomic , assign) NSInteger *row;            //

@end
