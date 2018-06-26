//
//  InfoHeaderView.m
//  CarServiceTrafficViolator
//
//  Created by 张凡 on 2017/1/15.
//  Copyright © 2017年 张凡. All rights reserved.
//

#import "InfoHeaderView.h"

#define PAGW  100.0f   //页码视图的宽度是
#define PAGH  15.0f    //页码视图的高度是

@interface InfoHeaderView ()<ZFPageScrollViewDataSource , ZFPageScrollViewDelegate>
@property (nonatomic,strong) ZFADScrollView  *ad_scrollview;
@property (nonatomic,strong) UIPageControl* ad_pageControl;  //标签页视图
@property (nonatomic,strong) NSString *url_;  //

@end


@implementation InfoHeaderView
@synthesize ad_scrollview = m_scrollview;
@synthesize ad_pageControl = m_pageControl;
@synthesize ad_array = m_ad_array;


//代码初始化导航栏
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
      //  [self initView];
    }
    return self;
}


//xib布局初始化导航栏
- (void)awakeFromNib{
    [super awakeFromNib];
   // [self initView];
}


//初始化view
- (void)initView {
    self.autoresizesSubviews = NO;
    self.clipsToBounds = YES;
    
    //轮播视图
    m_scrollview = [[ZFADScrollView alloc]initWithFrame:self.bounds];
    m_scrollview.backgroundColor = [UIColor clearColor];
    m_scrollview.pagedataSource = self;
    m_scrollview.pagedelegate = self;
    [m_scrollview reloadData];
    [self addSubview:m_scrollview];
    
    //页码视图
    m_pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds)/2 - PAGW/2, CGRectGetHeight(self.bounds) - PAGH, PAGW, PAGH)];
    m_pageControl.numberOfPages = 0;//页码数
    m_pageControl.currentPage = 0;//起始页码
    m_pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    m_pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    m_pageControl.backgroundColor = [UIColor clearColor];
    [m_pageControl bringSubviewToFront:self];
    [self addSubview:m_pageControl];
}


- (void)layoutSubviews {
    if (!m_scrollview) {
        [self initView];
    }
}



//设置数据
- (void)setAd_array:(NSMutableArray *)ad_array {
    if(ad_array){
        m_ad_array = ad_array;
        m_pageControl.numberOfPages = m_ad_array.count;//页码数
        [m_scrollview reloadData];
    }
}


//空数据显示
- (UIView *)pageScrollViewDefaultView:(ZFADScrollView *)pageScrollView {
    UIImageView *view = [[UIImageView alloc]init];
    view.image = [UIImage imageNamed:@"DefaultImage0"];
    view.contentMode = UIViewContentModeScaleAspectFill;
    return view;
}


//cell的view
- (UIView*)pageScrollView:(ZFADScrollView *)pageScrollView viewForRowAtIndex:(int)index {
//    NSDictionary *dic = [m_ad_array objectAtIndex:index];
//    NSString *url = [dic objectForKey:@""];
    
    UIImageView *view = [[UIImageView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    
    NSURL *imgurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[m_ad_array objectAtIndex:index]]];
    view.yy_imageURL = imgurl;
    view.contentMode = UIViewContentModeScaleToFill;
    return view;
}


//轮播视图的数量
- (NSInteger)numberOfPageInPageScrollView:(ZFADScrollView *)pageScrollView {
    return m_ad_array.count;
}


//滑动标签
- (void)pageScrollView:(ZFADScrollView *)pageScrollView scrollPageAtIndex:(NSInteger)index {
    m_pageControl.currentPage = index;
}


//点击的cell
- (void)pageScrollView:(ZFADScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index {
}
@end
