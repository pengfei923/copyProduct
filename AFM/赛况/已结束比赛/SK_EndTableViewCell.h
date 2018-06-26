//
//  SK_EndTableViewCell.h
//  AFM
//
//  Created by admin on 2017/9/20.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController_Page2.h"

@interface SK_EndTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *left_Img;
@property (weak, nonatomic) IBOutlet UILabel *title_Lab;
@property (weak, nonatomic) IBOutlet UILabel *PM_Lab;
@property (weak, nonatomic) IBOutlet UILabel *ZRJF_Lab;
@property (weak, nonatomic) IBOutlet UILabel *JL_Lab;
@property (weak, nonatomic) IBOutlet UIImageView *JL_Img;
@property (weak, nonatomic) IBOutlet UIButton *turnBtn;
@property (weak, nonatomic) IBOutlet UILabel *MP_Lab;
@property (weak, nonatomic) IBOutlet UILabel *ZS_Lab;

@property (nonatomic , strong) Home2_ENDListModelCell *Model;

@end
