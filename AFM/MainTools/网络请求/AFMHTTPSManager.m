//
//  HTTPSManager.m
//  aifamu
//
//  Created by 蒙傅 on 2017/2/4.
//  Copyright © 2017年 fumeng. All rights reserved.
//

#import "AFMHTTPSManager.h"

@implementation AFMHTTPSManager

+ (AFSecurityPolicy *)customSecurityPolicy
{
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    return securityPolicy;
}

@end
