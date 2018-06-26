//
//  WENTextView.h
//  CarServiceO2O
//
//  Created by HS001 on 16/9/1.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WENTextView : UITextView
/** 占位文字 */
@property(copy,nonatomic)   NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
/** 最大长度设置 */
@property(assign,nonatomic) NSInteger maxTextLength;
/** 更新高度的时候 */
@property(assign,nonatomic) float updateHeight;
/** 显示 Placeholder */
@property(strong,nonatomic,readonly) UILabel *PlaceholderLabel;

@property(strong,nonatomic) NSIndexPath * indexPath;




/**
 *  增加text 长度限制
 *
 *
 */
-(void)addMaxTextLengthWithMaxLength:(NSInteger)maxLength andEvent:(void(^)(WENTextView *text))limit;
/**
 *  开始编辑 的 回调
 *
 */
-(void)addTextViewBeginEvent:(void(^)(WENTextView *text))begin;

/**
 *  结束编辑 的 回调
 *
 */
-(void)addTextViewEndEvent:(void(^)(WENTextView *text))End;

/**
 *  设置Placeholder 颜色
 *
 */
-(void)setPlaceholderColor:(UIColor *)color;

/**
 *  设置Placeholder 字体
 *
 */
-(void)setPlaceholderFont:(UIFont *)font;

/**
 *  设置透明度
 *
 */
-(void)setPlaceholderOpacity:(float)opacity;


@end





