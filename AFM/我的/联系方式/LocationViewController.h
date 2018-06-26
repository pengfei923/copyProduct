//
//  LocationViewController.h
//  AFM
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BaseViewController.h"
@class AddressListModel;
@class AddressListModelCell;


@interface LocationViewController : BaseViewController

@end

@interface AddressListModel : NSObject
@property (nonatomic, strong) NSMutableArray <AddressListModelCell *> *data;

@end

@interface AddressListModelCell : NSObject
@property (nonatomic, strong) NSString *name;	                   //
@property (nonatomic, strong) NSString *phone;		               //
@property (nonatomic, assign) NSString *Id;		               //
@property (nonatomic, strong) NSString *address;	               //
@property (nonatomic, strong) NSString *post_num;		           //
@property (nonatomic, strong) NSString *is_default;		       //状态  1默认，0

@property (nonatomic , assign) BOOL isDisP;

@end

