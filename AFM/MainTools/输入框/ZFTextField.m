//
//  MyTextField.m
//  ZhangShangYiBao
//
//  Created by 马文涛 on 13-12-19.
//  Copyright (c) 2013年 Mondeo. All rights reserved.
//

#import "ZFTextField.h"

@implementation ZFTextField

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 2.0;
        self.layer.borderWidth  = 0.5;
		self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.backgroundColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:14.0];

        //self.returnKeyType = UIReturnKeyDone;
        //self.font = [UIFont fontWithName:@"Helvetica" size:14];
        //self.clearButtonMode = UITextFieldViewModeWhileEditing;
        //self.textColor = [UIColor colorWithWhite:0 alpha:0.7];
        //self.secureTextEntry = YES;   密码不可见
        //self.placeholder = @"";       占位符
    }
    return self;
}


-(CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, 30, 0);
}


-(CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, 30, 0);
}


@end
