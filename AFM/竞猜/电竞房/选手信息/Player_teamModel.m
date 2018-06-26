//
//  Player_teamModel.m
//  AFM
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "Player_teamModel.h"

@implementation Player_teamModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [Player_teamModelCell class]};
}

@end


@implementation Player_teamModelCell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id" , @"Union" : @"union"};
}

@end
