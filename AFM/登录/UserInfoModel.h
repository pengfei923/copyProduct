//
//  UserInfoModel.h
//  AFM
//
//  Created by admin on 2017/9/4.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BaseModel.h"


@interface UserInfoModel : BaseModel

@property (nonatomic , strong) NSString *token;                              //user_token
@property (nonatomic , strong) NSString *avatar_img;                         //头像图片
@property (nonatomic , strong) NSString *Id;                                 //id
@property (nonatomic , strong) NSString *username;                           //用户名
@property (nonatomic , strong) NSString *entrance_ticket;                    //门票
@property (nonatomic , strong) NSString *diamond;                            //砖石
@property (nonatomic , strong) NSString *gold;                               //木头
@property (nonatomic , strong) NSString *rank;                               //用户当前使用的徽章id
@property (nonatomic , strong) NSString *phone;                              //手机号
@property (nonatomic , strong) NSString *type;                               //注册类型，1为手机，2为qq，3为微信，4为微博
@property (nonatomic , strong) NSString *add_time;                           //注册时间
@property (nonatomic , strong) NSString *last_time;                          //最后登录时间
@property (nonatomic , strong) NSString *rank_name;                          //初入篮坛


@end







