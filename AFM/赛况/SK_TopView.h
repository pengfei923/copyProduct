//
//  SK_TopView.h
//  AFM
//
//  Created by admin on 2017/9/21.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TopDelegate <NSObject>

@optional
- (void)refreshSK_TOP:(NSString *)Tag;

@end


@interface SK_TopView : UIView
@property (weak, nonatomic) IBOutlet UIView *line_view1;
@property (weak, nonatomic) IBOutlet UIView *line_view2;
@property (weak, nonatomic) IBOutlet UIView *line_view3;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;


@property(nonatomic,assign)id<TopDelegate>delegate;
@property(nonatomic,strong)NSString *SK_Tag;


@end
