//
//  Player_TopTableViewCell.h
//  AFM
//
//  Created by admin on 2017/9/14.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol topChooseDelegate <NSObject>

@optional
- (void)refreshNum:(NSString *)num;

@end

@interface Player_TopTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *Meg_Btn;
@property (weak, nonatomic) IBOutlet UIButton *Rizhi_Btn;
@property (weak, nonatomic) IBOutlet UIView *Meg_LineView;
@property (weak, nonatomic) IBOutlet UIView *Rizhi_LineVoew;



@property(nonatomic,assign)id<topChooseDelegate>delegate;
@property(nonatomic,strong)NSString *num;


@end
