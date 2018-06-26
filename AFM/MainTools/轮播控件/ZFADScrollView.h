//
//  ZFADScrollView.h
//  CarServiceO2O
//
//  Created by 华四MAC on 16/8/22.
//  Copyright © 2016年 华四MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZFADScrollView;


@protocol ZFPageScrollViewDelegate <UIScrollViewDelegate>
@required
- (NSInteger)numberOfPageInPageScrollView:(ZFADScrollView *)pageScrollView;//cell的数量
@optional
- (void)pageScrollView:(ZFADScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index;//点击的cell
- (void)pageScrollView:(ZFADScrollView *)pageScrollView scrollPageAtIndex:(NSInteger)index;//滑动的cell
@end


@protocol ZFPageScrollViewDataSource <UIScrollViewDelegate>
@required
- (UIView*)pageScrollView:(ZFADScrollView *)pageScrollView viewForRowAtIndex:(int)index;//cell的view
- (UIView*)pageScrollViewDefaultView:(ZFADScrollView *)pageScrollView;//cell的默认图片
@end


@interface ZFADScrollView : UIScrollView
@property (nonatomic, strong) id <ZFPageScrollViewDataSource> pagedataSource;
@property (nonatomic, strong) id <ZFPageScrollViewDelegate> pagedelegate;
- (void)reloadData;//刷新视图
@end
