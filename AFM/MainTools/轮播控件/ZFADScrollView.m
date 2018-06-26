//
//  ZFADScrollView.m
//  CarServiceO2O
//
//  Created by 华四MAC on 16/8/22.
//  Copyright © 2016年 华四MAC. All rights reserved.
//

#import "ZFADScrollView.h"
#define timers 4//定时器时间

@interface ZFADScrollView () <UIScrollViewDelegate>
@property (nonatomic, assign) CGSize cellSize;//cell的尺寸大小
@property (nonatomic, assign) NSInteger cellNumber;//cell的数量
@property (nonatomic, strong) NSTimer * cellTimer;//定时器
@end


@implementation ZFADScrollView

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self initView];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self initView];
	}
	return self;
}


/**
 *  初始化
 */
- (void)initView {
	self.delegate = self;
	self.autoresizesSubviews = NO;
	self.multipleTouchEnabled = NO;
	self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.backgroundColor = [UIColor whiteColor];
	
	self.showsHorizontalScrollIndicator = NO;
	self.showsVerticalScrollIndicator = NO;
	self.pagingEnabled = YES;
	
	self.cellSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}




/**
 *  刷新视图
 */
- (void)reloadData {
	[self updataUI];
	[self updataTimer];
}





- (void)updataUI{
	//移除所有cell
	[[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
	
	
	//cell数量
	if (!self.pagedelegate || ![self.pagedelegate respondsToSelector:@selector(numberOfPageInPageScrollView:)]) {
		NSLog(@"请实现numberOfPageInPageScrollView:");
		return;
	}
	
	//cell视图
	if (!self.pagedataSource || ![self.pagedataSource respondsToSelector:@selector(pageScrollView:viewForRowAtIndex:)]){
		NSLog(@"请实现pageScrollView:viewForRowAtIndex:");
		return;
	}
	
	
	//cell数量
	self.cellNumber = [self.pagedelegate numberOfPageInPageScrollView:self];
	int firstOne = 0;
	int lastOne = 0;
	
	//
	if (self.cellNumber <= 0) {
		if ([self.pagedataSource respondsToSelector:@selector(pageScrollViewDefaultView:)]) {
			UIView *cellDefault = [self.pagedataSource pageScrollViewDefaultView:self];
			cellDefault.frame = [self rectForViewAtIndex:0];
			cellDefault.clipsToBounds = YES;
			[self addSubview:cellDefault];
		}
        
    }else if (self.cellNumber <= 1) {
        
        UIView * cell_f = [self.pagedataSource pageScrollView:self viewForRowAtIndex:0];
        cell_f.frame = [self rectForViewAtIndex:0];
        cell_f.clipsToBounds = YES;
        [self addSubview:cell_f];
    
        //设置宽度
        float scrollViewSizeWith = _cellSize.width;
        self.contentSize = CGSizeMake(scrollViewSizeWith, 0);
        [self setContentOffset:CGPointMake(0, 0)];//默认显示的位置
        
    }else{
		
		//第一个
		if (self.cellNumber > 1) {
			UIView * cell = [self.pagedataSource pageScrollView:self viewForRowAtIndex:(int)(self.cellNumber - 1)];
			cell.frame = [self rectForViewAtIndex:0];
			cell.clipsToBounds = YES;
			[self addSubview:cell];
			firstOne++;
		}
		
		//cell数组
		for (int i = 0; i < self.cellNumber; i++) {
			UIView * cell = [self.pagedataSource pageScrollView:self viewForRowAtIndex:i];
			cell.frame = [self rectForViewAtIndex:i+1];
			cell.clipsToBounds = YES;
			[self addSubview:cell];
			
			
			//按钮
			UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom]; //添加按钮
			button.frame = [self rectForViewAtIndex:i+1];
			button.tag = i;
			[button addTarget:self action:@selector(ADbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
			[self addSubview:button];
		}
		
		//最后一个
		if (self.cellNumber > 1) {
			UIView * cell = [self.pagedataSource pageScrollView:self viewForRowAtIndex:0];
			cell.frame = [self rectForViewAtIndex:self.cellNumber + 1];
			cell.clipsToBounds = YES;
			[self addSubview:cell];
			lastOne++;
		}
		
		//设置宽度
		float scrollViewSizeWith = _cellSize.width * (self.cellNumber + firstOne + lastOne);
		self.contentSize = CGSizeMake(scrollViewSizeWith, 0);
		[self setContentOffset:CGPointMake(_cellSize.width, 0)];//默认显示的位置
	}
}



/**
 *  cell的坐标
 *
 *  @param index 标签
 *
 *  @return 坐标
 */
- (CGRect)rectForViewAtIndex:(NSInteger)index {
	CGFloat x = _cellSize.width * index;
	CGFloat y = (self.frame.size.height - _cellSize.height)/2;
	return CGRectMake(x, y, self.cellSize.width, self.cellSize.height);
}


#pragma mark - ===================================================
#pragma mark - 滑动视图代理


/**
 *  如果用户拖呼吁手指。减速是真的以后是否会继续
 *
 *  @param scrollView scrollView
 */
//开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
	if (self.cellTimer) { //刚开始拖拽的时候停掉计时器
		[self.cellTimer invalidate];//定时器无效
		self.cellTimer = nil;
	}
}


/**
 *  结束拖拽
 *
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

	if (self.cellNumber == 0){
		return;
	}
	
	int w = self.cellSize.width;//滚动视图的宽度
	int count = (scrollView.contentSize.width/w) - 2;//实际的广告数量
	int page = self.contentOffset.x/w;//当前页码
	
	if (page == 0) {//滑倒第0页
		[scrollView setContentOffset:CGPointMake(w * count, 0)];
		if (self.pagedataSource && [self.pagedataSource respondsToSelector:@selector(pageScrollView:scrollPageAtIndex:)]) {
			[self.pagedelegate pageScrollView:self scrollPageAtIndex:count-1];
		}
	}else if (page == count+1){//滑倒最后一页
		[scrollView setContentOffset:CGPointMake(w, 0)];
		if (self.pagedataSource && [self.pagedataSource respondsToSelector:@selector(pageScrollView:scrollPageAtIndex:)]) {
			[self.pagedelegate pageScrollView:self scrollPageAtIndex:0];
		}
	}else {
		if (self.pagedataSource && [self.pagedataSource respondsToSelector:@selector(pageScrollView:scrollPageAtIndex:)]) {
			[self.pagedelegate pageScrollView:self scrollPageAtIndex:page - 1];
		}
	}
	
	
	if (self.cellTimer == nil) {
		[self updataTimer];
	}
}









#pragma - mark 初始化定时器

- (void)updataTimer{
	if (self.cellTimer == nil) {
		self.cellTimer = [NSTimer scheduledTimerWithTimeInterval:timers target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
	}
}



//定时器方法
- (void)onTimer:(NSTimer*)timer{
	if (self.cellNumber <= 0) {
		[timer invalidate];//定时器无效
		timer = nil;
		return;
	}
    
    
    if (self.cellNumber <= 1) {
        [timer invalidate];//定时器无效
        timer = nil;
        return;
    }
	
    
	int w = self.cellSize.width;//滚动视图的宽度
	int count = (self.contentSize.width/w) - 2;//实际的广告数量
	
	//数量大于一
	if (count > 1) {
		int scrollPage = self.contentOffset.x/self.bounds.size.width;
		if (scrollPage >= count) {//如果页码等于最后一位数
			[self setContentOffset:CGPointMake(0, 0)];//先滑动到第一张图
			[self setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:YES];
			if (self.pagedataSource && [self.pagedataSource respondsToSelector:@selector(pageScrollView:scrollPageAtIndex:)]) {
				[self.pagedelegate pageScrollView:self scrollPageAtIndex:0];
			}
		}else{
			[self setContentOffset:CGPointMake(self.bounds.size.width*(scrollPage+1), 0) animated:YES];
			if (self.pagedataSource && [self.pagedataSource respondsToSelector:@selector(pageScrollView:scrollPageAtIndex:)]) {
				[self.pagedelegate pageScrollView:self scrollPageAtIndex:scrollPage];
			}
		}
	}
}




- (void)dealloc{
	if (self.cellTimer) { //刚开始拖拽的时候停掉计时器
		[self.cellTimer invalidate];//定时器无效
		self.cellTimer = nil;
	}
}




- (void)ADbuttonClick:(UIButton *)send{
	if (self.pagedataSource && [self.pagedataSource respondsToSelector:@selector(pageScrollView:didTapPageAtIndex:)]) {
		[self.pagedelegate pageScrollView:self didTapPageAtIndex:send.tag];
	}
}





@end
