//
//  HTTPSManager.h
//  aifamu
//
//  Created by 蒙傅 on 2017/2/4.
//  Copyright © 2017年 fumeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFMHTTPSManager : NSObject

+ (AFSecurityPolicy *)customSecurityPolicy;

@end
