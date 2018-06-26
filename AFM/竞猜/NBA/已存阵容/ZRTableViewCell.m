//
//  ZRTableViewCell.m
//  AFM
//
//  Created by admin on 2017/9/15.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "ZRTableViewCell.h"
#import "ZR_PlayerCollectionViewCell.h"

@interface ZRTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    UICollectionView *PlayerCollectionView;
}

@end

@implementation ZRTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ZRTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
    
    
    self.ZR_Btn.layer.cornerRadius = 4;
    self.autoresizesSubviews = NO;
    self.clipsToBounds = YES;

    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!PlayerCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];//设置collectionView滚动方向
        
        PlayerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 41 , self.bounds.size.width, 110) collectionViewLayout:layout];
        PlayerCollectionView.delegate = self;//实现网格视图的delegate
        PlayerCollectionView.dataSource = self;//实现网格视图的dataSource
        PlayerCollectionView.showsVerticalScrollIndicator = NO;
        PlayerCollectionView.showsHorizontalScrollIndicator = NO;

        PlayerCollectionView.backgroundColor = [UIColor clearColor];
        [PlayerCollectionView registerClass:[ZR_PlayerCollectionViewCell class] forCellWithReuseIdentifier:@"ZR_PlayerCollectionViewCell"];//cell重用设置ID
        [self addSubview:PlayerCollectionView];
        [PlayerCollectionView reloadData];
    }
    
    
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.lineup_info.count;
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
    
    NSArray *keys = [self.model.lineup_info allKeys];
    NSString *key = [keys objectAtIndex:indexPath.row];
    lineup_ModelInfo *Mymodel = [self.model.lineup_info objectForKey:key];
    
    cell.name_Lab.text = Mymodel.name;
    [cell.icon_Img yy_setImageWithURL:[NSURL URLWithString:Mymodel.img] placeholder:[UIImage imageNamed:@"player-photo"]];
    cell.right_Lab.text = [NSString stringWithFormat:@"%0.1f",Mymodel.average];
    
    
    if ([self.nba_lol_data isEqualToString:@"nba"]) {
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

    }else if ([self.nba_lol_data isEqualToString:@"lol"]){
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
    
    
    
    
    return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(90, 110);
    
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
    
    
}

@end

@implementation ZR_MyPlayer_Info
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}
@end
