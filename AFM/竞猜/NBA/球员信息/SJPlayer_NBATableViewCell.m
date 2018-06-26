//
//  SJPlayer_NBATableViewCell.m
//  AFM
//
//  Created by admin on 2017/11/14.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "SJPlayer_NBATableViewCell.h"
#import "Biao_TopTableViewCell.h"
#import "Biao_TableViewCell.h"
#import "SJ_NBATableViewCell.h"
#import "SJnum_NBATableViewCell.h"


@interface SJPlayer_NBATableViewCell()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>{
    UIScrollView *scrollView;
    NSString *TOP;
}
@end

@implementation SJPlayer_NBATableViewCell

NSString *Topnba_cell = @"Biao_TopTableViewCell";
NSString *Biaonba_cell = @"Biao_TableViewCell";
NSString *Shunba_cell = @"SJ_NBATableViewCell";
NSString *Shunumnba_cell = @"SJnum_NBATableViewCell";


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SJPlayer_NBATableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
        
    }
    return self;
}

- (void)initView{
    [self initOldView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    //    self.tableView.scrollEnabled = NO;
    self.tableView.tag = 1;
    self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView registerClass:[Biao_TopTableViewCell class] forCellReuseIdentifier:Topnba_cell];
    [self.tableView registerClass:[Biao_TableViewCell class] forCellReuseIdentifier:Biaonba_cell];
    
    
    scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(180, 0, 400, ([UIScreen mainScreen].bounds.size.height - 224-50-64));  // frame中的size指UIScrollView的可视范围
    scrollView.contentSize =  CGSizeMake((400*2 - ([UIScreen mainScreen].bounds.size.width - 180)), 0);     //设置偏移量
    scrollView.backgroundColor = [UIColor redColor];
    
    
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;    //水平方向的指示器
    scrollView.showsVerticalScrollIndicator = NO;     //垂直方向的指示器
    //    _scrollView.pagingEnabled = YES;  //设置按页滚动
    scrollView.bounces = NO;//设置滚动到边界的回弹效果
    [self.downView addSubview:scrollView];
    
    self.tableView2 = [[UITableView alloc] init];
    self.tableView2.frame = CGRectMake(0, 0, 400, ([UIScreen mainScreen].bounds.size.height -224-50-64));
    self.tableView2.dataSource = self;
    self.tableView2.delegate = self;
    self.tableView2.showsVerticalScrollIndicator = NO;
    //    self.tableView2.scrollEnabled = NO;
    self.tableView2.tag = 2;
    self.tableView2.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView2.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView2 registerClass:[SJ_NBATableViewCell class] forCellReuseIdentifier:Shunba_cell];
    [self.tableView2 registerClass:[SJnum_NBATableViewCell class] forCellReuseIdentifier:Shunumnba_cell];
    self.tableView2.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];

    [scrollView addSubview:self.tableView2];
    
    TOP = @"1";
    
}


//设置初始化
- (void)initOldView{
    [self.JinS_Btn.layer setCornerRadius:3.0]; //设置矩圆角半径
    [self.JinS_Btn.layer setBorderWidth:0.5];  //边框宽度
    
    [self.All_Btn.layer setCornerRadius:3.0]; //设置矩圆角半径
    [self.All_Btn.layer setBorderWidth:0.5];  //边框宽度
    
    [self.ZhuC_Btn.layer setCornerRadius:3.0]; //设置矩圆角半径
    [self.ZhuC_Btn.layer setBorderWidth:0.5];  //边框宽度

    [self.KeC_Btn.layer setCornerRadius:3.0]; //设置矩圆角半径
    [self.KeC_Btn.layer setBorderWidth:0.5];  //边框宽度

    //边框颜色
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 225/255.0, 80/255.0, 80/255.0, 1 });
    
    [self.JinS_Btn.layer setBorderColor:colorref];
    [self.All_Btn.layer setBorderColor:colorref];
    [self.ZhuC_Btn.layer setBorderColor:colorref];
    [self.KeC_Btn.layer setBorderColor:colorref];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        if ([TOP isEqualToString:@"1"]) {
            return self.model.ten_match_info.count + 1;
        }else if ([TOP isEqualToString:@"2"]){
            return self.model.all_match_info.count + 1;
        }else{
            return  1;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor lightGrayColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (indexPath.section == 0)? 28 : 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 1) {
        if (indexPath.section == 0) {
            Biao_TopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Topnba_cell];
            return cell;
        }else{
            if (indexPath.row == 0) {
                Biao_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Biaonba_cell];
                cell.time_Lab.hidden = YES;
                cell.bi_Lab.hidden = YES;
                cell.team_Lab.hidden = YES;
                
                UIView *dowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 44)];
                dowView.backgroundColor = [UIColor getColorWithR:225 G:188 B:184 A:1];
                [cell addSubview:dowView];
                
                UILabel *CJ_lab = [[UILabel alloc] initWithFrame:CGRectMake(65,12,50,20)];
                CJ_lab.text = @"场均数据";
                CJ_lab.textColor = [UIColor darkGrayColor];
                CJ_lab.font = [UIFont systemFontOfSize:11];
                [dowView addSubview:CJ_lab];
                return cell;

            }else{
                if ([TOP isEqualToString:@"1"]) {
                    NSString *CellIdenti = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
                    Biao_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdenti];
                    if (cell == nil) {
                        cell = [[Biao_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Biaonba_cell];
                        PlayerModel_Ten_Cell *ten_Model = [self.model.ten_match_info objectAtIndex:indexPath.row - 1];
                        cell.time_Lab.text = ten_Model.match_time_data;
                        cell.bi_Lab.text = [NSString stringWithFormat:@"%@ : %@",[ten_Model.match_info objectForKey:@"score_a"],[ten_Model.match_info objectForKey:@"score_b"] ];
                        cell.team_Lab.text = [ten_Model.team_b_info objectForKey:@"name"];
                    }
                    return cell;
                }else if ([TOP isEqualToString:@"2"]){
                    NSString *CellIdenti = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
                    Biao_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdenti];
                    if (cell == nil) {
                        cell = [[Biao_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Biaonba_cell];
                        PlayerModel_Ten_Cell *ten_Model = [self.model.ten_match_info objectAtIndex:indexPath.row - 1];
                        cell.time_Lab.text = ten_Model.match_time_data;
                        cell.bi_Lab.text = [NSString stringWithFormat:@"%@ : %@",[ten_Model.match_info objectForKey:@"score_a"],[ten_Model.match_info objectForKey:@"score_b"] ];
                        cell.team_Lab.text = [ten_Model.team_b_info objectForKey:@"name"];
                    }
                    return cell;
                }else{
                    NSString *CellIdenti = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
                    Biao_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdenti];
                    if (cell == nil) {
                        cell = [[Biao_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Biaonba_cell];
                        PlayerModel_Ten_Cell *ten_Model = [self.model.ten_match_info objectAtIndex:indexPath.row - 1];
                        cell.time_Lab.text = ten_Model.match_time_data;
                        cell.bi_Lab.text = [NSString stringWithFormat:@"%@ : %@",[ten_Model.match_info objectForKey:@"score_a"],[ten_Model.match_info objectForKey:@"score_b"] ];
                        cell.team_Lab.text = [ten_Model.team_b_info objectForKey:@"name"];
                    }
                    return cell;
                }
            }
        }
    }else{      ///---------------右边
        if (indexPath.section == 0) {
            SJ_NBATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Shunba_cell];
            return cell;
        }else{
            if (indexPath.row == 0) {
                SJnum_NBATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Shunumnba_cell];
                cell.lable1.textColor = [UIColor getColorWithTheme];
                cell.lable2.textColor = [UIColor getColorWithTheme];
                cell.lable3.textColor = [UIColor getColorWithTheme];
                cell.lable4.textColor = [UIColor getColorWithTheme];
                cell.lable5.textColor = [UIColor getColorWithTheme];
                cell.lable6.textColor = [UIColor getColorWithTheme];
                cell.lable7.textColor = [UIColor getColorWithTheme];
                cell.lable8.textColor = [UIColor getColorWithTheme];
                cell.lable9.textColor = [UIColor getColorWithTheme];

                cell.lable1.backgroundColor = [UIColor getColorWithR:225 G:188 B:184 A:1];
                cell.lable2.backgroundColor = [UIColor getColorWithR:225 G:188 B:184 A:1];
                cell.lable3.backgroundColor = [UIColor getColorWithR:225 G:188 B:184 A:1];
                cell.lable4.backgroundColor = [UIColor getColorWithR:225 G:188 B:184 A:1];
                cell.lable5.backgroundColor = [UIColor getColorWithR:225 G:188 B:184 A:1];
                cell.lable6.backgroundColor = [UIColor getColorWithR:225 G:188 B:184 A:1];
                cell.lable7.backgroundColor = [UIColor getColorWithR:225 G:188 B:184 A:1];
                cell.lable8.backgroundColor = [UIColor getColorWithR:225 G:188 B:184 A:1];
                cell.lable9.backgroundColor = [UIColor getColorWithR:225 G:188 B:184 A:1];

                if ([TOP isEqualToString:@"1"]) {
                    cell.lable1.text = [NSString stringWithFormat:@"%0.1f",self.model.season_avg_10.score];
                    cell.lable2.text = [NSString stringWithFormat:@"%0.1f",self.model.season_avg_10.play_time];
                    cell.lable3.text = [NSString stringWithFormat:@"%0.1f",self.model.season_avg_10.get_score];
                    cell.lable4.text = [NSString stringWithFormat:@"%0.1f",self.model.season_avg_10.three_point];
                    cell.lable5.text = [NSString stringWithFormat:@"%0.1f",self.model.season_avg_10.backboard];
                    cell.lable6.text = [NSString stringWithFormat:@"%0.1f",self.model.season_avg_10.help_score];
                    cell.lable7.text = [NSString stringWithFormat:@"%0.1f",self.model.season_avg_10.hinder_score];
                    cell.lable8.text = [NSString stringWithFormat:@"%0.1f",self.model.season_avg_10.cover_score];
                    cell.lable9.text = [NSString stringWithFormat:@"%0.1f",self.model.season_avg_10.mistake_score];
                }else if ([TOP isEqualToString:@"2"]){
                    cell.lable1.text = self.jiF;
                    cell.lable2.text = self.time;
                    cell.lable3.text = self.deF;
                    cell.lable4.text = self.sanF;
                    cell.lable5.text = self.lanB;
                    cell.lable6.text = self.zhuG;
                    cell.lable7.text = self.qiangD;
                    cell.lable8.text = self.fengG;
                    cell.lable9.text = self.shiW;
                    
                }else{
                   
                    
                }

                return cell;
            }else{
                
                if ([TOP isEqualToString:@"1"]) {
                    NSString *cellIdent = [NSString stringWithFormat:@"cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
                    SJnum_NBATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
                    if (cell == nil) {
                        cell = [[SJnum_NBATableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Shunumnba_cell];
                        PlayerModel_Ten_Cell *ten_Model = [self.model.ten_match_info objectAtIndex:indexPath.row - 1];

                        cell.lable1.text = [NSString stringWithFormat:@"%0.1f",ten_Model.score];
                        cell.lable2.text = [NSString stringWithFormat:@"%0.1f",ten_Model.play_time];
                        cell.lable3.text = [NSString stringWithFormat:@"%0.1f",ten_Model.get_score];
                        cell.lable4.text = [NSString stringWithFormat:@"%0.1f",ten_Model.three_point];
                        cell.lable5.text = [NSString stringWithFormat:@"%0.1f",ten_Model.backboard];
                        cell.lable6.text = [NSString stringWithFormat:@"%0.1f",ten_Model.help_score];
                        cell.lable7.text = [NSString stringWithFormat:@"%0.1f",ten_Model.hinder_score];
                        cell.lable8.text = [NSString stringWithFormat:@"%0.1f",ten_Model.cover_score];
                        cell.lable9.text = [NSString stringWithFormat:@"%0.1f",ten_Model.mistake_score];
                    }
                    return cell;
                }else if ([TOP isEqualToString:@"2"]){
                    NSString *cellIdent = [NSString stringWithFormat:@"cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
                    SJnum_NBATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
                    if (cell == nil) {
                        cell = [[SJnum_NBATableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Shunumnba_cell];
//                        DJ_PlayerModel_All_Cell *all_Model = [self.model.all objectAtIndex:indexPath.row - 1];
//                        cell.lable1.text = all_Model.times;
//                        cell.lable2.text = [NSString stringWithFormat:@"%0.1f",all_Model.scores];
//                        cell.lable3.text = [NSString stringWithFormat:@"%0.1f",all_Model.kill];
//                        cell.lable4.text = [NSString stringWithFormat:@"%0.1f",all_Model.assists];
//                        cell.lable5.text = [NSString stringWithFormat:@"%0.1f",all_Model.death];
//                        cell.lable6.text = [NSString stringWithFormat:@"%0.1f",all_Model.jungle];
//                        cell.lable7.text = [NSString stringWithFormat:@"%0.1f",all_Model.ten_kill];
                    }
                    return cell;
                }else{
                    NSString *cellIdent = [NSString stringWithFormat:@"cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
                    SJnum_NBATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
                    if (cell == nil) {
                        cell = [[SJnum_NBATableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Shunumnba_cell];
//                        DJ_PlayerModel_Season_Cell *sea_Model = [self.model.season objectAtIndex:indexPath.row - 1];
//                        cell.lable1.text = sea_Model.times;
//                        cell.lable2.text = [NSString stringWithFormat:@"%0.1f",sea_Model.scores];
//                        cell.lable3.text = [NSString stringWithFormat:@"%0.1f",sea_Model.kill];
//                        cell.lable4.text = [NSString stringWithFormat:@"%0.1f",sea_Model.assists];
//                        cell.lable5.text = [NSString stringWithFormat:@"%0.1f",sea_Model.death];
//                        cell.lable6.text = [NSString stringWithFormat:@"%0.1f",sea_Model.jungle];
//                        cell.lable7.text = [NSString stringWithFormat:@"%0.1f",sea_Model.ten_kill];
                    }
                    return cell;
                }
            }
        }
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _tableView) {
        _tableView2.contentOffset = _tableView.contentOffset;
    } else {
        _tableView.contentOffset = _tableView2.contentOffset;
    }
}

- (IBAction)shi_BtnClick:(UIButton *)sender {
    self.JinS_Btn.selected = YES;
    self.JinS_Btn.backgroundColor = [UIColor getColorWithTheme];
    self.All_Btn.selected = NO;
    self.All_Btn.backgroundColor = [UIColor clearColor];
    TOP = @"1";
    [self.tableView reloadData];
    [self.tableView2 reloadData];
    
}

- (IBAction)all_BtnClick:(UIButton *)sender {
    self.All_Btn.selected = YES;
    self.All_Btn.backgroundColor = [UIColor getColorWithTheme];
    self.JinS_Btn.selected = NO;
    self.JinS_Btn.backgroundColor = [UIColor clearColor];
    TOP = @"2";
    [self.tableView reloadData];
    [self.tableView2 reloadData];
    
}

- (IBAction)zhu_BtnClick:(UIButton *)sender {
    
    
}

- (IBAction)ke_BtnClick:(UIButton *)sender {
    
    
}







@end
