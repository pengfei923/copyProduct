//
//  ClooseRoomView.m
//  AFM
//
//  Created by admin on 2017/9/12.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "ClooseRoomView.h"
#import "SFDualWaySlider.h"

@implementation ClooseRoomView

+ (ClooseRoomView *)clooseTypeView{
    ClooseRoomView *view = [[[NSBundle mainBundle]loadNibNamed:@"ClooseRoomView" owner:nil options:nil] lastObject];
    return view;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.7];
    
    [self initView];
    [self initData];
    [self initSlider];

}

- (void)initSlider{
    SFDualWaySlider *slider = [[SFDualWaySlider alloc] initWithFrame:CGRectMake(25, 30, screen_Width -70, 50) minValue:0 maxValue:80 blockSpaceValue:0];
    slider.progressRadius = 5;
    [slider.minIndicateView setTitle:@"0"];
    [slider.maxIndicateView setTitle:@"100"];
    slider.blockImage = [UIImage imageNamed:@"yuan_sli"];
    slider.lightColor = [UIColor getColorWithTheme];
    slider.minIndicateView.backIndicateColor = [UIColor getColorWithTheme];
    slider.maxIndicateView.backIndicateColor = [UIColor getColorWithTheme];
    slider.progressHeight = 5;
    
    self.minLab = slider.minIndicateView.indicateLabel;
    
    slider.sliderValueChanged = ^(CGFloat minValue, CGFloat maxValue) {
        
        
        
    };
    
    //设置标题，如果需要设置默认值 最好先写这个，否则设置默认值后不会第一时间触发
    slider.getMinTitle = ^NSString *(CGFloat minValue) {
        if (floor(minValue) == 0.f) {
            return @"0";
        }else{
            return [NSString stringWithFormat:@"%.f",floor(minValue)];
        }
        
    };
    
    slider.getMaxTitle = ^NSString *(CGFloat maxValue) {
        if (floor(maxValue) == 80.f) {
            return @"500";
        }else{
            return [NSString stringWithFormat:@"%.f",floor(maxValue)];
        }
    };
    
    slider.currentMinValue = 0;
    slider.currentMaxValue = 500;
    //分段 表示前部分占比80%  所在值范围为[0,30]  即剩下的 20%滑动距离 值范围为[30，80]
    slider.frontScale = 0.8;
    slider.frontValue = 30;
    
    slider.indicateViewOffset = 10;
    slider.indicateViewWidth = 40;
    
    [self.sliderView addSubview:slider];
    
    
}

- (void)initView {
    self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.7];
//房间类型
    
    [self.xiaBtn.layer setCornerRadius:3.0]; //设置矩圆角半径
    [self.xiaBtn.layer setBorderWidth:0.5];  //边框宽度

    [self.bikaiBtn.layer setCornerRadius:3.0]; //设置矩圆角半径
    [self.bikaiBtn.layer setBorderWidth:0.5];  //边框宽度

    [self.playerBtn.layer setCornerRadius:3.0]; //设置矩圆角半径
    [self.playerBtn.layer setBorderWidth:0.5];  //边框宽度

    //边框颜色
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 173/255.0, 173/255.0, 173/255.0, 1 });
    
    [self.xiaBtn.layer setBorderColor:colorref];
    [self.bikaiBtn.layer setBorderColor:colorref];
    [self.playerBtn.layer setBorderColor:colorref];


//排序
    [self.menBtn setTitleColor:[UIColor getColorWithTextTheme] forState:UIControlStateNormal];
    self.menBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.menBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 40, 0, 0);
    self.menBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [self.menBtn.layer setMasksToBounds:YES];
    [self.menBtn.layer setCornerRadius:3.0]; //设置矩圆角半径
    [self.menBtn.layer setBorderWidth:0.5];  //边框宽度
    
    [self.timeBtn setTitleColor:[UIColor getColorWithTextTheme] forState:UIControlStateNormal];
    self.timeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.timeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 40, 0, 0);
    self.timeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [self.timeBtn.layer setMasksToBounds:YES];
    [self.timeBtn.layer setCornerRadius:3.0]; //设置矩圆角半径
    [self.timeBtn.layer setBorderWidth:0.5];  //边框宽度

    [self.jiangBtn setTitleColor:[UIColor getColorWithTextTheme] forState:UIControlStateNormal];
    self.jiangBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.jiangBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 40, 0, 0);
    self.jiangBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [self.jiangBtn.layer setMasksToBounds:YES];
    [self.jiangBtn.layer setCornerRadius:3.0]; //设置矩圆角半径
    [self.jiangBtn.layer setBorderWidth:0.5];  //边框宽度
    
    //边框颜色
    [self.menBtn.layer setBorderColor:colorref];
    [self.timeBtn.layer setBorderColor:colorref];
    [self.jiangBtn.layer setBorderColor:colorref];

}


- (void)initData {
    
}


- (IBAction)xiaBtnClick:(UIButton *)sender {

    if (self.xiaBtn.selected == YES) {
        self.xiaBtn.selected = NO;
        self.xiaBtn.backgroundColor = [UIColor clearColor];
    }else{
        self.xiaBtn.selected = YES;
        self.xiaBtn.backgroundColor = [UIColor getColorWithTheme];
    }

    
}

- (IBAction)bikaiBtnClick:(UIButton *)sender {
    if (self.bikaiBtn.selected == YES) {
        self.bikaiBtn.selected = NO;
        self.bikaiBtn.backgroundColor = [UIColor clearColor];
    }else{
        self.bikaiBtn.selected = YES;
        self.bikaiBtn.backgroundColor = [UIColor getColorWithTheme];
    }
    

    
}

- (IBAction)playerBtnClick:(UIButton *)sender {
    if (self.playerBtn.selected == YES) {
        self.playerBtn.selected = NO;
        self.playerBtn.backgroundColor = [UIColor clearColor];
        
    }else{
        self.playerBtn.selected = YES;
        self.playerBtn.backgroundColor = [UIColor getColorWithTheme];

    }
    

}



//------------------------排序----------------------------------

- (IBAction)menBtnClick:(UIButton *)sender {
    if (self.menBtn.selected == NO) {
        self.menBtn.selected = YES;
    }else{
        self.menBtn.selected = NO;
    }
}

- (IBAction)timeBtnClick:(UIButton *)sender {
    if (self.timeBtn.selected == NO) {
        self.timeBtn.selected = YES;
    }else{
        self.timeBtn.selected = NO;
    }
}
    
- (IBAction)jiangBtnClick:(UIButton *)sender {
    if (self.jiangBtn.selected == NO) {
        self.jiangBtn.selected = YES;
    }else{
        self.jiangBtn.selected = NO;
    }
}



//确认
- (IBAction)turnBtnClick:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        // 设置view弹出来的位置
        self.downView.frame = CGRectMake(0, screen_Height, screen_Width, 300);
        
    }];
    
    self.hidden = YES;

    
}


//重置
- (IBAction)shuaBtnClick:(UIButton *)sender {

    
    
}


// 隐藏按钮
- (IBAction)hiddenBtnClick:(UIButton *)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        // 设置view弹出来的位置
        self.downView.frame = CGRectMake(0, screen_Height, screen_Width, 300);

    }];
    
    self.hidden = YES;


}

@end
