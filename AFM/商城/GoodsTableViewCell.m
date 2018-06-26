//
//  GoodsTableViewCell.m
//  AFM
//
//  Created by admin on 2017/9/5.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "GoodsTableViewCell.h"
#import "GoodsCollectionViewCell.h"
#import "GoodsInfoViewController.h"

@interface GoodsTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    
    UICollectionView *produccollection;
    
}

@end
@implementation GoodsTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"GoodsTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
    self.autoresizesSubviews = NO;
    self.clipsToBounds = YES;
    
    self.more_Btn.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    self.more_Btn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);

}


- (void)layoutSubviews {
    [super layoutSubviews];
    if (!produccollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置collectionView滚动方向
        
        produccollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 41 , self.bounds.size.width, 292) collectionViewLayout:layout];
        produccollection.delegate = self;  //实现网格视图的delegate
        produccollection.dataSource = self;//实现网格视图的dataSource
        produccollection.backgroundColor = [UIColor clearColor];
        [produccollection registerClass:[GoodsCollectionViewCell class] forCellWithReuseIdentifier:@"GoodsCollectionViewCell"];//cell重用设置ID
        [self addSubview:produccollection];
        [produccollection reloadData];
    }
    
    
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.goods.count;
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
    GoodsModel_Info *model = [self.model.goods objectAtIndex:indexPath.row];
    GoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsCollectionViewCell" forIndexPath:indexPath];
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
    return CGSizeMake((self.bounds.size.width) / 2 -1, 145);
    
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsModel_Info *model = [self.model.goods objectAtIndex:indexPath.row];
    GoodsInfoViewController *infoView = [[GoodsInfoViewController alloc]init];
    infoView.goods_ID = model.Id;
    infoView.hidesBottomBarWhenPushed = YES;
    [self.controller.navigationController pushViewController:infoView animated:YES];

}





@end
