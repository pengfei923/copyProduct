//
//  TRZXShareManager.m
//  TRZXShare
//
//  Created by N年後 on 2017/3/14.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import "TRZXShareManager.h"
#import "TRZXShareItem.h"
#import "TRZXShareView.h"

@interface TRZXShareManager ()
    
    {
        TRZXShareView *shareView;
    }
    
    @end

@implementation TRZXShareManager
+ (instancetype)sharedManager {
    static TRZXShareManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}
    
-(void)showTRZXShareViewMessage:(OSMessage*)message handler:(void (^)(TRZXShareType type))handler{
    
    TRZXShareItem *item_Copy = [TRZXShareItem itemWithTitle:@"复制链接" icon:@"Action_Copy" handler:^{
        if (handler) {
            handler(TRZXShareTypeToCopy);
            NSLog(@"点击了复制");
        }
        
        UIPasteboard *pboard = [UIPasteboard generalPasteboard];
        pboard.string = message.link;
    }];
    
    
    //===========================================================================
    TRZXShareItem *item0 = [TRZXShareItem itemWithTitle:@"微信好友" icon:@"Action_Share" handler:^{
        
        if (handler) {
            handler(TRZXShareTypeToWeixin);
            NSLog(@"发送给朋友");
        }
        
        [OpenShare shareToWeixinSession:message Success:^(OSMessage *message) {
            NSLog(@"微信分享到会话成功：\n%@",message);
        } Fail:^(OSMessage *message, NSError *error) {
            NSLog(@"微信分享到会话失败：\n%@\n%@",error,message);
        }];
    }];
    
    TRZXShareItem *item1 = [TRZXShareItem itemWithTitle:@"微信朋友圈" icon:@"Action_Moments" handler:^{
        
        if (handler) {
            handler(TRZXShareTypeToWeixinTimeline);
            NSLog(@"点击了分享到朋友圈");
        }
        
        [OpenShare shareToWeixinTimeline:message Success:^(OSMessage *message) {
            NSLog(@"微信分享到朋友圈成功：\n%@",message);
            
        } Fail:^(OSMessage *message, NSError *error) {
            NSLog(@"微信分享到朋友圈失败：\n%@\n%@",error,message);
            
        }];
    }];
    
    
    
    
    
    //===========================================================================
    TRZXShareItem *item3 = [TRZXShareItem itemWithTitle:@"QQ好友" icon:@"Action_QQ" handler:^{
        
        if (handler) {
            handler(TRZXShareTypeToQQFriends);
            NSLog(@"点击了QQ");
        }
        
        [OpenShare shareToQQFriends:message Success:^(OSMessage *message) {
            NSLog(@"分享到QQ好友成功:%@",message);
            
        } Fail:^(OSMessage *message, NSError *error) {
            NSLog(@"分享到QQ好友失败:%@\n%@",message,error);
            
        }];
        
        
    }];
    
    TRZXShareItem *item4 = [TRZXShareItem itemWithTitle:@"QQ空间" icon:@"Action_qzone" handler:^{
        
        if (handler) {
            handler(TRZXShareTypeToQQZone);
            NSLog(@"点击了QQ空间");
        }
        
        
        [OpenShare shareToQQZone:message Success:^(OSMessage *message) {
            NSLog(@"分享到QQ空间成功:%@",message);
            
        } Fail:^(OSMessage *message, NSError *error) {
            NSLog(@"分享到QQ空间失败:%@\n%@",message,error);
            
        }];
    }];
    
    
    
    //===========================================================================
    TRZXShareItem *item5 = [TRZXShareItem itemWithTitle:@"微博" icon:@"Action_Sina" handler:^{
        
        if (handler) {
            handler(TRZXShareTypeToSina);
            NSLog(@"点击了新浪微博");
        }
        
        [OpenShare shareToWeibo:message Success:^(OSMessage *message) {
            NSLog(@"分享到微博成功:%@",message);
        } Fail:^(OSMessage *message, NSError *error) {
            NSLog(@"分享到微博失败:%@\n%@",message,error);
        }];
    }];
    
    
    
    NSMutableArray *shareItemsArray = [NSMutableArray array];
    [shareItemsArray addObject:item_Copy];
    
    
    
    NSMutableArray *functionItemsArray = [NSMutableArray array];
    //用户安装微信
    if ([OpenShare isWeixinInstalled]) {
        [functionItemsArray addObjectsFromArray:@[item0, item1]];
    }
    
    //用户安装QQ
    if ([OpenShare isQQInstalled]) {
        [functionItemsArray addObjectsFromArray:@[item3,item4]];
    }
    
    //用户安装微博
    if ([OpenShare isWeiboInstalled]) {
        [functionItemsArray addObjectsFromArray:@[item5]];
    }
    
    //创建shareView
    shareView = [TRZXShareView shareViewWithShareItems:shareItemsArray functionItems:functionItemsArray];
    
    //弹出shareView
    [shareView show];
}
    
    
    
    
- (void)hideTRZXShareViewMessage{
    [shareView hide];
}
@end
