//
//  MessageTableViewCell.h
//  AFM
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageViewController.h"

@interface MessageTableViewCell : UITableViewCell

@property (nonatomic, strong) MessageListModelCell *Model;		      //



@property (weak, nonatomic) IBOutlet UIView *YandN;      //已读未读
@property (weak, nonatomic) IBOutlet UILabel *title_Lab;
@property (weak, nonatomic) IBOutlet UILabel *msg_Lab;
@property (weak, nonatomic) IBOutlet UILabel *time_Lab;
@property (weak, nonatomic) IBOutlet UIButton *delete_Btn;

@end
