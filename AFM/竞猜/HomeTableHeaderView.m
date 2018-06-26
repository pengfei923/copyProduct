//
//  HomeTableHeaderView.m
//  AFM
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "HomeTableHeaderView.h"
#import "ZFADScrollView.h"
#import "New_InfoViewController.h"
#import "RoomInfoViewController.h"
#import "GoodsInfoViewController.h"
#import "RotaryViewController.h"
#import "MenpiaoViewController.h"
#import "AddZuanViewController.h"


#define PAGW  100.0f   //页码视图的宽度是
#define PAGH  15.0f    //页码视图的高度是

@interface HomeTableHeaderView() <ZFPageScrollViewDataSource , ZFPageScrollViewDelegate>{
    HeaderModel *headerModel;
}
@property (nonatomic,strong) ZFADScrollView  *ad_scrollview;
@property (nonatomic,strong) UIPageControl *ad_pageControl;  //标签页视图


@end
@implementation HomeTableHeaderView
@synthesize ad_scrollview = m_scrollview;
@synthesize ad_pageControl = m_pageControl;
@synthesize ad_array = m_ad_array;

//代码初始化导航栏
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
        [self initData];
    }
    return self;
}


//xib布局初始化导航栏
- (void)awakeFromNib{
    [super awakeFromNib];
    [self initView];
    [self initData];
}



//初始化view
- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
    self.autoresizesSubviews = NO;
    self.clipsToBounds = YES;
    
    m_scrollview = [[ZFADScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    m_scrollview.backgroundColor = [UIColor clearColor];
    m_scrollview.pagedataSource = self;
    m_scrollview.pagedelegate = self;
    [m_scrollview reloadData];
    [self addSubview:m_scrollview];
    
    //页码视图
    m_pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(CGRectGetWidth(m_scrollview.bounds)/2 - PAGW/2, CGRectGetHeight(m_scrollview.bounds) - PAGH, PAGW, PAGH)];
    m_pageControl.numberOfPages = 0;//页码数
    m_pageControl.currentPage = 0;//起始页码
    m_pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    m_pageControl.currentPageIndicatorTintColor = [UIColor getColorWithTheme];
    m_pageControl.backgroundColor = [UIColor clearColor];
    [m_pageControl bringSubviewToFront:self];
    [self addSubview:m_pageControl];
    
    
}


- (void)initData {
    AppCache *cache = [AppCache sharedInstance];
    if (cache.homeAdmodel) {
        self.ad_array = [[NSMutableArray alloc]initWithArray:cache.homeAdmodel.data];
    }
    [self startUpSystemCarousel];
}


//设置数据
- (void)setAd_array:(NSMutableArray *)ad_array {
    if(ad_array){
        m_ad_array = ad_array;
        m_pageControl.numberOfPages = m_ad_array.count;//页码数
        [m_scrollview reloadData];
    }
}

//空数据提示
- (UIView *)pageScrollViewDefaultView:(ZFADScrollView *)pageScrollView {
    UIImageView *view = [[UIImageView alloc]init];
    view.image = [UIImage imageNamed:@"sign-img"];
    view.contentMode = UIViewContentModeScaleAspectFit;
    return view;
}

//cell的view
- (UIView*)pageScrollView:(ZFADScrollView *)pageScrollView viewForRowAtIndex:(int)index {
    HeaderModelCell *model = [m_ad_array objectAtIndex:index];
    UIImageView *view = [[UIImageView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    
    view.yy_imageURL = [NSURL URLWithString:model.img];
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
    HeaderModelCell *model = [m_ad_array objectAtIndex:index];
    
    if ([model.url_type isEqualToString:@"1"]) {  //1商品
//        GoodsInfoViewController *infoView = [[GoodsInfoViewController alloc]init];
//        infoView.goods_ID = [NSString stringWithFormat:@"%@",model.url];
//        infoView.hidesBottomBarWhenPushed = YES;
//        [self.controller.navigationController pushViewController:infoView animated:YES];
    }else if ([model.url_type isEqualToString:@"2"]){   // 2赛事
        RoomInfoViewController *infoView = [[RoomInfoViewController alloc]init];
        infoView.Id = model.url;
        infoView.hidesBottomBarWhenPushed = YES;
        [self.controller.navigationController pushViewController:infoView animated:YES];
    }else if ([model.url_type isEqualToString:@"5"]){   //其他，不跳转
    }else if ([model.url_type isEqualToString:@"6"]){   //充值
        AddZuanViewController *infoView = [[AddZuanViewController alloc]init];
        infoView.hidesBottomBarWhenPushed = YES;
        [self.controller.navigationController pushViewController:infoView animated:YES];
        
    }else if ([model.url_type isEqualToString:@"7"]){   //门票购买
        MenpiaoViewController *infoView = [[MenpiaoViewController alloc]init];
        infoView.hidesBottomBarWhenPushed = YES;
        [self.controller.navigationController pushViewController:infoView animated:YES];
        
    }else if ([model.url_type isEqualToString:@"8"]){   //转盘
        RotaryViewController *infoView = [[RotaryViewController alloc]init];
        infoView.hidesBottomBarWhenPushed = YES;
        [self.controller.navigationController pushViewController:infoView animated:YES];
        
    }else{
        New_InfoViewController *infoView = [[New_InfoViewController alloc]init];
        infoView.url = model.url;
        infoView.hidesBottomBarWhenPushed = YES;
        [self.controller.navigationController pushViewController:infoView animated:YES];
    }    
}



//顶部广告
- (void)startUpSystemCarousel {
    //网络请求
    NSString *urlStr = @"http://api.aifamu.com/index.php?version=1&apptype=app&g=api&m=extra&a=slide";
    NSDictionary *paramters = @{@"user_token":@"token",
                             @"type":@"1",};
       AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
       [manager setSecurityPolicy:[AFMHTTPSManager customSecurityPolicy]];
       manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
       [manager POST: urlStr parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {

       } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           NSError *err;
           NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        if ([[dic objectForKey:@"error"]isEqualToNumber:@0]) {
            HeaderModel *tempmodel = [HeaderModel yy_modelWithDictionary:dic];
            AppCache *cache = [AppCache sharedInstance];
            cache.homeAdmodel = tempmodel;
            self.ad_array = [[NSMutableArray alloc]initWithArray:tempmodel.data];
            
            }else{
              
           }
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
       }];
}




@end

@implementation HeaderModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [HeaderModelCell class]};
}
@end

@implementation HeaderModelCell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}
@end
