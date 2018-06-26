//
//  UIImage+Tools.m
//  BabyProject
//
//  Created by 张凡 on 15/11/5.
//  Copyright © 2015年 zhangfan. All rights reserved.
//

#import "UIImage+Tools.h"

//static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation UIImage (Tools)

//压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize {
    
    //
    UIImage* newImage = [image imageWithImageSimpleScaledToSize:newSize];

    //
    return newImage;
}



- (UIImage *)imageWithImageSimpleScaledToSize:(CGSize)newSize {

    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    //
    return newImage;

}





#pragma mark - 保存图片到document
/**
 *  保存图片到document
 *
 *  @param imageName 图片名称
 */
- (void)saveImageToDocumentsWithName:(NSString *)imageName {
    
    //获取图片数据
    NSData* imageData = UIImagePNGRepresentation(self);
    
    //获取路径
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //
    NSString* documentsDirectory = [paths objectAtIndex:0];
    
    //拼接完成的图片路径
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
        
    //先入数据
    [imageData writeToFile:fullPathToFile atomically:NO];

}



/**
 *  保存图片到系统相册
 *
 *  @param savedImage 图片
 */
- (void)saveImageToPhotos {
    UIImageWriteToSavedPhotosAlbum(self, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}


/**
 *  指定回调方法
 *
 *  @param image       需要保存的图片
 *  @param error       错误信息
 *  
 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil;
    if(error != NULL){
        msg = @"保存图片失败";
    }else{
        msg = @"保存图片成功";
    }
    NSLog(@"%@",msg);
}












/**
 *  图片转string
 *
 *  @return
 */
+ (NSString *)getImgtoString:(UIImage *)img {
    NSData *data = UIImageJPEGRepresentation(img, 0.5);
    NSString *string = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"-----------  %@",string);
//    NSString *string = [UIImage base64EncodedStringFrom:data];

    return string;
}



///**
// *  data转string
// *
// *  @param data
// *
// *  @return
// */
//+ (NSString *)base64EncodedStringFrom:(NSData *)data{
//    if ([data length] == 0)
//        return @"";
//    
//    char *characters = malloc((([data length] + 2) / 3) * 4);
//    if (characters == NULL)
//        return nil;
//    NSUInteger length = 0;
//    
//    NSUInteger i = 0;
//    while (i < [data length])
//    {
//        char buffer[3] = {0,0,0};
//        short bufferLength = 0;
//        while (bufferLength < 3 && i < [data length])
//            buffer[bufferLength++] = ((char *)[data bytes])[i++];
//        
//        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
//        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
//        if (bufferLength > 1)
//            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
//        else characters[length++] = '=';
//        if (bufferLength > 2)
//            characters[length++] = encodingTable[buffer[2] & 0x3F];
//        else characters[length++] = '=';
//    }
//    
//    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
//}




/**
 *  string转图片
 *
 *  @param requestString
 *
 *  @return 
 */
+ (UIImage *)getStringtoImg:(NSString *)requestString {
    if (!requestString && requestString.length > 0) {
        return nil;
    }else {
        
        
        NSData *decodedImageData   = [[NSData alloc] initWithBase64EncodedString:requestString options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *decodedImage      = [UIImage imageWithData:decodedImageData];
        return decodedImage;
        
//        requestString = [requestString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];// utf-8解码操
//        NSData *imgdata = [UIImage dataWithBase64EncodedString:requestString];
//        UIImage *aimage = [UIImage imageWithData:imgdata];
//        return aimage;
    }


}

//+ (NSData *)dataWithBase64EncodedString:(NSString *)string{
//    if (string == nil)
//        return [NSData data];
//    
//    if ([string length] == 0)
//        return [NSData data];
//    
//    static char *decodingTable = NULL;
//    if (decodingTable == NULL) {
//        decodingTable = malloc(256);
//        if (decodingTable == NULL)
//            return nil;
//        memset(decodingTable, CHAR_MAX, 256);
//        NSUInteger i;
//        for (i = 0; i < 64; i++)
//            decodingTable[(short)encodingTable[i]] = i;
//    }
//    
//    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
//    if (characters == NULL)     //  Not an ASCII string!
//        return nil;
//    char *bytes = malloc((([string length] + 3) / 4) * 3);
//    if (bytes == NULL)
//        return nil;
//    NSUInteger length = 0;
//    
//    NSUInteger i = 0;
//    while (YES)
//    {
//        char buffer[4];
//        short bufferLength;
//        for (bufferLength = 0; bufferLength < 4; i++)
//        {
//            if (characters[i] == '\0')
//                break;
//            if (isspace(characters[i]) || characters[i] == '=')
//                continue;
//            buffer[bufferLength] = decodingTable[(short)characters[i]];
//            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
//            {
//                free(bytes);
//                return nil;
//            }
//        }
//        
//        if (bufferLength == 0)
//            break;
//        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
//        {
//            free(bytes);
//            return nil;
//        }
//        
//        //  Decode the characters in the buffer to bytes.
//        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
//        if (bufferLength > 2)
//            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
//        if (bufferLength > 3)
//            bytes[length++] = (buffer[2] << 6) | buffer[3];
//    }
//    
//    bytes = realloc(bytes, length);
//    return [NSData dataWithBytesNoCopy:bytes length:length];
//}


@end
