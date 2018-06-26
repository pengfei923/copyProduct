//
//  MyCHTableViewCell.m
//  AFM
//
//  Created by admin on 2017/9/7.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "MyCHTableViewCell.h"
#import "CHCollectionViewCell.h"

@interface MyCHTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    
    UICollectionView *produccollection;
    
}


@end

@implementation MyCHTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MyCHTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)initData {
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=user&a=get_user_rank&version=2";
    NSDictionary *paramters = @{@"user_token":self.Token_cell,
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
            MyChengHaoModel *Model = [MyChengHaoModel yy_modelWithDictionary:dic];
            self.myRankArray = [[NSMutableArray alloc]initWithArray:Model.data];
            
        }
        
        [produccollection reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!produccollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置collectionView滚动方向
        
        int heigh_H;
        if (self.myRankArray.count >2) {
            heigh_H = 168;
        }else{
            heigh_H = 84;
        }
        
        produccollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 1 , self.bounds.size.width, heigh_H) collectionViewLayout:layout];
        produccollection.delegate = self;//实现网格视图的delegate
        produccollection.dataSource = self;//实现网格视图的dataSource
        produccollection.scrollEnabled = NO;//禁止滑动
        produccollection.backgroundColor = [UIColor clearColor];
        [produccollection registerClass:[CHCollectionViewCell class] forCellWithReuseIdentifier:@"CHCollectionViewCell"];//cell重用设置ID
        [self addSubview:produccollection];
        [produccollection reloadData];
    }
    
    
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.myRankArray.count;
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
    MyChengHaoModelCell *model = [self.myRankArray objectAtIndex:indexPath.row];
    CHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CHCollectionViewCell" forIndexPath:indexPath];
    if ([model.type isEqualToString:@"1"]) {
        cell.use_Btn.selected = YES;
        cell.use_Btn.backgroundColor = [UIColor grayColor];
    }else{
        cell.use_Btn.selected = NO;
        cell.use_Btn.backgroundColor = [UIColor getColorWithTheme];
    }
    cell.tit_Lab.text = model.name;
    cell.use_Btn.tag = indexPath.row;
    [cell.img_View yy_setImageWithURL:[NSURL URLWithString:model.avatar_img] placeholder:[UIImage imageNamed:@"矢量智能对象"]];

    [cell.use_Btn addTarget:self action:@selector(useBtnClick:) forControlEvents:UIControlEventTouchUpInside];


    return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((self.bounds.size.width) / 2 -1, 84);
    
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark --按钮点击事件
- (void)useBtnClick:(UIButton *)Btn{
    MyChengHaoModelCell *model = [self.myRankArray objectAtIndex:Btn.tag];
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=user&a=set_user_rank&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.Token_cell,
                            @"id":model.Id };
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

        }
        [self initData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

    
}



@end
