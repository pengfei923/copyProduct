//
//  NSString+Tools.m
//  BabyProject
//
//  Created by 张凡 on 15/4/28.
//  Copyright (c) 2015年 zhangfan. All rights reserved.
//

#import "NSString+Tools.h"
#import "CommonCrypto/CommonDigest.h"

@implementation NSString (Tools)


/**
 *  计算字符串的宽度和高度
 *
 *  @param font          字体大小
 *  @param size          最大的尺寸
 *  @param lineBreakMode
 *
 *  @return CGSize
 */
- (CGSize)getNSStringSize:(UIFont *)font constrainedToSize:(CGSize)size {
    CGSize textSize;
    if (CGSizeEqualToSize(size, CGSizeZero)){
        //NSDictionary *attributes = @{NSFontAttributeName:font}
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        textSize = [self sizeWithAttributes:attributes];
    }
    
    else{
        NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        //NSStringDrawingTruncatesLastVisibleLine如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。
        //如果指定了NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略 NSStringDrawingUsesFontLeading计算行高时使用行间距。（译者注：字体大小+行间距=行高）
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        CGRect rect = [self boundingRectWithSize:size options:option attributes:attributes context:nil];
        textSize = rect.size;
    }
    return textSize;
}


/**
 * 计算文本的宽度
 *
 *  @param font 字体大小
 *
 *  @return 宽度
 */
-(CGFloat)getNSStringWidth:(UIFont*)font {
    
    CGSize  sizeName = [self getNSStringSize:font constrainedToSize:CGSizeMake(MAXFLOAT, 0.0)];
    
    return sizeName.width;
    
}


/**
 * 计算文本的高度
 *
 *  @param font 字体大小
 *
 *  @return 高度
 */
-(CGFloat)getNSStringHeight:(UIFont*)font andTextWidth:(CGFloat)width {
    
    CGSize  sizeName = [self getNSStringSize:font constrainedToSize:CGSizeMake(width, 0.0)];
    
    return sizeName.height;
}



/**
 *  判断邮箱格式
 *
 *  @param email 邮箱账号
 *
 *  @return bool
 */
- (BOOL) Email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}



/**
 *  正常号转银行卡号
 *
 *  @return 增加4位间的空格
 */
-(NSString *)normalNumToBankNum {
    
    NSString *tmpStr = [self bankNumToNormalNum];
    
    NSUInteger size = (tmpStr.length / 4);
    
    NSMutableArray *tmpStrArr = [[NSMutableArray alloc] init];
    
    for (int n = 0;n < size; n++) {
        
        [tmpStrArr addObject:[tmpStr substringWithRange:NSMakeRange(n*4, 4)]];
    }
    
    [tmpStrArr addObject:[tmpStr substringWithRange:NSMakeRange(size*4, (tmpStr.length % 4))]];
    
    tmpStr = [tmpStrArr componentsJoinedByString:@" "];
    
    return tmpStr;
}



/**
 *  正常号转银行卡号 － *号
 *
 *  @return 增加4位间的空格
 */
-(NSString *)normalNumToBankNum_X {
    
    NSString *tmpStr = [self bankNumToNormalNum];
    
    NSUInteger size = (tmpStr.length / 4);
    
    NSMutableArray *tmpStrArr = [[NSMutableArray alloc] init];
    
    for (int n = 0;n < size; n++) {
        [tmpStrArr addObject:[tmpStr substringWithRange:NSMakeRange(n*4, 4)]];
    }
    [tmpStrArr addObject:[tmpStr substringWithRange:NSMakeRange(size*4, (tmpStr.length % 4))]];
    
    
    for (int n = 0; n < tmpStrArr.count; n++) {
        if (n > 0 && n < (tmpStrArr.count - 2)) {
            [tmpStrArr setObject:@"****" atIndexedSubscript:n];
        }
    }
    
    tmpStr = [tmpStrArr componentsJoinedByString:@" "];
    return tmpStr;
}



/**
 *   银行卡号转正常号
 *
 *  @return 去除4位间的空格
 */
-(NSString *)bankNumToNormalNum {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}



/**
 *  判断字符串是不是空内容
 *
 *  @return NSString
 */
+ (NSString *)notEmpty:(NSString *)str {
//    if (!str){
//        return @"";
//    }else if ([str isKindOfClass:[NSNull class]]) {
//        return @"";
//    }else if ([str isEqual:[NSNull null]]){
//        return @"";
//    }else if ([str isEqualToString:@"    "]){
//        return @"";
//    }else if ([str isEqualToString:@"(null)"]){
//        return @"";
//    }else if ([str isEqualToString:@"<null>"]){
//        return @"";
//    }else if(str == nil){
//        return @"";
//    }else if([str isEqual:[NSNull null]]){
//        return @"";
//    }else if (str.length <= 0){
//        return @"";
//    }
    return str;
}




/**
 *  字典转json
 *
 *  @param object 字典
 *
 *  @return json
 */
+ (NSString *)stringToJsonDic:(id)dic {
    
    if (!dic) { return @""; }
    
    NSString *jsonString = nil;
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:0 // (NSJSONWritingPrettyPrinted) Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (!jsonData) {
        NSLog(@"字典转 SJON 失败: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}





/**
 *  获取当前的手机时间(年,月,日)
 *
 *  @return 年月日 string
 */
+ (NSString *)getToDate {

    NSDate *data = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *today = [dateFormat stringFromDate:data];
    return today;
}

/**
 *  获取当前的手机时间(年,月,日,时,分,秒)
 *
 *  @return 年月日时分秒 string
 */
+ (NSString *)getToDateAndday {

    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *today = [dateFormat stringFromDate:date];
    return today;
}


/**
 *  获取时间戳
 *
 *  @return 时间戳
 */
+ (NSString *)getToDateAndTimestamp {
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyMMddHHmmss"];
    NSString *today = [dateFormat stringFromDate:date];
    return today;
}


/**
 *  通过NSDate获取时间string
 *
 *  @param date NSDate对象
 *
 *  @return NSDate转string
 */
+ (NSString *)getToDateForStr:(NSDate *)date {

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *theDate = [dateFormat stringFromDate:date];
    return theDate;

}



/**
 *  通过NSDate获取时间string
 *
 *  @param date NSDate对象
 *
 *  @return NSDate转string
 */
+ (NSString *)getToDateForYear:(NSDate *)date {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy"];
    NSString *theDate = [dateFormat stringFromDate:date];
    return theDate;
    
}


/**
 *  通过NSDate获取时间string
 *
 *  @param date NSDate对象
 *
 *  @return NSDate转string
 */
+ (NSString *)getToDateForMonthly:(NSDate *)date {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM"];
    NSString *theDate = [dateFormat stringFromDate:date];
    return theDate;
    
}



/**
 *  通过string获取时间string
 *
 *  @param NSString string对象
 *
 *  @return NSString 转 string
 */
+ (NSString *)getToStrForStr:(NSString *)str_date {
    if (str_date == nil || str_date.length == 0) {
        return @"";
    }else {
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
        NSDate *destDate= [dateFormatter1 dateFromString:str_date];

        NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
        [dateFormatter2 setDateFormat:@"yyyy-MM-dd"];
        str_date = [dateFormatter2 stringFromDate:destDate];
        return str_date;
    }
}



/**
 *  读取NSUserDefaults
 *
 *  @param key key
 *
 *  @return 数据内容
 */
+ (NSString *)readDateKey:(NSString *)key {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];;
    
}



/**
 *  写入NSUserDefaults
 *
 *  @param key  key
 *  @param data data
 *
 *  @return 是否写入完成
 */
+ (BOOL)writeDateKey:(NSString *)key andData:(NSString *)data {
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    
    return [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  对URL链接进行编码
 *
 *  @param str 需要编码的字符串
 *
 *  @return URL编码结果
 */

+ (NSString *)URLEncodedString:(NSString *)str
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)str,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

/**
 *  对URL链接进行反编码
 *
 *  @param str 需要编码的字符串
 *
 *  @return URL编码结果
 */
+ (NSString *)URLDecodedString:(NSString *)str
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}



/**
 string转dic

 @param jsonString string
 @return 字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }else {
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        if(err){
            NSLog(@"json解析失败：%@",err);
            return nil;
        }
        return dic;
    }
}
@end
