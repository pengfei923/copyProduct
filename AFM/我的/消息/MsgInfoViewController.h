//
//  MsgInfoViewController.h
//  AFM
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BaseViewController.h"

@interface MsgInfoViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextView *tureTextView;
@property (weak, nonatomic) IBOutlet UILabel *title_Lab;
@property (weak, nonatomic) IBOutlet UILabel *time_Lab;



@property (nonatomic, strong) NSString *Mtitle;	      //系统消息标题
@property (nonatomic, strong) NSString *Mdepict;	      //系统消息内容
@property (nonatomic, strong) NSString *Mtime;	      //系统消息时间
@property (nonatomic, strong) NSString *Id;	      //系统消息ID

@end
