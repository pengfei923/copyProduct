//
//  ConvertViewController.h
//  AFM
//
//  Created by admin on 2017/9/11.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BaseViewController.h"

@class ConvertModel;
@class ConvertModelCell;

@interface ConvertViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *turn_Btn;

@end

@interface ConvertModel : NSObject
@property (nonatomic, strong) NSArray<ConvertModelCell *> *data;
@end


@interface ConvertModelCell : NSObject
@property (nonatomic, strong) NSString *updatetime;        //时间
@property (nonatomic, strong) NSString *type;              //物品类型 1为门票，2为砖石，3为木头
@property (nonatomic, strong) NSString *prize;             //num
@property (nonatomic, strong) NSString *Id;                //ID


@end
