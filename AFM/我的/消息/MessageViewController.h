//
//  MessageViewController.h
//  AFM
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BaseViewController.h"


@class MessageListModel;
@class MessageListModelCell;


@interface MessageViewController : BaseViewController

@end


@interface MessageListModel : NSObject
@property (nonatomic, strong) NSMutableArray <MessageListModelCell *> *data;

@end

@interface MessageListModelCell : NSObject
@property (nonatomic, strong) NSString *depict;	      //系统消息内容
@property (nonatomic, strong) NSString *time;		      //系统消息时间
@property (nonatomic, assign) NSString *Id;		      //系统消息id
@property (nonatomic, strong) NSString *title;	          //系统消息标题
@property (nonatomic, strong) NSString *state;		      //状态  1未读，0已读

@end
