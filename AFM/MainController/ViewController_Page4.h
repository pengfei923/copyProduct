//
//  ViewController_Page4.h
//  CarServiceO2O
//
//  Created by 华四MAC on 16/7/18.
//  Copyright © 2016年 华四MAC. All rights reserved.
//

#import "BaseViewController.h"

@class Page4Model;

@interface ViewController_Page4 : BaseViewController
@property (nonatomic , strong) UserInfoModel *infoModelCell;

@end


@interface Page4Model : NSObject
@property (nonatomic , strong) NSString *celltitle;
@property (nonatomic , strong) NSString *celllogoimg;
@property (nonatomic , strong) NSString *cellaccessoryimg;
@end







