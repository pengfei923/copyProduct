//
//  WENTextView.m
//  CarServiceO2O
//
//  Created by HS001 on 16/9/1.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "WENTextView.h"
#define kTopY 7.0
#define kLeftX 5.0

@interface WENTextView()<UITextViewDelegate>
@property(strong,nonatomic) UIColor *placeholder_color;  //颜色
@property(strong,nonatomic) UIFont * placeholder_font;   //字体
//@property(strong,nonatomic,readonly) UILabel *PlaceholderLabel;  //显示 Placeholder
@property(assign,nonatomic) float placeholdeWidth;       //宽度

@property(copy,nonatomic) id eventBlock;
@property(copy,nonatomic) id BeginBlock;
@property(copy,nonatomic) id EndBlock;

@end

@implementation WENTextView

- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidChange:) name:UITextViewTextDidChangeNotification object:self];
    
    //UITextViewTextDidBeginEditingNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewBeginNoti:) name:UITextViewTextDidBeginEditingNotification object:self];
    
    //UITextViewTextDidEndEditingNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEndNoti:) name:UITextViewTextDidEndEditingNotification object:self];
    
    float left = kLeftX,top = kTopY,hegiht = 30;
    
    self.placeholdeWidth = CGRectGetWidth(self.frame) - left*2;
    
    _PlaceholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, top, _placeholdeWidth, hegiht)];
    
    _PlaceholderLabel.numberOfLines = 0;
    
    _PlaceholderLabel.lineBreakMode = NSLineBreakByCharWrapping | NSLineBreakByWordWrapping;
    [self addSubview:_PlaceholderLabel];
    
    [self defaultConfig];
    
}

-(void)layoutSubviews {
    float left = kLeftX,top = kTopY,hegiht = self.bounds.size.height;
    self.placeholdeWidth = CGRectGetWidth(self.frame) - 2*left;
    CGRect frame = _PlaceholderLabel.frame;
    frame.origin.x = left;
    frame.origin.y = top;
    frame.size.height = hegiht;
    frame.size.width = self.placeholdeWidth;
    _PlaceholderLabel.frame = frame;
    
    [_PlaceholderLabel sizeToFit];
    
}

-(void)dealloc{
    //移除父视图
    [_PlaceholderLabel removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
//默认配置
-(void)defaultConfig {
    self.placeholder_color = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1];
    self.placeholder_font  = [UIFont systemFontOfSize:15];
    self.maxTextLength = 1000;
    self.layoutManager.allowsNonContiguousLayout = NO;
    
    
}

-(void)addMaxTextLengthWithMaxLength:(NSInteger)maxLength andEvent:(void (^)(WENTextView *text))limit {
    if (maxLength > 0) {
        _maxTextLength = maxLength;
    }
    if (limit) {
        _eventBlock = limit;
    }
}

-(void)addTextViewBeginEvent:(void (^)(WENTextView *))begin{
    
    _BeginBlock = begin;
}

-(void)addTextViewEndEvent:(void (^)(WENTextView *))End{
    _EndBlock=End;
}

//更新高度
-(void)setUpdateHeight:(float)updateHeight{
    CGRect frame = self.frame;
    frame.size.height = updateHeight;
    self.frame = frame;
    _updateHeight = updateHeight;
}

//供外部使用的

-(void)setPlaceholderFont:(UIFont *)font{
    self.placeholder_font = font;
}
-(void)setPlaceholderColor:(UIColor *)color{
    self.placeholder_color = color;
    
}
-(void)setPlaceholderOpacity:(float)opacity {
    if (opacity < 0) {
        opacity = 1;
    }
    self.PlaceholderLabel.layer.opacity = opacity;
}


#pragma mark - Noti Event

-(void)textViewBeginNoti:(NSNotification*)noti{
    
    if (_BeginBlock) {
        void(^begin)(WENTextView *text) = _BeginBlock;
        begin(self);
    }
}
-(void)textViewEndNoti:(NSNotification*)noti{
    
    if (_EndBlock) {
        void(^end)(WENTextView *text) = _EndBlock;
        end(self);
    }
}
/**
 * 监听文字改变
 */
-(void)DidChange:(NSNotification*)noti{
    
    // 只要有文字, 就隐藏占位文字label
    _PlaceholderLabel.hidden = self.hasText;
    
    NSString *lang = [[self.nextResponder textInputMode] primaryLanguage]; // 键盘输入模式
    
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (self.text.length > self.maxTextLength) {
                self.text = [self.text substringToIndex:self.maxTextLength];
            }
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (self.text.length > self.maxTextLength) {
            self.text = [ self.text substringToIndex:self.maxTextLength];
        }
    }
    if (_eventBlock && self.text.length > self.maxTextLength) {
        
        void (^limint)(WENTextView *text) =_eventBlock;
        
        limint(self);
    }
    
    //中文键盘输入emoji判断
    if ([self stringContainsEmoji:self.text]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告！" message:@"输入内容含有表情，请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        self.text = @"";        
        [alertView show];
        [self becomeFirstResponder];
    }else{
        
    }
    
}

#pragma mark - private method

+(float)boundingRectWithSize:(CGSize)size withLabel:(NSString *)label withFont:(UIFont *)font{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    // CGSize retSize;
    CGSize retSize = [label boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                      attributes:attribute
                                         context:nil].size;
    
    return retSize.height;
    
}

#pragma mark - 重写setter

-(void)setText:(NSString *)tex{
    if (tex.length > 0) {
        _PlaceholderLabel.hidden = YES;
    }
    [super setText:tex];
}

-(void)setPlaceholder:(NSString *)placeholder{
    if (placeholder.length == 0 || [placeholder isEqualToString:@""]) {
        _PlaceholderLabel.hidden=YES;
    }else{
        _PlaceholderLabel.text = placeholder;
        _placeholder = placeholder;
        
    }
    
}
-(void)setPlaceholder_font:(UIFont *)placeholder_font{
    _placeholder_font = placeholder_font;
    _PlaceholderLabel.font = placeholder_font;
}

-(void)setPlaceholder_color:(UIColor *)placeholder_color
{
    _placeholder_color = placeholder_color;
    _PlaceholderLabel.textColor = placeholder_color;
}


#pragma mark - emoji判断事件

- (BOOL)stringContainsEmoji:(NSString *)string{
    // 过滤所有表情。returnValue为NO表示不含有表情，YES表示含有表情
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            }
        }
    }];
    return returnValue;
}


@end
