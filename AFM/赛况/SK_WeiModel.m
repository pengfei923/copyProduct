//
//  SK_WeiModel.m
//  AFM
//
//  Created by admin on 2017/9/28.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "SK_WeiModel.h"


@class SK_Wei_RoomInfoData;
@class SK_Wei_LineupData;
@class SK_Wei_PlayerInfoData;

@implementation SK_WeiModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [SK_WeiModelCell class]};
}
@end

//--------
@implementation SK_WeiModelCell
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"room_info":[SK_Wei_RoomInfoData class] ,@"lineup":[SK_Wei_LineupData class], @"player_lineup_info":[SK_Wei_PlayerInfoData class],@"team_info":[SK_Wei_TeamInfoData class] };
}


@end

//------房间详情
@implementation SK_Wei_RoomInfoData
//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"match_list":[SK_Wei_RoomInfoData class] ,@"lineup":[SK_Wei_LineupData class]};
//}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id" , @"isnew_hand" : @"new_hand"};
}
@end





//------选手详情
@implementation SK_Wei_PlayerInfoData
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id" };
}
@end




//------121354位置
@implementation SK_Wei_LineupData
@end

@implementation SK_Wei_TeamInfoData
@end
