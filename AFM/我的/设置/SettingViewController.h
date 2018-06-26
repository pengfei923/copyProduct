//
//  SettingViewController.h
//  AFM
//
//  Created by admin on 2017/9/1.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BaseViewController.h"
@class SetingModel;

@interface SettingViewController : BaseViewController




@end

@interface SetingModel : NSObject
@property (nonatomic , strong) NSString *celltitle;
@property (nonatomic , strong) NSString *celldetail;
@end
