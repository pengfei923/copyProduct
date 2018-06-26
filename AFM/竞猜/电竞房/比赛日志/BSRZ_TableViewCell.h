//
//  BSRZ_TableViewCell.h
//  AFM
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJ_PlayerViewController.h"

@interface BSRZ_TableViewCell : UITableViewCell
@property (nonatomic , strong) UITableView *tableView2;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *downView;


@property (weak, nonatomic) IBOutlet UIButton *jinS_Btn;
@property (weak, nonatomic) IBOutlet UIButton *all_Btn;
@property (weak, nonatomic) IBOutlet UIButton *benS_Btn;



@property (nonatomic , strong) DJ_PlayerModelCell  *model;

@end
