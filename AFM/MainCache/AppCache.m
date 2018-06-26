//
//  AppCache.m
//  LepeiLeshu
//
//  Created by 王恩年 on 17/8/28.
//  Copyright © 2017年 Mondeo. All rights reserved.
//


#import "AppCache.h"

#define DEVICEFIRST @"deviceFirst"
#define ACCOUNTPHINE @"accountPhone"
#define LOCATIONMODEL @"locationModel"

@implementation AppCache
@synthesize accountPhone = my_accountPhone;
@synthesize deviceFirst = my_deviceFirst;
@synthesize loginViewModel = my_loginViewModel;
@synthesize homeAdmodel = my_homeAdmodel;       //首页广告轮播

#pragma mark - 初始化
/**
 *
 *  @return 当前实例化对象
 */
+(AppCache *)sharedInstance{
    __strong static AppCache *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[AppCache alloc]init];
        
        NSString *basePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) firstObject];
        cache.yycache = [[YYDiskCache alloc] initWithPath:[basePath stringByAppendingPathComponent:@"AFM"]];
        cache.accountPhone = cache.accountPhone;
        cache.deviceFirst = cache.deviceFirst;

        
    });
    return cache;
}

- (void)setBundleName:(NSString *)bundleName {
    _bundleName = bundleName;
}

- (void)setBundleShortVersion:(NSString *)bundleShortVersion {
    _bundleShortVersion = bundleShortVersion;
}

- (void)setBundleVersion:(NSString *)bundleVersion {
    _bundleVersion = bundleVersion;
}



#pragma mark - 判断是不是第一次启动
- (void)setDeviceFirst:(bool)deviceFirst {
    my_deviceFirst = deviceFirst;
    [[NSUserDefaults standardUserDefaults] setBool:my_deviceFirst forKey:DEVICEFIRST];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (bool)deviceFirst {
    BOOL deviceFirst = [[NSUserDefaults standardUserDefaults] boolForKey:DEVICEFIRST];
    return deviceFirst;
}


#pragma mark - 保存登录账号
- (void)setAccountPhone:(NSString *)accountPhone {
    my_accountPhone = accountPhone;
    [[NSUserDefaults standardUserDefaults] setObject:my_accountPhone forKey:ACCOUNTPHINE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (NSString *)accountPhone {
    NSString *accountPhone = [[NSUserDefaults standardUserDefaults] stringForKey:ACCOUNTPHINE];
    return accountPhone;
}

#pragma mark - 登录信息缓存
/**
 *  登录信息
 */
- (void)setLoginViewModel:(UserInfoModel *)loginViewModel {
    if (loginViewModel) {
        if (loginViewModel != my_loginViewModel) {
            my_loginViewModel = loginViewModel;

            [self.yycache setObject:[my_loginViewModel yy_modelToJSONString] forKey:@"loginViewModel" withBlock:^{// 异步缓存
                NSLog(@"《登录数据缓存完成》");
            }];
        }else {
            NSLog(@"《登录数据相同》");
        }
    }else {
        my_loginViewModel = loginViewModel;
        [self.yycache setObject:[my_loginViewModel yy_modelToJSONString] forKey:@"loginViewModel" withBlock:^{// 异步缓存
            NSLog(@"《退出登录成功》");
        }];
    }
}


- (UserInfoModel *)loginViewModel {
    if (!my_loginViewModel) {
        NSDictionary *dic = (NSDictionary *)[self.yycache objectForKey:@"loginViewModel"];
        my_loginViewModel = [UserInfoModel yy_modelWithJSON:dic];
    }
    return my_loginViewModel;
}


//轮播
- (void)setHomeAdmodel:(HeaderModel *)homeAdmodel {
    if (homeAdmodel) {
        if (homeAdmodel != my_homeAdmodel) {
            my_homeAdmodel = homeAdmodel;
            [self.yycache setObject:[my_homeAdmodel yy_modelToJSONString] forKey:@"homeAdmodel" withBlock:^{// 异步缓存
                NSLog(@"《广告轮播数据缓存完成》");
            }];
        }else {
            NSLog(@"《广告轮播数据相同》");
        }
    }else {
        NSLog(@"《广告轮播数据缺失》");
    }
}


- (HeaderModel *)homeAdmodel {
    if (!my_homeAdmodel) {
        NSString *dic = (NSString *)[self.yycache objectForKey:@"homeAdmodel"];
        my_homeAdmodel = [HeaderModel yy_modelWithJSON:dic];
    }
    return my_homeAdmodel;
}


@end
