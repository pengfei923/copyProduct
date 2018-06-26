//
//  MyPlayer_ZRViewController.m
//  AFM
//
//  Created by admin on 2017/9/21.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "MyPlayer_ZRViewController.h"
#import "MyPlayer_TopCell.h"
#import "MyPlayer_ZRTableViewCell.h"

@interface MyPlayer_ZRViewController ()<UITableViewDelegate , UITableViewDataSource>{

    
}
@property (nonatomic , strong) UITableView *tableView;          //列表视图


@end

@implementation MyPlayer_ZRViewController

NSString *top_PlayerView = @"MyPlayer_TopCell";
NSString *myPlayer_View = @"MyPlayer_ZRTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
    [self initData];
    
}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"详情";
    
}


//初始化界面
- (void)initView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.mainWidth, self.mainHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;  // 滚动条
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线
    self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView registerClass:[MyPlayer_TopCell class] forCellReuseIdentifier:top_PlayerView];
    [self.tableView registerClass:[MyPlayer_ZRTableViewCell class] forCellReuseIdentifier:myPlayer_View];
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
       [self.view addSubview:self.tableView];
}


//初始化数据
- (void)initData{

    
}



#pragma mark - 列表代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 ) {
        return 1;
    }else{
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 215;
    }else{
        return 100;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MyPlayer_TopCell *cell = [tableView dequeueReusableCellWithIdentifier:top_PlayerView];
        
//        cell.men_Lab.text = self.allmodel.price;
//        cell.jiang_Lab.text = self.allmodel.reward_num;
//        cell.zhu_Lab.text = [NSString stringWithFormat:@"%@/%@",self.allmodel.now_guess_num,self.allmodel.allow_guess_num];
//        cell.gozhu_Lab.text = [NSString stringWithFormat:@"%@/%@",self.allmodel.join_num,self.allmodel.allow_uguess_num];
//        
//        if ([self.allmodel.reward_id isEqualToString:@"1"]) {//门票
//            cell.img_jiang.image = [UIImage imageNamed:@"ticket-white"];
//        }else if ([self.allmodel.reward_id isEqualToString:@"8"]){//木头
//            cell.img_jiang.image = [UIImage imageNamed:@"wood-white"];
//        }else{
//        }
//        if ([self.allmodel.isnew_hand isEqualToString:@"1"]) {
//            cell.biao_image1.image = [UIImage imageNamed:@"novice-icon"];
//            if ([self.allmodel.open_id isEqualToString:@"1"]) {
//                cell.biao_image2.image = [UIImage imageNamed:@"open-icon"];
//                if ([self.allmodel.more_guess isEqualToString:@"1"]) {
//                    cell.biao_image3.image = [UIImage imageNamed:@"more-icon"];
//                }else{
//                    cell.biao_image3.hidden = YES;
//                }
//            }else{
//                if ([self.allmodel.more_guess isEqualToString:@"1"]) {
//                    cell.biao_image2.image = [UIImage imageNamed:@"more-icon"];
//                }else{
//                    cell.biao_image2.hidden = YES;
//                    cell.biao_image3.hidden = YES;
//                }
//            }
//        }
//        [cell.button3 addTarget:self action:@selector(button3Click:) forControlEvents:UIControlEventTouchUpInside];
//        cell.delegate = self;
        return cell;
    }else{
            MyPlayer_ZRTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myPlayer_View];
//            cell.name_Lab.text = usermodel.username;
//            cell.ch_Lab.text = usermodel.rank_name;
//            cell.num_Lab.text = usermodel.guess_num;
//            [cell.iconImgView yy_setImageWithURL:[NSURL URLWithString:usermodel.avatar_img] placeholder:[UIImage imageNamed:@" "]];
//            [cell.ch_ImgView yy_setImageWithURL:[NSURL URLWithString:usermodel.rank_img] placeholder:[UIImage imageNamed:@" "]];
        
            return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    if ([_Tag isEqualToString:@"3"]){
    //        RoomNew_listDataCell *model = [self.NEWData objectAtIndex:indexPath.row];
    //
    //
    //        
    //        
    //    }else{
    //
    //    }
    
    
}




@end
