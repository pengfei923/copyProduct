//
//  SK_InfoViewController.h
//  AFM
//
//  Created by admin on 2017/9/22.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BaseViewController.h"
#import "ChatModel.h"


@interface SK_InfoViewController : BaseViewController
@property (nonatomic , strong) NSString *Id;               //房间id号
@property (nonatomic , strong) NSString *guess_id;         // 未开赛的Id
@property (nonatomic , strong) NSString *roomID;           //roomID
@property (nonatomic , strong) NSString *project_id;
@property (nonatomic , strong) NSString *name;
@end



