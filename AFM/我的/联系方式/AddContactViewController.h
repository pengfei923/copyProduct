//
//  AddContactViewController.h
//  AFM
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BaseViewController.h"

@interface AddContactViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *name_TF;
@property (weak, nonatomic) IBOutlet UITextField *phone_TF;
@property (weak, nonatomic) IBOutlet UITextField *address_TF;
@property (weak, nonatomic) IBOutlet UIButton *add_Btn;


@property (strong, nonatomic) NSString *Id;
@property (strong, nonatomic) NSString *name_L;
@property (strong, nonatomic) NSString *Phone_L;
@property (strong, nonatomic) NSString *address_L;
@end
