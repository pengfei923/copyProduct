//
//  SuccessZRViewController.h
//  AFM
//
//  Created by admin on 2017/9/13.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BaseViewController.h"

@interface SuccessZRViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIView *other_Btn;
@property (weak,   nonatomic) IBOutlet UIView *centerView;
@property (retain, nonatomic) IBOutlet UICollectionView *ZRCollectionView;

@property (nonatomic , strong) NSDictionary *IdDic;               //选手id数组
@property (nonatomic , strong) NSMutableArray *playeData;               //选手
@property (nonatomic , strong) NSString *ID;               //房间id
@property (nonatomic , strong) NSString *name;               //房间名
@property (nonatomic , strong) NSString *iconImg;               //房间图标
@property (nonatomic , strong) NSString *guess_num;    //竞猜数量
@property (nonatomic , strong) NSString *nbaT_id;    //nba5/8 人
@property (nonatomic , strong) NSString *lol_nba_dota;      //nba/dota/lol

//标题栏
@property (weak, nonatomic) IBOutlet UIImageView *icon_Img;
@property (weak, nonatomic) IBOutlet UILabel *name_lab;
@property (weak, nonatomic) IBOutlet UILabel *num_Lab;

@property (weak, nonatomic) IBOutlet UILabel *fen_lab;
@property (weak, nonatomic) IBOutlet UIButton *fen_Btn;


@end
