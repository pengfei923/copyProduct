//
//  SettingViewController.m
//  AFM
//
//  Created by admin on 2017/9/1.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "SettingViewController.h"
#import "WENClearCache.h"
#import "AboutViewController.h"
#import "SuggestViewController.h"

@interface SettingViewController ()<UITableViewDelegate , UITableViewDataSource>{
    
}
@property (nonatomic , strong) UITableView *tableView;          //列表视图
@property (nonatomic, strong) NSMutableArray *setingArr;


@end

@implementation SettingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
    [self initData];
}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"设置";
    
}


//初始化界面
- (void)initView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.mainWidth, self.mainHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate =  self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
}

//初始化数据
- (void)initData {
    
    self.setingArr = [[NSMutableArray alloc]init];
    
//    SetingModel *model1 = [[SetingModel alloc]init];
//    model1.celltitle = @"推送消息";
//    [self.setingArr addObject:model1];
//
//    SetingModel *model2 = [[SetingModel alloc]init];
//    model2.celltitle = @"开启2G/3G/4G网络提醒";
//    [self.setingArr addObject:model2];
    
    NSString *fileSize = [WENClearCache getCacheSizeWithFilePath:filePathS];
    float fileSizeF = [fileSize floatValue];
    SetingModel *model3 = [[SetingModel alloc]init];
    model3.celltitle = @"清除缓存";
    model3.celldetail = [NSString stringWithFormat:@"%0.2fKB",fileSizeF];
    [self.setingArr addObject:model3];

    SetingModel *model4 = [[SetingModel alloc]init];
    model4.celltitle = @"意见反馈";
    [self.setingArr addObject:model4];

    
    SetingModel *model5 = [[SetingModel alloc]init];
    model5.celltitle = @"关于我们";
    [self.setingArr addObject:model5];



}

#pragma mark - 列表代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.setingArr.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndef = @"cellindef";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndef];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndef];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    SetingModel *model = [self.setingArr objectAtIndex:indexPath.row];
    cell.textLabel.text = model.celltitle;
    cell.detailTextLabel.text = model.celldetail;

//    if (indexPath.row == 0) {
//        //add switch
//        UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
//        [switchview addTarget:self action:@selector(TSSwitch:) forControlEvents:UIControlEventValueChanged];
//
//        cell.accessoryView = switchview;
//
//
//    }else if (indexPath.row == 1){
//        //add switch
//        UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
//        [switchview addTarget:self action:@selector(updateSwitch:) forControlEvents:UIControlEventValueChanged];
//
//        cell.accessoryView = switchview;
//
//
//    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

//    }
    
    return cell;

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {          // 清除缓存
        BOOL isSuccess = [WENClearCache clearCacheWithFilePath:filePathS];
        if (isSuccess) {
            SetingModel *model = [self.setingArr lastObject];
            model.celldetail = @"0.00KB";
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [AppDelegate notificationRequestSuccessWithStatus:@"清除成功"];
        }
        
    }else if (indexPath.row == 1) {      //意见反馈
        SuggestViewController *SuggestVC = [[SuggestViewController alloc] init];
        [SuggestVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:SuggestVC animated:YES];
        
    }else if (indexPath.row == 2) {      //关于我们
        AboutViewController *AboutVC = [[AboutViewController alloc] init];
        [AboutVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:AboutVC animated:YES];
        
    }else {
    }
//    if (indexPath.row == 2) {          // 清除缓存
//        BOOL isSuccess = [WENClearCache clearCacheWithFilePath:filePathS];
//        if (isSuccess) {
//            SetingModel *model = [self.setingArr lastObject];
//            model.celldetail = @"0.00KB";
//            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//            [AppDelegate notificationRequestSuccessWithStatus:@"清除成功"];
//        }
//
//    }else if (indexPath.row == 3) {      //意见反馈
//        SuggestViewController *SuggestVC = [[SuggestViewController alloc] init];
//        [SuggestVC setHidesBottomBarWhenPushed:YES];
//        [self.navigationController pushViewController:SuggestVC animated:YES];
//
//    }else if (indexPath.row == 4) {      //关于我们
//        AboutViewController *AboutVC = [[AboutViewController alloc] init];
//        [AboutVC setHidesBottomBarWhenPushed:YES];
//        [self.navigationController pushViewController:AboutVC animated:YES];
//
//    }else {
//    }
    
}


//推送消息
- (void)TSSwitch:(id)sender{
    
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {//开

    
    }else {

    
    }
    
}

//3G网络
- (void)updateSwitch:(id)sender{
    
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {//开
        
        
    }else {
        
        
    }
    
}



@end

@implementation SetingModel
@end
