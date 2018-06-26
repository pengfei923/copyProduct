//
//  MoreGoodsViewController.m
//  AFM
//
//  Created by admin on 2017/9/6.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "MoreGoodsViewController.h"
#import "GoodsCollectionViewCell.h"
#import "GoodsInfoViewController.h"

@interface MoreGoodsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    NSDictionary *Paramters;
}
@property (nonatomic, strong) UICollectionView *produccollection;
@property (nonatomic, strong) NSMutableArray   *listData;

@property (nonatomic, strong) UIButton *Mo_Btn;        //默认按钮
@property (nonatomic, strong) UIButton *Num_Btn;       //销量按钮
@property (nonatomic, strong) UIButton *Price_Btn;     //加个按钮



@end

@implementation MoreGoodsViewController
NSString *Goodss_cellad = @"GoodsCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
    [self initData];
}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = self.typeName;
    
}


//初始化界面
- (void)initView {
    
    UIView *top_View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, 39)];
    [self.view addSubview:top_View];
    
    int B_wisth = (screen_Width - 50)/3;
    
    //默认
    self.Mo_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.Mo_Btn.frame = CGRectMake(25, 2, B_wisth, 35);
    [self.Mo_Btn setTitle:@"默认" forState:UIControlStateNormal];
    [self.Mo_Btn setTitleColor:[UIColor getColorWithTextTheme] forState:UIControlStateNormal];
    self.Mo_Btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.Mo_Btn addTarget:self action:@selector(MoBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [top_View addSubview:self.Mo_Btn];
    
    //销量
    self.Num_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.Num_Btn.frame = CGRectMake(25 + B_wisth, 2, B_wisth, 35);
    [self.Num_Btn setTitle:@"销量" forState:UIControlStateNormal];
    [self.Num_Btn setTitleColor:[UIColor getColorWithTextTheme] forState:UIControlStateNormal];
    [self.Num_Btn setImage:[UIImage imageNamed:@"sort-icon"] forState:UIControlStateNormal];
    self.Num_Btn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.Num_Btn.imageEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    self.Num_Btn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [self.Num_Btn addTarget:self action:@selector(NumBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [top_View addSubview:self.Num_Btn];

    //价格
    self.Price_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.Price_Btn.frame = CGRectMake(25 + (B_wisth*2), 2, B_wisth, 35);
    [self.Price_Btn setTitle:@"价格" forState:UIControlStateNormal];
    [self.Price_Btn setTitleColor:[UIColor getColorWithTextTheme] forState:UIControlStateNormal];
    [self.Price_Btn setImage:[UIImage imageNamed:@"sort-icon"] forState:UIControlStateNormal];
    self.Price_Btn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.Price_Btn.imageEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    self.Price_Btn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [self.Price_Btn addTarget:self action:@selector(PriceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [top_View addSubview:self.Price_Btn];

    
    
    //
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置竖直滚动方向
    
    self.produccollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40 , screen_Width, screen_Height - 40 -64) collectionViewLayout:layout];
    self.produccollection.delegate = self;    
    self.produccollection.dataSource = self;
    self.produccollection.backgroundColor = [UIColor clearColor];
    [self.produccollection registerClass:[GoodsCollectionViewCell class] forCellWithReuseIdentifier:Goodss_cellad];//cell重用设置ID
    [self.view addSubview:self.produccollection];
    [self.produccollection reloadData];
    
}


//默认
- (void)MoBtnClick:(UIButton *)Btn{
    [self.Price_Btn setImage:[UIImage imageNamed:@"sort-icon"] forState:UIControlStateNormal];
    [self.Num_Btn setImage:[UIImage imageNamed:@"sort-icon"] forState:UIControlStateNormal];
    self.Num_Btn.selected = NO;
    self.Price_Btn.selected = NO;
    [self initData];
}

//销量
- (void)NumBtnClick:(UIButton *)Btn{
    self.Price_Btn.selected = NO;

    if (_Num_Btn.selected == NO) {
        self.Num_Btn.selected = YES;
        [self.Num_Btn setImage:[UIImage imageNamed:@"sort-down-icon"] forState:UIControlStateSelected];
        [self.Price_Btn setImage:[UIImage imageNamed:@"sort-icon"] forState:UIControlStateNormal];
       
        if ([self.typeName isEqualToString:@"虚拟商品"]) {
            [self initListDataWithVir:@"1" andWithType:@"2" andWithOrder:@"2" andWithMandNM:@"1"];//销量2倒序2
        }else{
            [self initListDataWithVir:@"2" andWithType:@"2" andWithOrder:@"2" andWithMandNM:@"1"];
        }

    }else{
        self.Num_Btn.selected = NO;
        [self.Num_Btn setImage:[UIImage imageNamed:@"sort-up-icon"] forState:UIControlStateNormal];
        [self.Price_Btn setImage:[UIImage imageNamed:@"sort-icon"] forState:UIControlStateNormal];
   
        if ([self.typeName isEqualToString:@"虚拟商品"]) {
            [self initListDataWithVir:@"1" andWithType:@"1" andWithOrder:@"2" andWithMandNM:@"1"];//销量2正序1
        }else{
            [self initListDataWithVir:@"2" andWithType:@"1" andWithOrder:@"2" andWithMandNM:@"1"];
            
        }
    }

}

 //价格
- (void)PriceBtnClick:(UIButton *)Btn{
    self.Num_Btn.selected = NO;

    if (self.Price_Btn.selected == NO) {
        self.Price_Btn.selected = YES;
        [self.Price_Btn setImage:[UIImage imageNamed:@"sort-down-icon"] forState:UIControlStateSelected];
        [self.Num_Btn setImage:[UIImage imageNamed:@"sort-icon"] forState:UIControlStateNormal];

        if ([self.typeName isEqualToString:@"虚拟商品"]) {
            [self initListDataWithVir:@"1" andWithType:@"2" andWithOrder:@"1" andWithMandNM:@"1"];//虚拟1倒序2价格1非默认1
        }else{
            [self initListDataWithVir:@"2" andWithType:@"2" andWithOrder:@"1" andWithMandNM:@"1"];
        }

    }else{
        self.Price_Btn.selected = NO;
        [self.Price_Btn setImage:[UIImage imageNamed:@"sort-up-icon"] forState:UIControlStateNormal];
        [self.Num_Btn setImage:[UIImage imageNamed:@"sort-icon"] forState:UIControlStateNormal];

        if ([self.typeName isEqualToString:@"虚拟商品"]) {
            [self initListDataWithVir:@"1" andWithType:@"1" andWithOrder:@"1" andWithMandNM:@"1"];//虚拟1正序1价格1非默认1
        }else{
            [self initListDataWithVir:@"2" andWithType:@"1" andWithOrder:@"1" andWithMandNM:@"1"];
            
        }
    }

 
}





//初始化数据
- (void)initData {
    self.listData = [[NSMutableArray alloc] init];
    
    if ([self.typeName isEqualToString:@"虚拟商品"]) {
        [self initListDataWithVir:@"1" andWithType:nil andWithOrder:nil andWithMandNM:@"0"];
    }else{
        [self initListDataWithVir:@"2" andWithType:nil andWithOrder:nil andWithMandNM:@"0"];

    }

}


- (void) initListDataWithVir:(NSString *)vir andWithType:(NSString *)type  andWithOrder:(NSString *)order andWithMandNM:(NSString *)moren{
    
    
    NSString *urlStr = ApiUserGoods_list;
    
    if ([moren isEqualToString:@"0"]) {      //默认
        Paramters = @{@"user_token":self.appCache.loginViewModel.token,
                    @"is_virtual":vir,     //是否是虚拟  1是  2否
                    };
    }else{
        Paramters = @{@"user_token":self.appCache.loginViewModel.token,
                    @"order":order,       //排序类型   1价格 2销量
                    @"order_type":type,    //排序方式   1正序 2倒序
                    @"is_virtual":vir,     //是否是虚拟  1是  2否
                    };

    }
    
    NSDictionary *paramters = Paramters;
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
            GoodsAllListModel *model = [GoodsAllListModel yy_modelWithDictionary:dic];
            self.listData = [[NSMutableArray alloc]initWithArray:model.data];
        }
        [self.produccollection reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listData.count;
}


//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.1;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}


//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Goodss_cellad forIndexPath:indexPath];
    GoodsAllListModelCell *model = [self.listData objectAtIndex:indexPath.row];

    cell.title_Lab.text = model.name;
    cell.num_Lab.text = model.price;
    cell.people_Lab.text = [NSString stringWithFormat:@"%@人兑换",[NSString notEmpty:model.sell_num]];
    [cell.url_ImgView yy_setImageWithURL:[NSURL URLWithString:model.avatar_img] placeholder:[UIImage imageNamed:@"矢量智能对象"]];
    if ([model.type isEqualToString:@"1"]) {  //砖头
        [cell.type_ImgView setImage:[UIImage imageNamed:@"ticket-red"]];
    }else{                               //木头
        [cell.type_ImgView setImage:[UIImage imageNamed:@"wood-red"]];
        
    }
    
    return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((screen_Width) / 2 -1, 145);
    
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GoodsAllListModelCell *model = [self.listData objectAtIndex:indexPath.row];
    GoodsInfoViewController *infoView = [[GoodsInfoViewController alloc]init];
    infoView.goods_ID = model.Id;
    infoView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:infoView animated:YES];
    
}

@end



//
@implementation GoodsAllListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [GoodsAllListModelCell class]};
}
@end


@implementation GoodsAllListModelCell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}

@end
