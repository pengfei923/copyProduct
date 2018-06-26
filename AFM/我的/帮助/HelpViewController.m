//
//  HelpViewController.m
//  AFM
//
//  Created by admin on 2017/9/1.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "HelpViewController.h"
#import "HelpTableViewCell.h"
#import "Help1TableViewCell.h"

@interface HelpViewController ()<UITableViewDelegate , UITableViewDataSource>{
    
}
@property (nonatomic , strong) UITableView *tableView;          //列表视图


@end

@implementation HelpViewController
NSString *help_cellid = @"HelpTableViewCell";
NSString *help1_cellid = @"Help1TableViewCell";



- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
    [self initData];
}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"帮助";
    
}


//初始化界面
- (void)initView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView registerClass:[HelpTableViewCell class] forCellReuseIdentifier:help_cellid];
    [self.tableView registerClass:[Help1TableViewCell class] forCellReuseIdentifier:help1_cellid];
    [self.view addSubview:self.tableView];
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;

}

//初始化数据
- (void)initData {
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 195;
    }else if (indexPath.row == 1){
        return 145;
    }else if (indexPath.row == 2){
        return 90;
    }else if (indexPath.row == 3){
        return 570;
    }else if (indexPath.row == 4){
        return 70;
    }else if (indexPath.row == 5){
        return 70;
    }else if (indexPath.row == 6){
        return 90;
    }else if (indexPath.row == 7){
        return 60;
    }else{
        return 80;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        Help1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:help1_cellid];
        cell.title_Lab.text = @"什么是爱伐木？";
        cell.info_Lab.text = @"爱伐木是为喜爱体育和电竞赛事玩家提供的赛事互动平台，以真实NBA比赛数据和电竞比赛数据为基础，用户所选选手积分总和进行比拼的范特西体育竞技活动。  \n\n爱伐木的竞技玩法方便玩家了解选手、队伍和赛事本身，并不具有赌博性质，任何将爱伐木竞技玩法作为赌博性质的行为都将受到爱伐木的封号处理，请用户悉知。 \n \n此规则适用于爱伐木竞技玩法的所有项目，用户有责任确保您获知所有的规则和条款，我们保留随时修改条款的权利，并且会将修改的内容公布在APP内。";
        
        return cell;
    }else if (indexPath.row == 1){
        HelpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:help_cellid];
        cell.title_Lab.text = @"门票获取有哪些途径？";
        
        return cell;
    }else if (indexPath.row == 2){
        Help1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:help1_cellid];
        cell.title_Lab.text = @"有哪些竞猜房间类型？";
        cell.info_Lab.text = @"1. 锦标房：进入获奖区的用户，排名与奖励成正比；\n2. 均分房：进入获奖区的用户平分所有奖励； \n3. 免费房：无需门票，没有任何奖励产出的房间。";
        
        return cell;
    }else if (indexPath.row == 3){
        Help1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:help1_cellid];
        cell.title_Lab.text = @"房间同分处理规则？";
        cell.info_Lab.text = @"选手积分是指一个选手现实比赛表现的数据量化值。\nNBA球员积分规则：\n得分⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯+1     \n三分⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯+0.5     \n篮板⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯+1.2    \n助攻⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯+1.5    \n抢断⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯+2    \n封盖⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯+2    \n失误⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯-1    \n    \n电竞选手积分规则:     \n击杀⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯+3    \n助攻⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯+2    \n死亡⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯-1    \n补刀⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯+0.02    \n击杀/助攻10+⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯+2     \n \n电竞团队积分规则：     \n拆塔⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯+0.5     \n一血⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯+0.5     \n胜利⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯+0.5     \n小龙（LOL）⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯+0.5     \n大龙（LOL）⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯+0.5     \n肉山（DOTA2）   ⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯+0.5     \n30分钟内胜⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯+0.5     \n    \n电竞比赛胜利积分加成:     \n如果选手或战队在未打满全部比赛情况下取得比赛胜利的话，选手和团队将分别获得积分加成     \n选手加成⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯ +20积分/场     \n团队加成⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯ +15积分/场    \n如：    \nBO3比赛中2:0取胜，剩1场未打，选手+20积分，团队+15积分     \nBO3比赛中2:1取胜，剩0场未打，不加分     \nBO5比赛中3:0取胜，剩2场未打，选手+40积分，团队+30积分     \nBO5比赛中3:2取胜，剩0场未打，不加分    \n以此类推，选手必须打过至少一场比赛才可获得积分加成     \n";
        
        return cell;
    }else if (indexPath.row == 4){
        Help1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:help1_cellid];
        cell.title_Lab.text = @"什么是选手平均分？";
        cell.info_Lab.text = @"选手平均分是指选手在本赛季的平均积分，是对此选手当前赛季过往表现的量化展示，供用户参考。";
        
        return cell;
    }else if (indexPath.row == 5){
        Help1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:help1_cellid];
        cell.title_Lab.text = @"房间是否允许多次参与？";
        cell.info_Lab.text = @"大部分房间都允许玩家多次参与，用户可以使用相同或不同阵容参与同一个房间，增加自己的获奖概率。";
        
        return cell;
    }else if (indexPath.row == 6){
        Help1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:help1_cellid];
        cell.title_Lab.text = @"提交阵容后是否可以更换？";
        cell.info_Lab.text = @"房间参与时间截止前，用户可以任意更换或撤销自己参与的阵容；一旦现实中的比赛开启，已开赛的球员不能更换，但未开赛赛事的球员，仍然可以更换。";
        
        return cell;
    }else if (indexPath.row == 7){
        Help1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:help1_cellid];
        cell.title_Lab.text = @"房间中赢取的木头可以干什么？";
        cell.info_Lab.text = @"木头可以在商城中兑换虚拟物品或实物。";
        
        return cell;
    }else{
        Help1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:help1_cellid];
        cell.title_Lab.text = @"实物商品怎么兑换？";
        cell.info_Lab.text = @"用户需要在个人中心填写收货地址，完善个人信息。在兑换时选择收货地址，并根据页面提示联系客服。";
        
        return cell;
    }
    
}





@end
