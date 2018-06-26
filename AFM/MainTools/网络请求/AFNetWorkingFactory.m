//
//  AFNetWorkingFactory.m
//  BabyProject
//
//  Created by 张凡 on 15/4/19.
//  Copyright (c) 2015年 zhangfan. All rights reserved.
//

#import "AFNetWorkingFactory.h"
@implementation AFNetWorkingFactory


///**
// *  设置URL(这里对string做个性化设置)
// *
// *  @param url
// *
// *  @return
// */
//- (NSString *)setURL:(NSString *)url {
//    return url;
//}
//
//
///**
// *  创建请求
// *
// *  @param url        请求地址
// *  @param parameters get请求参数
// *
// *  @return url
// */
//-(instancetype)getRequest:(NSString *)url Parameters:(id)parameters {
//    return [super getRequest:url Parameters:parameters];
//}
//
//
///**
// *  post请求
// *
// *  @param url
// *  @param parameters
// *
// *  @return
// */
//
//- (instancetype)postRequest:(NSString *)url Parameters:(id)parameters {
//    return [super postRequest:url Parameters:parameters];
//}





/**
 *  开始请求
 */
- (void)startRequest{
    if (self.blockBaseStart) {
        self.blockBaseStart();
    }
}


/**
 * 完成请求
 *
 */
- (void)finishResponseDict:(NSDictionary *)requestDict{
    if (requestDict == nil) {
        if (self.blockBaseError) {
            NSError *error = [self getError:@"数据异常"];
            self.blockBaseError(error);
        }
		
    }else {
		//NSLog(@"扩展工程完成:%@",requestDict);
		NSInteger respCode = [[requestDict objectForKey:@"code"] integerValue];
		if (respCode == 200){//请求完整正确
            if (self.blockBaseFinish) {
                self.blockBaseFinish(requestDict);
            }

        } else {//请求错误了
			if (self.blockBaseError){
				NSString *errorStr = [requestDict objectForKey:@"data"];
                NSError *error = [self getError:errorStr];
                self.blockBaseError(error);
            }
        }
    }
}


/**
 * 错误请求
 */
- (void)failureRequestError:(NSError *)error {
    if (self.blockBaseError){
        self.blockBaseError(error);
    }
}




/**
 *  取消请求
 */
- (void)cancelRequest {
    [super cancelRequest];
}



#pragma mark


/**
 *  请求错误
 *
 */
- (NSError *)getError:(NSString *)errorstr {
    
    NSLog(@"错误信息:%@",errorstr);
    if(!errorstr){
        errorstr = @"数据错误Code:-1";
    }
    
    errorstr = [NSString notEmpty:errorstr];
	NSLog(@" -- %@",errorstr);
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorstr forKey:NSLocalizedDescriptionKey];
    NSError *error = [NSError errorWithDomain:@"" code:-1000 userInfo:userInfo];
    return error;
}
@end


