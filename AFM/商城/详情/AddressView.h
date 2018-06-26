//
//  AddressView.h
//  AFM
//
//  Created by admin on 2017/9/8.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationViewController.h"
#import "BaseTabBarController.h"

@protocol addressDelegate <NSObject>

@optional
- (void)refreshAddr:(NSString *)name with:(NSString *)addr and:(NSString *)phone andId:(NSString *)Id  ;

@end
@interface AddressView : UIView


@property (weak, nonatomic) IBOutlet UIView *downView;
@property (weak, nonatomic) IBOutlet UIButton *addAd_Btn;
@property (weak, nonatomic) IBOutlet UIButton *ture_Btn;
@property (weak, nonatomic) IBOutlet UITableView *AtableView;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;

@property(nonatomic,assign)id<addressDelegate>delegate;



+ (AddressView *)creatInAddressView;

@end
