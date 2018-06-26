//
//  BSRZ_TableViewCell.m
//  AFM
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BSRZ_TableViewCell.h"
#import "Biao_TopTableViewCell.h"
#import "Biao_TableViewCell.h"
#import "ShuJtop_TableViewCell.h"
#import "ShuJ_TableViewCell.h"


@interface BSRZ_TableViewCell()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>{
    UIScrollView *scrollView;
    NSString *TOP;
}

@end

@implementation BSRZ_TableViewCell

NSString *Top_cell = @"Biao_TopTableViewCell";
NSString *Biao_cell = @"Biao_TableViewCell";
NSString *Top_SJcell = @"ShuJtop_TableViewCell";
NSString *Biao_SJcell = @"ShuJ_TableViewCell";


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"BSRZ_TableViewCell" owner:nil options:nil];
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
    [self.tableView registerClass:[Biao_TopTableViewCell class] forCellReuseIdentifier:Top_cell];
    [self.tableView registerClass:[Biao_TableViewCell class] forCellReuseIdentifier:Biao_cell];


    scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(150, 0, 360, ([UIScreen mainScreen].bounds.size.height - 194-50-64));  // frame中的size指UIScrollView的可视范围
    scrollView.contentSize =  CGSizeMake((360*2 - ([UIScreen mainScreen].bounds.size.width - 150)), 0);     //设置偏移量
    scrollView.backgroundColor = [UIColor redColor];


    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;    //水平方向的指示器
    scrollView.showsVerticalScrollIndicator = NO;     //垂直方向的指示器
//    _scrollView.pagingEnabled = YES;  //设置按页滚动
    scrollView.bounces = NO;//设置滚动到边界的回弹效果
    [self.downView addSubview:scrollView];

    self.tableView2 = [[UITableView alloc] init];
    self.tableView2.frame = CGRectMake(0, 0, 360, ([UIScreen mainScreen].bounds.size.height -194-50-64));
    self.tableView2.dataSource = self;
    self.tableView2.delegate = self;
    self.tableView2.showsVerticalScrollIndicator = NO;
//    self.tableView2.scrollEnabled = NO;
    self.tableView2.tag = 2;
    self.tableView2.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView2.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView2 registerClass:[ShuJtop_TableViewCell class] forCellReuseIdentifier:Top_SJcell];
    [self.tableView2 registerClass:[ShuJ_TableViewCell class] forCellReuseIdentifier:Biao_SJcell];
    self.tableView2.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];

    [scrollView addSubview:self.tableView2];

    TOP = @"1";

}


//设置初始化
- (void)initOldView{
    [self.jinS_Btn.layer setCornerRadius:3.0]; //设置矩圆角半径
    [self.jinS_Btn.layer setBorderWidth:0.5];  //边框宽度
    
    [self.all_Btn.layer setCornerRadius:3.0]; //设置矩圆角半径
    [self.all_Btn.layer setBorderWidth:0.5];  //边框宽度
    
    [self.benS_Btn.layer setCornerRadius:3.0]; //设置矩圆角半径
    [self.benS_Btn.layer setBorderWidth:0.5];  //边框宽度
    
    //边框颜色
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 225/255.0, 80/255.0, 80/255.0, 1 });
    
    [self.jinS_Btn.layer setBorderColor:colorref];
    [self.all_Btn.layer setBorderColor:colorref];
    [self.benS_Btn.layer setBorderColor:colorref];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        if ([TOP isEqualToString:@"1"]) {
            return self.model.ten.count + 1;
        }else if ([TOP isEqualToString:@"2"]){
            return self.model.all.count + 1;
        }else{
            return self.model.season.count + 1;
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
            Biao_TopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Top_cell];
            return cell;
        }else{
            if (indexPath.row == 0) {
                Biao_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Biao_cell];
                cell.time_Lab.hidden = YES;
                cell.bi_Lab.hidden = YES;
                cell.team_Lab.hidden = YES;

                UIView *dowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
                dowView.backgroundColor = [UIColor getColorWithR:225 G:188 B:184 A:1];
                [cell addSubview:dowView];

                UILabel *CJ_lab = [[UILabel alloc] initWithFrame:CGRectMake(50,12,50,20)];
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
                        cell = [[Biao_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Biao_cell];
                        DJ_PlayerModel_Ten_Cell *ten_Model = [self.model.ten objectAtIndex:indexPath.row - 1];
                        cell.time_Lab.text = ten_Model.time;
                        cell.bi_Lab.text = ten_Model.score;
                        cell.team_Lab.text = ten_Model.opponents;
                    }
                    return cell;
                }else if ([TOP isEqualToString:@"2"]){
                    NSString *CellIdenti = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
                    Biao_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdenti];
                    if (cell == nil) {
                        cell = [[Biao_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Biao_cell];
                        DJ_PlayerModel_All_Cell *all_Model = [self.model.all objectAtIndex:indexPath.row - 1];
                        cell.time_Lab.text = all_Model.time;
                        cell.bi_Lab.text = all_Model.score;
                        cell.team_Lab.text = all_Model.opponents;
                    }
                    return cell;
                }else{
                    NSString *CellIdenti = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
                    Biao_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdenti];
                    if (cell == nil) {
                        cell = [[Biao_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Biao_cell];
                        DJ_PlayerModel_Season_Cell *sea_Model = [self.model.season objectAtIndex:indexPath.row - 1];
                        cell.time_Lab.text = sea_Model.time;
                        cell.bi_Lab.text = sea_Model.score;
                        cell.team_Lab.text = sea_Model.opponents;
                    }
                    return cell;
                }
            }
        }
    }else{      ///---------------右边
        if (indexPath.section == 0) {
            ShuJtop_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Top_SJcell];
            return cell;
        }else{
            if (indexPath.row == 0) {
                ShuJ_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Biao_SJcell];
                 cell.lable1.textColor = [UIColor getColorWithTheme];
                 cell.lable2.textColor = [UIColor getColorWithTheme];
                 cell.lable3.textColor = [UIColor getColorWithTheme];
                 cell.lable4.textColor = [UIColor getColorWithTheme];
                 cell.lable5.textColor = [UIColor getColorWithTheme];
                 cell.lable6.textColor = [UIColor getColorWithTheme];
                 cell.lable7.textColor = [UIColor getColorWithTheme];
                
                 cell.lable1.backgroundColor = [UIColor getColorWithR:225 G:188 B:184 A:1];
                 cell.lable2.backgroundColor = [UIColor getColorWithR:225 G:188 B:184 A:1];
                 cell.lable3.backgroundColor = [UIColor getColorWithR:225 G:188 B:184 A:1];
                 cell.lable4.backgroundColor = [UIColor getColorWithR:225 G:188 B:184 A:1];
                 cell.lable5.backgroundColor = [UIColor getColorWithR:225 G:188 B:184 A:1];
                 cell.lable6.backgroundColor = [UIColor getColorWithR:225 G:188 B:184 A:1];
                 cell.lable7.backgroundColor = [UIColor getColorWithR:225 G:188 B:184 A:1];

                if ([TOP isEqualToString:@"1"]) {
                    if ([self.model.ten_avg objectForKey:@"times"]) {
                        cell.lable1.text = [NSString stringWithFormat:@"%@",[self.model.ten_avg objectForKey:@"times"]];
                    }else{
                        cell.lable1.text = @"0";
                    }
                    cell.lable2.text = [NSString stringWithFormat:@"%@",[self.model.ten_avg objectForKey:@"scores"]];
                    cell.lable3.text = [NSString stringWithFormat:@"%@",[self.model.ten_avg objectForKey:@"kill"]];
                    cell.lable4.text = [NSString stringWithFormat:@"%@",[self.model.ten_avg objectForKey:@"assists"]];
                    cell.lable5.text = [NSString stringWithFormat:@"%@",[self.model.ten_avg objectForKey:@"death"]];
                    cell.lable6.text = [NSString stringWithFormat:@"%@",[self.model.ten_avg objectForKey:@"jungle"]];
                    cell.lable7.text = [NSString stringWithFormat:@"%@",[self.model.ten_avg objectForKey:@"ten_kill"]];
                }else if ([TOP isEqualToString:@"2"]){
                    if ([self.model.all_avg objectForKey:@"times"]) {
                        cell.lable1.text = [NSString stringWithFormat:@"%@",[self.model.all_avg objectForKey:@"times"]];
                    }else{
                        cell.lable1.text = @"0";
                    }
                    cell.lable2.text = [NSString stringWithFormat:@"%@",[self.model.all_avg objectForKey:@"scores"]];
                    cell.lable3.text = [NSString stringWithFormat:@"%@",[self.model.all_avg objectForKey:@"kill"]];
                    cell.lable4.text = [NSString stringWithFormat:@"%@",[self.model.all_avg objectForKey:@"assists"]];
                    cell.lable5.text = [NSString stringWithFormat:@"%@",[self.model.all_avg objectForKey:@"death"]];
                    cell.lable6.text = [NSString stringWithFormat:@"%@",[self.model.all_avg objectForKey:@"jungle"]];
                    cell.lable7.text = [NSString stringWithFormat:@"%@",[self.model.all_avg objectForKey:@"ten_kill"]];
                }else{
                    if ([self.model.season_avg objectForKey:@"times"]) {
                        cell.lable1.text = [NSString stringWithFormat:@"%@",[self.model.season_avg objectForKey:@"times"]];
                    }else{
                        cell.lable1.text = @"0";
                    }
                    cell.lable2.text = [NSString stringWithFormat:@"%@",[self.model.season_avg objectForKey:@"scores"]];
                    cell.lable3.text = [NSString stringWithFormat:@"%@",[self.model.season_avg objectForKey:@"kill"]];
                    cell.lable4.text = [NSString stringWithFormat:@"%@",[self.model.season_avg objectForKey:@"assists"]];
                    cell.lable5.text = [NSString stringWithFormat:@"%@",[self.model.season_avg objectForKey:@"death"]];
                    cell.lable6.text = [NSString stringWithFormat:@"%@",[self.model.season_avg objectForKey:@"jungle"]];
                    cell.lable7.text = [NSString stringWithFormat:@"%@",[self.model.season_avg objectForKey:@"ten_kill"]];
                }
               
                return cell;
            }else{
                if ([TOP isEqualToString:@"1"]) {
                    NSString *cellIdent = [NSString stringWithFormat:@"cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
                    ShuJ_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
                    if (cell == nil) {
                        cell = [[ShuJ_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Biao_SJcell];
                        DJ_PlayerModel_Ten_Cell *ten_Model = [self.model.ten objectAtIndex:indexPath.row - 1];
                        cell.lable1.text = ten_Model.times;
                        cell.lable2.text = [NSString stringWithFormat:@"%0.1f",ten_Model.scores];
                        cell.lable3.text = [NSString stringWithFormat:@"%0.1f",ten_Model.kill];
                        cell.lable4.text = [NSString stringWithFormat:@"%0.1f",ten_Model.assists];
                        cell.lable5.text = [NSString stringWithFormat:@"%0.1f",ten_Model.death];
                        cell.lable6.text = [NSString stringWithFormat:@"%0.1f",ten_Model.jungle];
                        cell.lable7.text = [NSString stringWithFormat:@"%0.1f",ten_Model.ten_kill];
                    }
                    return cell;
                }else if ([TOP isEqualToString:@"2"]){
                    NSString *cellIdent = [NSString stringWithFormat:@"cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
                    ShuJ_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
                    if (cell == nil) {
                        cell = [[ShuJ_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Biao_SJcell];
                        DJ_PlayerModel_All_Cell *all_Model = [self.model.all objectAtIndex:indexPath.row - 1];
                        cell.lable1.text = all_Model.times;
                        cell.lable2.text = [NSString stringWithFormat:@"%0.1f",all_Model.scores];
                        cell.lable3.text = [NSString stringWithFormat:@"%0.1f",all_Model.kill];
                        cell.lable4.text = [NSString stringWithFormat:@"%0.1f",all_Model.assists];
                        cell.lable5.text = [NSString stringWithFormat:@"%0.1f",all_Model.death];
                        cell.lable6.text = [NSString stringWithFormat:@"%0.1f",all_Model.jungle];
                        cell.lable7.text = [NSString stringWithFormat:@"%0.1f",all_Model.ten_kill];
                    }
                    return cell;
                }else{
                    NSString *cellIdent = [NSString stringWithFormat:@"cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
                    ShuJ_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
                    if (cell == nil) {
                        cell = [[ShuJ_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Biao_SJcell];
                        DJ_PlayerModel_Season_Cell *sea_Model = [self.model.season objectAtIndex:indexPath.row - 1];
                        cell.lable1.text = sea_Model.times;
                        cell.lable2.text = [NSString stringWithFormat:@"%0.1f",sea_Model.scores];
                        cell.lable3.text = [NSString stringWithFormat:@"%0.1f",sea_Model.kill];
                        cell.lable4.text = [NSString stringWithFormat:@"%0.1f",sea_Model.assists];
                        cell.lable5.text = [NSString stringWithFormat:@"%0.1f",sea_Model.death];
                        cell.lable6.text = [NSString stringWithFormat:@"%0.1f",sea_Model.jungle];
                        cell.lable7.text = [NSString stringWithFormat:@"%0.1f",sea_Model.ten_kill];
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

- (IBAction)jinS_BtnClick:(UIButton *)sender {
    self.jinS_Btn.selected = YES;
    self.jinS_Btn.backgroundColor = [UIColor getColorWithTheme];
    self.all_Btn.selected = NO;
    self.all_Btn.backgroundColor = [UIColor clearColor];
    self.benS_Btn.selected = NO;
    self.benS_Btn.backgroundColor = [UIColor clearColor];
    TOP = @"1";
    [self.tableView reloadData];
    [self.tableView2 reloadData];

}


- (IBAction)all_BtnClick:(UIButton *)sender {
    self.all_Btn.selected = YES;
    self.all_Btn.backgroundColor = [UIColor getColorWithTheme];
    self.jinS_Btn.selected = NO;
    self.jinS_Btn.backgroundColor = [UIColor clearColor];
    self.benS_Btn.selected = NO;
    self.benS_Btn.backgroundColor = [UIColor clearColor];
    TOP = @"2";
    [self.tableView reloadData];
    [self.tableView2 reloadData];
}


- (IBAction)benS_BtnClick:(UIButton *)sender {
    self.benS_Btn.selected = YES;
    self.benS_Btn.backgroundColor = [UIColor getColorWithTheme];
    self.jinS_Btn.selected = NO;
    self.jinS_Btn.backgroundColor = [UIColor clearColor];
    self.all_Btn.selected = NO;
    self.all_Btn.backgroundColor = [UIColor clearColor];
    TOP = @"3";
    [self.tableView reloadData];
    [self.tableView2 reloadData];
}




@end
