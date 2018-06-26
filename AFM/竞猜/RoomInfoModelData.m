//
//  RoomInfoModelData.m
//  AFM
//
//  Created by admin on 2017/9/18.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "RoomInfoModelData.h"

@implementation RoomInfoModelData
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [RoomInfoModelDataCell class]};
}
@end




@implementation RoomInfoModelDataCell
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"match_list":[RoomInfoMatch_listData class] , @"join_user":[RoomInfoJoin_userData class],@"lineup":[RoomInfoLineupData class] , @"reward_rule_k":[RoomInfoReward_ruleData class]};
    
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id" , @"isnew_hand" : @"new_hand"};
}
@end



//
@implementation RoomInfoMatch_listData
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id" };
}
@end
//
@implementation RoomInfoJoin_userData

@end
//
@implementation RoomInfoLineupData

@end
//
@implementation RoomInfoReward_ruleData


@end
