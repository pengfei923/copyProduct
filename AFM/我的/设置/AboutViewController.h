//
//  AboutViewController.h
//  AFM
//
//  Created by admin on 2017/9/1.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BaseViewController.h"

@interface AboutViewController : BaseViewController

@property (nonatomic , strong) NSString *url;
@property (weak, nonatomic) IBOutlet UILabel *banben_lab;
@property (strong, nonatomic) IBOutlet UILabel *title_Lab;

@end
