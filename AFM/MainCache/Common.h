//
//  Common.h
//  HuaRenWang
//  #define
///  Created by 王恩年 on 17/8/28.
//  Copyright © 2017年 Mondeo. All rights reserved.
//


#import <UIKit/UIKit.h>

#define screen_Width [UIScreen mainScreen].bounds.size.width
#define screen_Height [UIScreen mainScreen].bounds.size.height

/*********************后台接口***********************/

#define SERVERIP1                @"http://api.aifamu.com/index.php?version=1&apptype=app&g=api&"                // 后台客户端地址
#define SERVERIP2                @"http://api.aifamu.com/index.php?version=2&apptype=app&g=api&"                // 后台客户端地址




#define ApiUserGoods_home        SERVERIP1@"m=shop&a=hot_goods"            //商城首页商品列表
#define ApiUserGoods_list        SERVERIP1@"m=shop&a=goods_list"           //全部商品列表








//-----------------------我的-------------------------------
#define ApiUserUser_info        SERVERIP2@"m=public&a=check_token"           //勋章称号列表

#define ApiUserMedal_list        SERVERIP1@"m=shop&a=goods_list"           //勋章称号列表






