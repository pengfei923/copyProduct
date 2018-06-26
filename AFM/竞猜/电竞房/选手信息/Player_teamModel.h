//
//  Player_teamModel.h
//  AFM
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Player_teamModelCell;

@interface Player_teamModel : NSObject

@property (nonatomic, strong) NSArray<Player_teamModelCell *> *data;

@end




@interface Player_teamModelCell : NSObject

@property (nonatomic , strong) NSString *Id;           //":"队伍的id号",
@property (nonatomic , strong) NSString *name;         //":"队伍的名称",
@property (nonatomic , strong) NSString *e_name;       //":"队伍英文名称",
@property (nonatomic , strong) NSString *short_name;   //":"简称",
@property (nonatomic , strong) NSString *location;     //":"赛区",
@property (nonatomic , strong) NSString *Union;        //":"联盟",
@property (nonatomic , strong) NSString *img;          //":"队伍的图标",
@property (nonatomic , strong) NSString *home_court;   //":"主场",
@property (nonatomic , strong) NSString *project_name; //":"项目名称",
@property (nonatomic , strong) NSString *location_name;//":"赛区名称",
@property (nonatomic , strong) NSString *union_name;   //":"联盟名称"

@end
