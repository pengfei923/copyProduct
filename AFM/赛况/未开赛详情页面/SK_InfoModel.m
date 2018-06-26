//
//  SK_InfoModel.m
//  AFM
//
//  Created by admin on 2017/9/26.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "SK_InfoModel.h"


@implementation SK_InfoModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [SK_InfoModelCell class]};
}
@end


@implementation SK_InfoModelCell
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"lineup_info":[SK_InfoLineupInfoData class] ,@"room_info":[SK_InfoRoomData class], @"user_rank":[SK_InfoUser_RData class],@"all_user_rank":[SK_InfoUser_RankData class] ,@"lineup_player":[SK_InfoLineup_PlayerData class] };
}

@end
//------玩家排名
@implementation SK_InfoUser_RankData
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}

@end
//------阵容详情
@implementation SK_InfoLineup_PlayerData
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"match_data":[SK_LupP_MatchData class] };
}
@end

//------ 队员数据
@implementation SK_LupP_MatchData
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}
@end

//------12345678
@implementation SK_InfoLineupInfoData
@end


//------用户排名信息
@implementation SK_InfoUser_RData
@end



//------房间详情
@implementation SK_InfoRoomData
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"match_list":[SK_RoomInfoMatch_listData class] , @"join_user":[SK_RoomInfoJoin_userData class] , @"lineup":[SK_RoomInfolineup_Data class]};
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id" ,@"SKnew_hand" : @"new_hand" };
}
@end

//----------------------------------------------------

//------战况
@implementation SK_RoomInfoMatch_listData
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}
@end
//------参与用户
@implementation SK_RoomInfoJoin_userData
@end
//------ 位置
@implementation SK_RoomInfolineup_Data
@end






