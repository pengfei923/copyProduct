//
//  TopView.h
//  AFM
//
//  Created by admin on 2017/9/12.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BtnBackBlcok <NSObject>

@optional
- (void)btnBackBlcok:(NSString *)Btn_tag;
@end




@interface TopView : UIView

@property (weak, nonatomic) IBOutlet UIView *lineView1;
@property (weak, nonatomic) IBOutlet UIView *lineView2;
@property (weak, nonatomic) IBOutlet UIView *lineView3;
@property (weak, nonatomic) IBOutlet UIView *lineView4;

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;

@property(nonatomic,assign)id<BtnBackBlcok>delegate;
@property(nonatomic,strong)NSString *Btn_tag;

@end
