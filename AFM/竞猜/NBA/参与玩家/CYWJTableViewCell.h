//
//  CYWJTableViewCell.h
//  AFM
//
//  Created by admin on 2017/9/13.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYWJTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *name_Lab;
@property (weak, nonatomic) IBOutlet UILabel *ch_Lab;
@property (weak, nonatomic) IBOutlet UIImageView *ch_ImgView;
@property (weak, nonatomic) IBOutlet UILabel *num_Lab;

@end
