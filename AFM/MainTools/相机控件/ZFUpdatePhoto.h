//
//  UpdatePhoto.h
//  BabyProject
//
//  Created by 张凡 on 15/11/9.
//  Copyright © 2015年 zhangfan. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^PhotoBlockgetImg)(UIImage *img);
@interface ZFUpdatePhoto : NSObject

- (id)init:(UIViewController *)controll;
- (void)pickImageFromAlbum:(UIImagePickerControllerSourceType )sourceType;
- (void)pickImageFromAlbum:(UIImagePickerControllerSourceType )sourceType CameraOverlayView:(UIView *)view;

@property (nonatomic) BOOL allowsEditing;
@property (nonatomic , copy) PhotoBlockgetImg blockgetimg;

@end
