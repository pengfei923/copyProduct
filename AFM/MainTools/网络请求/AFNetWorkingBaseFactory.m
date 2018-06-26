//
//  AFNetWorkingBaseFactory.m
//  BabyProject
//
//  Created by 张凡 on 15/4/19.
//  Copyright (c) 2015年 zhangfan. All rights reserved.
//

#import "AFNetWorkingBaseFactory.h"

@interface AFNetWorkingBaseFactory (){
	NSString *selfurl;//地址
	method httpmethod;	// 请求方式
	AFHTTPSessionManager *manager;//请求管理器
}
@end

@implementation AFNetWorkingBaseFactory

/**
 *  监听网络状态
 */
+ (void)getNetWorkStatus{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"网络状态是: %ld", (long)status);
    }];
}


/**
 *  转UTF-8编码
 *
 *
 *
 *  
 */
+ (NSString *)stringByEncoding_UTF8:(NSString *)string {
    return [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


//====================================公共方法=========================================

#pragma  mark - get请求
/**
 *  创建请求
 *
 *  @param url 请求地址
 */
- (instancetype)getRequest:(NSString *)url{
    return [self getRequest:url Parameters:nil];
}


/**
 *  创建请求
 *
 *  @param url        请求地址
 *  @param parameters get请求参数
 *
 *  @return url
 */
- (instancetype)getRequest:(NSString *)url Parameters:(id)parameters {
    return [self initRequest:url  Parameters:parameters Method:httprequestGet];
}


#pragma  mark - post请求
/**
 *  创建请求
 *
 *  @param url        请求地址
 *
 *  @return url
 */
- (instancetype)postRequest:(NSString *)url {
    return [self postRequest:url Parameters:nil];
}

/**
 *  创建请求
 *
 *  @param url        请求地址
 *  @param parameters post参数
 *
 *  @return url
 */
- (instancetype)postRequest:(NSString *)url Parameters:(id)parameters {
    return [self initRequest:url Parameters:parameters Method:httprequestPost];
}



/**
 *  初始化
 *
 *  @param url        请求地址
 *  @param parameters 参数 可以是ni
 *
 *  @return 实例化对象
 */
- (instancetype)initRequest:(NSString *)url  Parameters:(id)parameters Method:(method)method{
    
    self = [self init];
    
    if (self) {
        
        //请求方式
        httpmethod = method;
        
        //请求地址
        selfurl = [self setURL:url];
        
        //请求管理器
        manager = [AFHTTPSessionManager manager];
        
        //请求时间
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
		
        manager.requestSerializer.timeoutInterval = 10.f;
		
		[manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        //设置请求格式
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];

        //设置返回格式
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
		
        //缓存机制
        //manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
        
        //
        //[manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        
        
        //对特定的 URL 请求使用网络协议中实现的缓存逻辑。这是默认的策略。
        //NSURLRequestUseProtocolCachePolicy = 0,
        
        //数据需要从原始地址加载。不使用现有缓存。
        //NSURLRequestReloadIgnoringLocalCacheData = 1,
        //NSURLRequestReloadIgnoringCacheData = NSURLRequestReloadIgnoringLocalCacheData,
        
        //不仅忽略本地缓存，同时也忽略代理服务器或其他中间介质目前已有的、协议允许的缓存。
        //NSURLRequestReloadIgnoringLocalAndRemoteCacheData = 4,
        
        //无论缓存是否过期，先使用本地缓存数据。如果缓存中没有请求所对应的数据，那么从原始地址加载数据。
        //NSURLRequestReturnCacheDataElseLoad = 2,
        
        //无论缓存是否过期，先使用本地缓存数据。如果缓存中没有请求所对应的数据，那么放弃从原始地址加载数据，请求视为失败（即：“离线”模式）。
        //NSURLRequestReturnCacheDataDontLoad = 3,
        
        //从原始地址确认缓存数据的合法性后，缓存数据就可以使用，否则从原始地址加载。
        //NSURLRequestReloadRevalidatingCacheData = 5,
        
        
        
        //判断请求方式
        switch (httpmethod) {
                
            case httprequestGet://get请求
                //NSLog(@"get请求");
                [self getJSONWithUrl:selfurl parameters:parameters];
                break;
                
            case httprequestPost://post请求
                //NSLog(@"post请求");
                [self postJSONWithUrl:selfurl parameters:parameters];
                break;
                
            default:
                break;
        }
    }
    
    
    return self;
    
}


//===================================================================================


#pragma  mark -  - 私有方法
//设置block
- (void)setBlockBaseStart:(requestStart)block {
	_blockBaseStart = block;
	[self startRequest];
}


//get请求
- (void)getJSONWithUrl:(NSString *)url parameters:(id)parameters{
	
	[manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
		
	}success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
		[self finishResponseDict:dic];
		
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
		[self failureRequestError:error];
	}];
	
}


//post请求
- (void)postJSONWithUrl:(NSString *)urlStr parameters:(id)parameters {
	
	[manager POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
		
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
		[self finishResponseDict:dic];
		
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		[self failureRequestError:error];

	}];
}



//开始请求
- (void)startRequest{
    if (self.blockBaseStart) {
        self.blockBaseStart();
    }
    NSLog(@"基础工程开始");
}



//完成请求
- (void)finishResponseDict:(NSDictionary *)requestDict{
    if (self.blockBaseFinish) {
        self.blockBaseFinish(requestDict);
    }
    NSLog(@"基础工程完成");
}


/**
 *  错误请求
 */
- (void)failureRequestError:(NSError *)error{
    if (self.blockBaseError) {
        self.blockBaseError(error);
    }
    NSLog(@"基础工程错误:%ld",(long)error.code);
}


/**
 *  取消请求
 */
- (void)cancelRequest {
    if (manager) {
		//[manager.operationQueue waitUntilAllOperationsAreFinished];
        //NSLog(@"取消请求");
    }
}




/**
 *  消亡
 */
- (void)dealloc {
    [self cancelRequest];
}




#pragma mark - -《工具方法》
/**
 *  设置URL
 */
- (NSString *)setURL:(NSString *)url {
	return url;
}
@end
