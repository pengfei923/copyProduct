//
//  AFNetWorkingBaseFactory.h
//  BabyProject
//
//  Created by 张凡 on 15/4/19.
//  Copyright (c) 2015年 zhangfan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
//#import <AFNetworking/AFNetworkActivityIndicatorManager.h>


/**
 请求类型
 */
typedef enum : NSUInteger {
    httprequestGet,
    httprequestPost,
} method;


/**
 *
 *
 *
 *
 *
 */

/**
 *  开始请求
 */
typedef void(^requestStart)(void);

/**
 *  完成请求
 *
 *  @param dictionary 获取带字典数据
 */
typedef void(^requestFinish)(NSDictionary *dictionary);

/**
 *  请求错误
 *
 *  @param error 错误数据
 */
typedef void(^requestError)(NSError *error);



@interface AFNetWorkingBaseFactory : NSObject
#pragma mark - 自定义的block
@property (nonatomic ,copy)requestStart blockBaseStart;   //开始
@property (nonatomic ,copy)requestFinish blockBaseFinish; //完成
@property (nonatomic ,copy)requestError blockBaseError;   //错误

#pragma  mark - 全局方法
+ (NSString *)stringByEncoding_UTF8:(NSString *)string;//转UTF-8编码
+ (void)getNetWorkStatus;//监听网络状态

#pragma  mark - get请求
- (instancetype)getRequest:(NSString *)url;
- (instancetype)getRequest:(NSString *)url Parameters:(id)parameters;

#pragma  mark - post请求
- (instancetype)postRequest:(NSString *)url;
- (instancetype)postRequest:(NSString *)url Parameters:(id)parameters ;

#pragma  mark - get or post请求
- (instancetype)initRequest:(NSString *)url Parameters:(id)parameters Method:(method)method;


/**
 *  开始请求
 */
- (void)startRequest;


/**
 *  完成请求
 */
- (void)finishResponseDict:(NSDictionary *)requestDict;


/**
 *  错误请求
 */
- (void)failureRequestError:(NSError *)error;


/**
 *  取消请求
 */
- (void)cancelRequest;



#pragma mark - ==================================

- (NSString *)setURL:(NSString *)url;//设置URL

#pragma mark - ==================================



@end
