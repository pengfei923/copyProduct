//
//  ChatModel.m
//  AFM
//
//  Created by admin on 2017/10/12.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "ChatModel.h"


@implementation ChatModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [ChatModelCell class]};
}
@end


@implementation ChatModelCell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}



@end



