//
//  LoginViewController.h
//  AFM
//
//  Created by admin on 2017/9/1.
//  Copyright © 2017年 sgamer. All rights reserved.
//
#import <UMSocialCore/UMSocialCore.h>
#import "BaseViewController.h"
#import "UserInfoModel.h"


@interface LoginViewController : BaseViewController

@property (nonatomic , strong) UserInfoModel *userModelCell;

@property(nonatomic, copy)void(^resultBlock)(NSString *str, NSString *str2);

@end
