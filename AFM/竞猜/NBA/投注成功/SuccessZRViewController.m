//
//  SuccessZRViewController.m
//  AFM
//
//  Created by admin on 2017/9/13.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "SuccessZRViewController.h"
#import "ZRCollectionViewCell.h"
#import "ZR_PlayerCollectionViewCell.h"
#import "SaveZRViewController.h"
#import "ViewController_Page2.h"

#define screen_Width [UIScreen mainScreen].bounds.size.width

@interface SuccessZRViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    UICollectionView *PlayerCollectionView;
}

@property (nonatomic , strong) NSDictionary *lineup_info;
@property (nonatomic , strong) NSMutableArray *allData;          //
@property (nonatomic , strong) NSMutableArray *FirstData;          //

@end

@implementation SuccessZRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
    [self initData];
    
    //审核原因
    self.other_Btn.hidden = YES;
    self.fen_Btn.hidden = YES;
    self.fen_lab.hidden = YES;

    
}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"房间布阵";
    
}


//初始化界面
- (void)initView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];//设置collectionView滚动方向
    
    PlayerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 18 , screen_Width, 216) collectionViewLayout:layout];
    PlayerCollectionView.delegate = self;//实现网格视图的delegate
    PlayerCollectionView.dataSource = self;//实现网格视图的dataSource
    PlayerCollectionView.showsVerticalScrollIndicator = NO;
    PlayerCollectionView.showsHorizontalScrollIndicator = NO;
    PlayerCollectionView.scrollEnabled = NO;

    PlayerCollectionView.backgroundColor = [UIColor clearColor];
    [PlayerCollectionView registerClass:[ZR_PlayerCollectionViewCell class] forCellWithReuseIdentifier:@"ZR_PlayerCollectionViewCell"];//cell重用设置ID
    [self.centerView addSubview:PlayerCollectionView];
    [PlayerCollectionView reloadData];

    //标题栏
    [self.icon_Img yy_setImageWithURL:[NSURL URLWithString:self.iconImg] placeholder:[UIImage imageNamed:@" "]];
    self.name_lab.text = self.name;
    self.num_Lab.text = self.guess_num;
    self.other_Btn.layer.masksToBounds = YES;
    self.other_Btn.layer.cornerRadius = 5.0;
}

//初始化数据
- (void)initData{
    self.allData = [[NSMutableArray alloc] init];
    self.FirstData = [[NSMutableArray alloc] init];
    
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=bet&a=userlineup&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                @"id":self.ID,
                                @"type":@"2", // 获取阵容类型2已存1推荐
                                };
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
            
            ZR_ModelData *listModel = [ZR_ModelData yy_modelWithDictionary:dic];
            self.allData = [[NSMutableArray alloc]initWithArray:listModel.data];
            
            self.FirstData = [self.allData firstObject];

        }
        [PlayerCollectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([_nbaT_id isEqualToString:@"5"]) {
        return 5;
    }else{
        return 8;
    }
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
    ZR_PlayerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZR_PlayerCollectionViewCell" forIndexPath:indexPath];
    for (ZR_ModelDataCell *model in [[self.allData reverseObjectEnumerator] allObjects]) {
        NSArray *keys = [model.lineup_info allKeys];
        NSString *key = [keys objectAtIndex:indexPath.row];
        lineup_ModelInfo *Mymodel = [model.lineup_info objectForKey:key];
        
        cell.name_Lab.text = Mymodel.name;
        [cell.icon_Img yy_setImageWithURL:[NSURL URLWithString:Mymodel.img] placeholder:[UIImage imageNamed:@"player-photo"]];
        cell.right_Lab.text = [NSString stringWithFormat:@"%0.1f",Mymodel.average];
        
    
        if ([self.lol_nba_dota isEqualToString:@"nba"]) {
            if ([Mymodel.position isEqualToString:@"1"]) {
                cell.biao_Lab.text = @"控卫";
            }else if ([Mymodel.position isEqualToString:@"2"]){
                cell.biao_Lab.text = @"分卫";
            }else if ([Mymodel.position isEqualToString:@"3"]){
                cell.biao_Lab.text = @"小前";
            }else if ([Mymodel.position isEqualToString:@"4"]){
                cell.biao_Lab.text = @"大前";
            }else if ([Mymodel.position isEqualToString:@"5"]){
                cell.biao_Lab.text = @"中锋";
            }else if ([Mymodel.position isEqualToString:@"6"]){
                cell.biao_Lab.text = @"后卫";
            }else if ([Mymodel.position isEqualToString:@"7"]){
                cell.biao_Lab.text = @"前锋";
            }else{
                cell.biao_Lab.text = @"任意";
            }
            
        }else if ([self.lol_nba_dota isEqualToString:@"lol"]){
            if ([Mymodel.position isEqualToString:@"1"]) {
                cell.biao_Lab.text = @"上单";
            }else if ([Mymodel.position isEqualToString:@"2"]){
                cell.biao_Lab.text = @"打野";
            }else if ([Mymodel.position isEqualToString:@"3"]){
                cell.biao_Lab.text = @"中单";
            }else if ([Mymodel.position isEqualToString:@"4"]){
                cell.biao_Lab.text = @"ADC";
            }else if ([Mymodel.position isEqualToString:@"5"]){
                cell.biao_Lab.text = @"辅助";
            }else if ([Mymodel.position isEqualToString:@"6"]){
                cell.biao_Lab.text = @"团队";
            }else{
                cell.biao_Lab.text = @"替补";
            }
            
        }else{
            if ([Mymodel.position isEqualToString:@"1"]) {
                cell.biao_Lab.text = @"一号位";
            }else if ([Mymodel.position isEqualToString:@"2"]){
                cell.biao_Lab.text = @"二号位";
            }else if ([Mymodel.position isEqualToString:@"3"]){
                cell.biao_Lab.text = @"三号位";
            }else if ([Mymodel.position isEqualToString:@"4"]){
                cell.biao_Lab.text = @"四号位";
            }else if ([Mymodel.position isEqualToString:@"5"]){
                cell.biao_Lab.text = @"五号位";
            }else if ([Mymodel.position isEqualToString:@"6"]){
                cell.biao_Lab.text = @"战队";
            }else{
                cell.biao_Lab.text = @"替补";
            }
        }
    }
    return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (screen_Width == 325) {
        return CGSizeMake((screen_Width - 50) / 4 , 105);
    }else{
        return CGSizeMake((screen_Width - 50) / 4 , 105);
    }
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}


//匹配其他竞猜
- (IBAction)otherJCBtnClick:(UIButton *)sender {
    
    
}

//赛况详情
- (IBAction)infoSKBtnClick:(UIButton *)sender {
    ViewController_Page2 *infoVC = [[ViewController_Page2 alloc] init];
    [infoVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:infoVC animated:YES];
}
//分享
- (IBAction)shareBtnClick:(UIButton *)sender {
    [OpenShareComponent goShareMessage:@"推荐一个神秘的App给你" Url:@"html/microSite.html" Img:@"AppShareLogo"];
}
//竞猜大厅
- (IBAction)JCDTBtnClick:(UIButton *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];

}





@end
