//
//  MyInfoViewController.h
//  AFM
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BaseViewController.h"
@class HeadImgModel;
@class UserModel;
@class SanModel;

@interface MyInfoViewController : BaseViewController
//@property (nonatomic , strong) UserModel *userModelCell;
@property (nonatomic , strong) SanModel  *SanModelCell;

@end



@interface HeadImgModel : NSObject
@property (nonatomic , strong) NSString *celltitle;
@property (nonatomic , strong) NSString *celllogoimg;
@property (nonatomic , strong) NSString *cellaccessoryimg;
@end

@interface UserModel : NSObject
@property (nonatomic , strong) NSString *avatar_img;
@property (nonatomic , strong) NSString *diamond;
@property (nonatomic , strong) NSString *entrance_ticket;
@property (nonatomic , strong) NSString *gold;
@property (nonatomic , strong) NSString *Id;
@property (nonatomic , strong) NSString *is_guide;
@property (nonatomic , strong) NSString *phone;
@property (nonatomic , strong) NSString *token;
@property (nonatomic , strong) NSString *type;
@property (nonatomic , strong) NSString *username;
@property (nonatomic , strong) NSString *uid;
@property (nonatomic , strong) NSString *today_guess_num;
@property (nonatomic , strong) NSString *rank;
@property (nonatomic , strong) NSString *rank_img;
@property (nonatomic , strong) NSString *rank_name;
@end



@interface SanModel : NSObject
@property (nonatomic , strong) NSString *bind_phone;
@property (nonatomic , strong) NSString *bind_qq;
@property (nonatomic , strong) NSString *bind_wb;
@property (nonatomic , strong) NSString *bind_wx;
@end



/*

 extra_data = (
 );
	data = {
 "bind_phone" = 26424957136;
 "bind_qq" = "";
 "bind_wb" = "";
 "bind_wx" = "";
 };
	msg = 获取成功;
	error = 0;
 
 **/
