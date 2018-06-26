//
//  UpdatePhoto.m
//  BabyProject
//
//  Created by 张凡 on 15/11/9.
//  Copyright © 2015年 zhangfan. All rights reserved.
//

#import "ZFUpdatePhoto.h"

@interface ZFUpdatePhoto() <UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    UIViewController *viewcontroller;
}

@end

@implementation ZFUpdatePhoto


- (id)init:(UIViewController *)controll{
    self = [super init];
    if (self) {
        self.allowsEditing = NO;
        viewcontroller = controll;
    }
    return self;
}


#pragma mark 从用户相册获取活动图片

- (void)pickImageFromAlbum:(UIImagePickerControllerSourceType )sourceType{
    [self pickImageFromAlbum:sourceType CameraOverlayView:nil];
}


- (void)pickImageFromAlbum:(UIImagePickerControllerSourceType )sourceType CameraOverlayView:(UIView *)overlayView{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *pickerview = [[UIImagePickerController alloc] init];
        pickerview.delegate = self;
        pickerview.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        
        pickerview.allowsEditing = self.allowsEditing;
        pickerview.sourceType = sourceType;

        if (sourceType == UIImagePickerControllerSourceTypeCamera && overlayView) {
            pickerview.cameraOverlayView = overlayView;
        }
        [viewcontroller presentViewController:pickerview animated:YES completion:nil];
        
    }else if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary]){
        
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"模拟器中无法打开照相机,请在真机中使用" message:@"" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"好", nil];
        [alert show];
    }
}





- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {    
    NSString *string = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([string isEqualToString:@"public.image"]){
        
        UIImage *image;
        if (picker.allowsEditing) {
            image= [info objectForKey:@"UIImagePickerControllerEditedImage"];       //裁剪后的原始图片
        }else {
            image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];    //
        }

       
        if (!image) {
            NSLog(@"图片获取失败");
            return;
        }else {
            image = [UIImage imageWithImageSimple:image scaledToSize:CGSizeMake(600, 800)];//
        }
       
//        NSData *data;
//       
//        if (UIImagePNGRepresentation(image) == nil){
//       
//            data = UIImageJPEGRepresentation(image, 1);
//        }else{
//       
//            data = UIImagePNGRepresentation(image);
//        }
//        
//        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//        
//        // 照片在沙盒中的名称
//        NSString *userImage = [path stringByAppendingPathComponent:@"image.png"];
//        
//        NSLog(@"%@", userImage);
//        // 写入沙盒中
//        [data writeToFile:userImage atomically:YES];
//        
//        image = [UIImage imageWithContentsOfFile:userImage];
        
        if (_blockgetimg) {
            _blockgetimg(image);
        }
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];

    }
    

    
//    [viewcontroller dismissViewControllerAnimated:YES completion:nil];
//    
//    UIImage *image = nil;
//    if (picker.allowsEditing) {
//        image= [info objectForKey:@"UIImagePickerControllerEditedImage"];//裁剪后的原始图片
//    }else {
//        image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];//
//    }
//    
//    if (!image) {
//        NSLog(@"图片获取失败");
//        return;
//    }
//    UIImage *theImage = [UIImage imageWithImageSimple:image scaledToSize:CGSizeMake(120.0, 120.0)];//压缩原始图片
//    UIImage *bigImage = [UIImage imageWithImageSimple:image scaledToSize:CGSizeMake(440.0, 440.0)];//
//    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {//保存图片
//        [bigImage saveImageToPhotos];//保存图片到本地
//    }
//    if (_blockgetimg) {
//        _blockgetimg(theImage);
//    }
}
@end
