//
//  ADessTableViewCell.h
//  AFM
//
//  Created by admin on 2017/9/8.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADessTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name_Lab;
@property (weak, nonatomic) IBOutlet UILabel *moren_Lab;
@property (weak, nonatomic) IBOutlet UILabel *phone_Lab;
@property (weak, nonatomic) IBOutlet UILabel *address_Lab;
@property (weak, nonatomic) IBOutlet UIButton *cloose_Btn;

@end
