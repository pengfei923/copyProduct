//
//  ZR_PlayerCollectionViewCell.h
//  AFM
//
//  Created by admin on 2017/9/15.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZR_PlayerCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *downView;
@property (weak, nonatomic) IBOutlet UILabel *biao_Lab;
@property (weak, nonatomic) IBOutlet UIImageView *icon_Img;
@property (weak, nonatomic) IBOutlet UILabel *name_Lab;
@property (weak, nonatomic) IBOutlet UILabel *left_lab;
@property (weak, nonatomic) IBOutlet UILabel *right_Lab;

@end
