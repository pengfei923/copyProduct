//
//  NoS_ZRTableViewCell.m
//  AFM
//
//  Created by admin on 2017/9/26.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "NoS_ZRTableViewCell.h"
#import "ZR_PlayerCollectionViewCell.h"
#import "WSTableViewCellIndicator.h"
#import "PlayerInfoViewController.h"
#import "DJ_PlayerViewController.h"

#define kIndicatorViewTag -1


@interface NoS_ZRTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    UICollectionView *PlayerCollectionView;
}

@end

@implementation NoS_ZRTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NoS_ZRTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;

        [self initView];

    }
    return self;
}


- (void)initView{
    self.expandable = NO;
    self.expanded = NO;
   
    self.autoresizesSubviews = NO;
    self.clipsToBounds = YES;
    self.C_Button.layer.cornerRadius = 6;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    if(self.isExpanded) {
        if (![self containsIndicatorView]);
    else {
            [self removeIndicatorView];
            [self addIndicatorView];
    }
    }
    if (!PlayerCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];//设置collectionView滚动方向
        
        PlayerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 43 , self.bounds.size.width, 110) collectionViewLayout:layout];
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



static UIImage *_image = nil;
- (UIView *)expandableView {
    if (!_image) {
        _image = [UIImage imageNamed:@"plus"];
    }
    CGRect frame = CGRectMake(8, 8, 22, 22);
    self.IMG_Btn.frame = frame;
    [self.IMG_Btn setBackgroundImage:_image forState:UIControlStateNormal];
    return self.IMG_Btn;
}


- (void)setExpandable:(BOOL)isExpandable {
    if (isExpandable)
    [self expandableView];
    _expandable = isExpandable;
}

- (void)removeIndicatorView {
    id indicatorView = [self.contentView viewWithTag:kIndicatorViewTag];
    if (indicatorView) {
        [indicatorView removeFromSuperview];
        indicatorView = nil;
    }
}

- (BOOL)containsIndicatorView {
    return [self.contentView viewWithTag:kIndicatorViewTag] ? YES : NO;
}

- (void)accessoryViewAnimation {
    [UIView animateWithDuration:0.2 animations:^{
        if (self.isExpanded) {
            [self.IMG_Btn setBackgroundImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
        } else {
            [self.IMG_Btn setBackgroundImage:[UIImage imageNamed:@"shrink-icon"] forState:UIControlStateNormal];
        }
    } completion:^(BOOL finished) {
        if (!self.isExpanded)
            [self.IMG_Btn setBackgroundImage:[UIImage imageNamed:@"shrink-icon"] forState:UIControlStateNormal];
    }];
}



//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.Player.player_lineup_info.count;
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
    NSArray *keys = [[NSArray alloc] init];
    keys = [self.Player.player_lineup_info allKeys];
    NSString *key = [keys objectAtIndex:indexPath.row];
    SK_Wei_PlayerInfoData *Mymodel = [self.Player.player_lineup_info objectForKey:key];
    
    if ([self.fenshuType isEqualToString:@"dq"]) {
        NSArray *keyst = [[NSArray alloc] init];
        keyst = [self.Player.team_info allKeys];
        NSString *keyt = [keyst objectAtIndex:indexPath.row];
        SK_Wei_TeamInfoData *TeamModel = [self.Player.team_info objectForKey:keyt];
        cell.left_lab.text = @"当前分：";
        cell.right_Lab.text = TeamModel.score;
    }else{
        cell.left_lab.text = @"平均分：";
        cell.right_Lab.text = [NSString stringWithFormat:@"%0.1f",Mymodel.average];
    }
    
    cell.name_Lab.text = Mymodel.name;
    [cell.icon_Img yy_setImageWithURL:[NSURL URLWithString:Mymodel.img] placeholder:[UIImage imageNamed:@"player-photo"]];
    
    if ([self.Player.project_id isEqualToString:@"4"]) {          //nba
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
            cell.biao_Lab.text = @"任意";
        }else{
        }

    }else if ([self.Player.project_id isEqualToString:@"5"]){      //lol
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
            cell.biao_Lab.text = @"战队";
        }else{
        }

    }else {                                               //dota2
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
            cell.biao_Lab.text = @"团队";
        }else{
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
    NSArray *keys = [[NSArray alloc] init];
    keys = [self.Player.player_lineup_info allKeys];
    NSString *key = [keys objectAtIndex:indexPath.row];
    SK_Wei_PlayerInfoData *Mymodel = [self.Player.player_lineup_info objectForKey:key];
    
    if ([self.Player.project_id isEqualToString:@"4"]) {
        PlayerInfoViewController *PlayerVC = [[PlayerInfoViewController alloc] init];
        PlayerVC.lol_data_nba = @"nba";
        PlayerVC.player_id = Mymodel.Id;
        PlayerVC.IMG = Mymodel.img;
        PlayerVC.NAME = Mymodel.name;
        PlayerVC.SALARY = Mymodel.salary;
        PlayerVC.POIN = Mymodel.position;
        [PlayerVC setHidesBottomBarWhenPushed:YES];
        [self.controller.navigationController pushViewController:PlayerVC animated:YES];
    }else{
        DJ_PlayerViewController *PlayerVC = [[DJ_PlayerViewController alloc] init];
        if ([self.Player.project_id isEqualToString:@"5"]) {
             PlayerVC.lol_data_nba = @"lol";
        }else{
            PlayerVC.lol_data_nba = @"dota";
        }
        PlayerVC.ID_ = Mymodel.Id;
        [PlayerVC setHidesBottomBarWhenPushed:YES];
        [self.controller.navigationController pushViewController:PlayerVC animated:YES];
        
        
    }
   
    
}



@end
