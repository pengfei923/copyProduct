//
//  ChengHViewController.h
//  AFM
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 sgamer. All rights reserved.
//

@class AllChengHaoModel;
@class AllChengHaoModelCell;
@class MyChengHaoModel;
@class MyChengHaoModelCell;

#import "BaseViewController.h"

@interface ChengHViewController : BaseViewController
@property (nonatomic , strong) NSString *RANK;

@end


@interface AllChengHaoModel : NSObject
@property (nonatomic, strong) NSArray<AllChengHaoModelCell *> *data;

@end



@interface AllChengHaoModelCell : NSObject
@property (nonatomic , strong) NSString *avatar_img;
@property (nonatomic , strong) NSString *Id;
@property (nonatomic , strong) NSString *class_id;
@property (nonatomic , strong) NSString *class_name;
@property (nonatomic , strong) NSString *depict;
@property (nonatomic , strong) NSString *name;
@end


@interface MyChengHaoModel : NSObject
@property (nonatomic, strong) NSArray<MyChengHaoModelCell *> *data;

@end



@interface MyChengHaoModelCell : NSObject
@property (nonatomic , strong) NSString *avatar_img;
@property (nonatomic , strong) NSString *Id;
@property (nonatomic , strong) NSString *class_id;
@property (nonatomic , strong) NSString *type;     // 1使用中，2已经拥有
@property (nonatomic , strong) NSString *name;


@end
