//
//  GoodsCollectionViewCell.h
//  AFM
//
//  Created by admin on 2017/9/5.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *url_ImgView;
@property (weak, nonatomic) IBOutlet UILabel *title_Lab;
@property (weak, nonatomic) IBOutlet UIImageView *type_ImgView;
@property (weak, nonatomic) IBOutlet UILabel *num_Lab;
@property (weak, nonatomic) IBOutlet UILabel *people_Lab;
@property (strong , nonatomic) UIViewController *controller;

@end
