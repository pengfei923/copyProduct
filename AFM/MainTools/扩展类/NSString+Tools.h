//
//  NSString+Tools.h
//  BabyProject
//
//  Created by 张凡 on 15/4/28.
//  Copyright (c) 2015年 zhangfan. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <CoreGraphics/CGGeometry.h>
//#import <UIKit/UIKit.h>

@interface NSString (Tools)




/**
 *  计算字符串的宽度和高度
 *
 *  @param font          字体大小
 *  @param size          最大的尺寸
 *
 *  @return CGSize
 */
- (CGSize)getNSStringSize:(UIFont *)font constrainedToSize:(CGSize)size;


/**
 * 计算文本的宽度
 *
 *  @param font 字体大小
 *
 *  @return 宽度
 */
-(CGFloat)getNSStringWidth:(UIFont *)font;


/**
 * 计算文本的高度
 *
 *  @param font 字体大小
 *
 *  @return 高度
 */
-(CGFloat)getNSStringHeight:(UIFont*)font andTextWidth:(CGFloat)width;



/**
 *  判断邮箱格式
 *
 *  @return bool
 */
- (BOOL)Email;



/**
 *  正常号转银行卡号 －
 *
 *  @return 增加4位间的空格
 */
-(NSString *)normalNumToBankNum;



/**
 *  正常号转银行卡号 － *号
 *
 *  @return 增加4位间的空格
 */
-(NSString *)normalNumToBankNum_X;


/**
 *   银行卡号转正常号
 *
 *  @return 去除4位间的空格
 */
-(NSString *)bankNumToNormalNum;



/**
 *  判断字符串是不是空内容
 *
 *  @return NSString
 */
+ (NSString *)notEmpty:(NSString *)str;


/**
 *  字典转json
 *
 *  @param dic 字典
 *
 *  @return json
 */
+ (NSString *)stringToJsonDic:(id)dic;



/**
 *  获取当前的手机时间(年,月,日)
 *
 *  @return 年月日 string
 */
+ (NSString *)getToDate;



/**
 *  获取当前的手机时间(年,月,日,时,分,秒)
 *
 *  @return 年月日时分秒 string
 */
+ (NSString *)getToDateAndday;



/**
 *  获取时间戳
 *
 *  @return 时间戳
 */
+ (NSString *)getToDateAndTimestamp;



/**
 *  通过NSDate获取时间string
 *
 *  @param date NSDate对象
 *
 *  @return NSDate转string
 */
+ (NSString *)getToDateForStr:(NSDate *)date;



/**
 *  通过NSDate获取时间string
 *
 *  @param date NSDate对象
 *
 *  @return NSDate转string
 */
+ (NSString *)getToDateForYear:(NSDate *)date;



/**
 *  通过NSDate获取时间string
 *
 *  @param date NSDate对象
 *
 *  @return NSDate转string
 */
+ (NSString *)getToDateForMonthly:(NSDate *)date;



/**
 *  通过string获取时间string
 *
 *  @param str_date string对象
 *
 *  @return NSString 转 string
 */
+ (NSString *)getToStrForStr:(NSString *)str_date;



/**
 *  读取NSUserDefaults
 *
 *  @param key key
 *
 *  @return 数据内容
 */
+ (NSString *)readDateKey:(NSString *)key;



/**
 *  写入NSUserDefaults
 *
 *  @param key  key
 *  @param data data
 *
 *  @return 是否写入完成
 */
+ (BOOL)writeDateKey:(NSString *)key andData:(NSString *)data;

/**
 *  对URL链接进行编码
 *
 *  @param str 需要编码的字符串
 *
 *  @return URL编码结果
 */
+ (NSString *)URLEncodedString:(NSString *)str;


/**
 *  对URL链接进行反编码
 *
 *  @param str 需要编码的字符串
 *
 *  @return URL编码结果
 */
+ (NSString *)URLDecodedString:(NSString *)str;



/**
 string转dic
 
 @param jsonString string
 @return 字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end
