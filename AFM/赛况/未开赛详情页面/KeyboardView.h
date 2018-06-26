//
//  KeyboardView.h
//  AFM
//
//  Created by 年少 on 2017/10/15.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyboardView : UIView

+ (KeyboardView *)initKeyView;
@property (weak, nonatomic) IBOutlet UIButton *turn_Btn;
@property (weak, nonatomic) IBOutlet UITextField *txtInput;

@end
