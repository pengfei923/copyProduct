//
//  Register1ViewController.h
//  AFM
//
//  Created by admin on 2017/9/4.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BaseViewController.h"
@protocol AFMRegisterController1Delegate <NSObject>

-(void)sendUserName:(NSString *)userName andPasw:(NSString *)pasw;

@end


@interface Register1ViewController : BaseViewController
@property (nonatomic,copy) NSString *phoneNum;

@property (nonatomic,copy) NSString *openid;

@property (nonatomic,copy) NSString *type_c;


@end
