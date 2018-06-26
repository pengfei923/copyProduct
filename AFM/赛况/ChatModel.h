//
//  ChatModel.h
//  AFM
//
//  Created by admin on 2017/10/12.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ChatModelCell;

@interface ChatModel : NSObject


@property (nonatomic, strong) NSArray<ChatModelCell *> *data;

@end


@interface ChatModelCell : NSObject
@property (nonatomic, strong) NSString *content;	          //反馈内容
@property (nonatomic, strong) NSString *addtime;	          //时间
@property (nonatomic, strong) NSString *room_id;		      //房间id
@property (nonatomic, strong) NSString *Id;		          //id
@property (nonatomic, strong) NSString *avatar;		      //头像
@property (nonatomic, strong) NSString *username;		      //昵称
@property (nonatomic, strong) NSString *uid;		          //昵称


@end

