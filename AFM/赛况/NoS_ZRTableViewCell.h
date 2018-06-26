//
//  NoS_ZRTableViewCell.h
//  AFM
//
//  Created by admin on 2017/9/26.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SK_WeiModel.h"

@interface NoS_ZRTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *zr_Lab;
@property (weak, nonatomic) IBOutlet UILabel *CYRoom_lab;
@property (weak, nonatomic) IBOutlet UILabel *PJ_Lab;
@property (weak, nonatomic) IBOutlet UIButton *C_Button;
@property (weak, nonatomic) IBOutlet UIButton *IMG_Btn;
@property (nonatomic,strong) UIViewController *controller;


@property (nonatomic , strong) NSString  *fenshuType;

@property (nonatomic , strong) SK_WeiModelCell  *Player;

@property (nonatomic, assign, getter = isExpandable) BOOL expandable;
@property (nonatomic, assign, getter = isExpanded) BOOL expanded;

- (void)addIndicatorView;
- (void)removeIndicatorView;
- (BOOL)containsIndicatorView;
- (void)accessoryViewAnimation;



@end



