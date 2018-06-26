//
//  AFMRankModel.m
//  ifarm
//
//  Created by 蒙傅 on 2017/8/14.
//  Copyright © 2017年 蒙傅. All rights reserved.
//

#import "AFMRankModel.h"

@implementation AFMRankModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        self.rank_id = value;
    }
}

@end
