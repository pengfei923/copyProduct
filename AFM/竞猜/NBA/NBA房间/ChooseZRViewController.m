//
//  ChooseZRViewController.m
//  AFM
//
//  Created by admin on 2017/9/13.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "ChooseZRViewController.h"
#import "SuccessZRViewController.h"
#import "NBA_ChooPlayerViewController.h"
#import "SaveZRViewController.h"
#import "TJZR_BackView.h"

@interface ChooseZRViewController (){
    NSTimeInterval TIME;         //时间间隔
}

@property (nonatomic , strong) TJZR_BackView *backRView;          //提交阵容
@property (nonatomic , strong) NSMutableArray *DJ_listData;       //所有选手
@property (nonatomic , strong) NSDictionary  *YJTJ_Dic;           //一键推荐
@property (nonatomic , strong) NSTimer *listTimer;               //定时器
@property (nonatomic , strong) NSMutableArray *PJ_arr;            //平均分总和数组
@property (nonatomic , strong) NSMutableArray *GZ_arr;            //工资总和数组



@property (nonatomic , strong) NBAModel1Cell *Model1;            //
@property (nonatomic , strong) NBAModel2Cell *Model2;            //
@property (nonatomic , strong) NBAModel3Cell *Model3;            //
@property (nonatomic , strong) NBAModel4Cell *Model4;            //
@property (nonatomic , strong) NBAModel5Cell *Model5;            //
@property (nonatomic , strong) NBAModel6Cell *Model6;            //
@property (nonatomic , strong) NBAModel7Cell *Model7;            //
@property (nonatomic , strong) NBAModel8Cell *Model8;            //

@end

@implementation ChooseZRViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startTimer];
    if ([self.type_num isEqualToString:@"8"]) {    //8人
        self.down3View.hidden = NO;
    }else{
        self.down3View.hidden = YES;
    }
    [self initCenterView];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
    [self initData];
    [self initAAAAAA];
}

- (void)initCenterView{
    if ([self.type_num isEqualToString:@"5"]) {    //5人间
     self.Center_Lay.constant = 28;
    }else{
        self.Center_Lay.constant = 10;
    }
}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"房间布阵";
    
}

//初始化界面
- (void)initView {
    [self initZhongView];
    self.Price_Lab.text = [NSString stringWithFormat:@"$%@",self.allGZ];

    self.D_numLab.layer.masksToBounds = YES;
    self.D_numLab.layer.cornerRadius = 6.0;
    if ( self.num.length == 0) {
        self.D_numLab.text = @"0";
        self.D_numLab.hidden = YES;
    }else{
        self.D_numLab.text = self.num;
        self.D_numLab.hidden = NO;
    }

}

//获取房间的所有参赛的球员信息
- (void)initData {
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=room&a=roomplayer&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                @"id":self.Id,
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
            NBA_PlayerListModel *listModel = [NBA_PlayerListModel yy_modelWithDictionary:dic];
            self.DJ_listData = [[NSMutableArray alloc]initWithArray:listModel.data];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}


- (void) initAAAAAA{
    self.PJ_arr = [[NSMutableArray alloc] init];
    self.GZ_arr = [[NSMutableArray alloc] init];

    
    if (self.Model1) {
        if (self.Model1.Id.length >= 1) {
            [self.PJ_arr addObject:[NSNumber numberWithDouble:_Model1.average]];
            [self.GZ_arr addObject:_Model1.salary];
        }
       
    }
    if (self.Model2) {
        if (self.Model2.Id.length >= 1) {
            [self.PJ_arr addObject:[NSNumber numberWithDouble:_Model2.average]];
            [self.GZ_arr addObject:_Model2.salary];
        }
    }
    if (self.Model3) {
        if (self.Model3.Id.length >= 1) {
            [self.PJ_arr addObject:[NSNumber numberWithDouble:_Model3.average]];
            [self.GZ_arr addObject:_Model3.salary];
        }
    }
    if (self.Model4) {
        if (self.Model4.Id.length >= 1) {
            [self.PJ_arr addObject:[NSNumber numberWithDouble:_Model4.average]];
            [self.GZ_arr addObject:_Model4.salary];
        }
    }
    if (self.Model5) {
        if (self.Model5.Id.length >= 1) {
            [self.PJ_arr addObject:[NSNumber numberWithDouble:_Model5.average]];
            [self.GZ_arr addObject:_Model5.salary];
        }
    }
    if (self.Model6) {
        if (self.Model6.Id.length >= 1) {
            [self.PJ_arr addObject:[NSNumber numberWithDouble:_Model6.average]];
            [self.GZ_arr addObject:_Model6.salary];
        }
    }
    if (self.Model7) {
        if (self.Model7.Id.length >= 1) {
            [self.PJ_arr addObject:[NSNumber numberWithDouble:_Model7.average]];
            [self.GZ_arr addObject:_Model7.salary];
        }
    }
    if (self.Model8) {
        if (self.Model8.Id.length >= 1) {
            [self.PJ_arr addObject:[NSNumber numberWithDouble:_Model8.average]];
            [self.GZ_arr addObject:_Model8.salary];
        }
    }

    
    
    
    //平均分
    NSNumber *sumPJ = [self.PJ_arr valueForKeyPath:@"@sum.floatValue"];
    self.PJLab.text = [NSString stringWithFormat:@"%@",sumPJ];
    //工资
    NSNumber *sumGZ = [self.GZ_arr valueForKeyPath:@"@sum.floatValue"];
    self.Price_Lab.text = [NSString stringWithFormat:@"$%.0f",[self.allGZ floatValue] - [sumGZ floatValue]];


}



#pragma 按钮点击事件
//---------------------------------------------

- (IBAction)TTbutton1Click:(UIButton *)sender {
    NBA_ChooPlayerViewController *chooseVC = [[NBA_ChooPlayerViewController alloc] init];
    chooseVC.returnNbaModel1 = ^(NBAModel1Cell *model1, NBAModel2Cell *model2, NBAModel3Cell *model3, NBAModel4Cell *model4, NBAModel5Cell *model5, NBAModel6Cell *model6, NBAModel7Cell *model7, NBAModel8Cell *model8) {
        
        [self initAllModel:model1 :model2 :model3 :model4 :model5 :model6 :model7 :model8];
    };
    
    chooseVC.model1 = self.Model1;
    chooseVC.model2 = self.Model2;
    chooseVC.model3 = self.Model3;
    chooseVC.model4 = self.Model4;
    chooseVC.model5 = self.Model5;
    chooseVC.model6 = self.Model6;
    chooseVC.model7 = self.Model7;
    chooseVC.model8 = self.Model8;
    chooseVC.typeOder_num = @"5";
    chooseVC.roomId = self.Id;
    chooseVC.type_id = self.type_num;
    chooseVC.allGZ = self.allGZ;
    [chooseVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:chooseVC animated:YES];

}


- (IBAction)TTbutton2Click:(UIButton *)sender {
    NBA_ChooPlayerViewController *chooseVC = [[NBA_ChooPlayerViewController alloc] init];
    chooseVC.returnNbaModel1 = ^(NBAModel1Cell *model1, NBAModel2Cell *model2, NBAModel3Cell *model3, NBAModel4Cell *model4, NBAModel5Cell *model5, NBAModel6Cell *model6, NBAModel7Cell *model7, NBAModel8Cell *model8) {
        
        [self initAllModel:model1 :model2 :model3 :model4 :model5 :model6 :model7 :model8];
    };
    chooseVC.model1 = self.Model1;
    chooseVC.model2 = self.Model2;
    chooseVC.model3 = self.Model3;
    chooseVC.model4 = self.Model4;
    chooseVC.model5 = self.Model5;
    chooseVC.model6 = self.Model6;
    chooseVC.model7 = self.Model7;
    chooseVC.model8 = self.Model8;
    chooseVC.typeOder_num = @"3";
    chooseVC.roomId = self.Id;
    chooseVC.type_id = self.type_num;
    chooseVC.allGZ = self.allGZ;
    [chooseVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:chooseVC animated:YES];
}


- (IBAction)TTbutton3Click:(UIButton *)sender {
    NBA_ChooPlayerViewController *chooseVC = [[NBA_ChooPlayerViewController alloc] init];
    chooseVC.returnNbaModel1 = ^(NBAModel1Cell *model1, NBAModel2Cell *model2, NBAModel3Cell *model3, NBAModel4Cell *model4, NBAModel5Cell *model5, NBAModel6Cell *model6, NBAModel7Cell *model7, NBAModel8Cell *model8) {
        
        [self initAllModel:model1 :model2 :model3 :model4 :model5 :model6 :model7 :model8];
    };
    chooseVC.model1 = self.Model1;
    chooseVC.model2 = self.Model2;
    chooseVC.model3 = self.Model3;
    chooseVC.model4 = self.Model4;
    chooseVC.model5 = self.Model5;
    chooseVC.model6 = self.Model6;
    chooseVC.model7 = self.Model7;
    chooseVC.model8 = self.Model8;
    chooseVC.typeOder_num = @"4";
    chooseVC.roomId = self.Id;
    chooseVC.type_id = self.type_num;
    chooseVC.allGZ = self.allGZ;
    [chooseVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:chooseVC animated:YES];

}


- (IBAction)TTbutton4Click:(UIButton *)sender {
    NBA_ChooPlayerViewController *chooseVC = [[NBA_ChooPlayerViewController alloc] init];
    chooseVC.returnNbaModel1 = ^(NBAModel1Cell *model1, NBAModel2Cell *model2, NBAModel3Cell *model3, NBAModel4Cell *model4, NBAModel5Cell *model5, NBAModel6Cell *model6, NBAModel7Cell *model7, NBAModel8Cell *model8) {
        
        [self initAllModel:model1 :model2 :model3 :model4 :model5 :model6 :model7 :model8];
    };
    chooseVC.model1 = self.Model1;
    chooseVC.model2 = self.Model2;
    chooseVC.model3 = self.Model3;
    chooseVC.model4 = self.Model4;
    chooseVC.model5 = self.Model5;
    chooseVC.model6 = self.Model6;
    chooseVC.model7 = self.Model7;
    chooseVC.model8 = self.Model8;
    chooseVC.typeOder_num = @"2";
    chooseVC.roomId = self.Id;
    chooseVC.type_id = self.type_num;
    chooseVC.allGZ = self.allGZ;
    [chooseVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:chooseVC animated:YES];
}


- (IBAction)TTbutton5Click:(UIButton *)sender {
    NBA_ChooPlayerViewController *chooseVC = [[NBA_ChooPlayerViewController alloc] init];
    
    chooseVC.returnNbaModel1 = ^(NBAModel1Cell *model1, NBAModel2Cell *model2, NBAModel3Cell *model3, NBAModel4Cell *model4, NBAModel5Cell *model5, NBAModel6Cell *model6, NBAModel7Cell *model7, NBAModel8Cell *model8) {
        
        [self initAllModel:model1 :model2 :model3 :model4 :model5 :model6 :model7 :model8];

    };
    
    chooseVC.model1 = self.Model1;
    chooseVC.model2 = self.Model2;
    chooseVC.model3 = self.Model3;
    chooseVC.model4 = self.Model4;
    chooseVC.model5 = self.Model5;
    chooseVC.model6 = self.Model6;
    chooseVC.model7 = self.Model7;
    chooseVC.model8 = self.Model8;
    chooseVC.typeOder_num = @"1";
    chooseVC.roomId = self.Id;
    chooseVC.type_id = self.type_num;
    chooseVC.allGZ = self.allGZ;
    [chooseVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:chooseVC animated:YES];
}


- (IBAction)TTbutton6Click:(UIButton *)sender {
    NBA_ChooPlayerViewController *chooseVC = [[NBA_ChooPlayerViewController alloc] init];
    
    chooseVC.returnNbaModel1 = ^(NBAModel1Cell *model1, NBAModel2Cell *model2, NBAModel3Cell *model3, NBAModel4Cell *model4, NBAModel5Cell *model5, NBAModel6Cell *model6, NBAModel7Cell *model7, NBAModel8Cell *model8) {
        
        [self initAllModel:model1 :model2 :model3 :model4 :model5 :model6 :model7 :model8];
        
    };
    
    chooseVC.model1 = self.Model1;
    chooseVC.model2 = self.Model2;
    chooseVC.model3 = self.Model3;
    chooseVC.model4 = self.Model4;
    chooseVC.model5 = self.Model5;
    chooseVC.model6 = self.Model6;
    chooseVC.model7 = self.Model7;
    chooseVC.model8 = self.Model8;
    chooseVC.typeOder_num = @"6";
    chooseVC.roomId = self.Id;
    chooseVC.type_id = self.type_num;
    chooseVC.allGZ = self.allGZ;
    [chooseVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:chooseVC animated:YES];

}


- (IBAction)TTbutton7Click:(UIButton *)sender {
    NBA_ChooPlayerViewController *chooseVC = [[NBA_ChooPlayerViewController alloc] init];
    
    chooseVC.returnNbaModel1 = ^(NBAModel1Cell *model1, NBAModel2Cell *model2, NBAModel3Cell *model3, NBAModel4Cell *model4, NBAModel5Cell *model5, NBAModel6Cell *model6, NBAModel7Cell *model7, NBAModel8Cell *model8) {
        
        [self initAllModel:model1 :model2 :model3 :model4 :model5 :model6 :model7 :model8];
        
    };
    
    chooseVC.model1 = self.Model1;
    chooseVC.model2 = self.Model2;
    chooseVC.model3 = self.Model3;
    chooseVC.model4 = self.Model4;
    chooseVC.model5 = self.Model5;
    chooseVC.model6 = self.Model6;
    chooseVC.model7 = self.Model7;
    chooseVC.model8 = self.Model8;
    chooseVC.typeOder_num = @"7";
    chooseVC.roomId = self.Id;
    chooseVC.type_id = self.type_num;
    chooseVC.allGZ = self.allGZ;
    [chooseVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:chooseVC animated:YES];

}


- (IBAction)TTbutton8Click:(UIButton *)sender {
    NBA_ChooPlayerViewController *chooseVC = [[NBA_ChooPlayerViewController alloc] init];
    
    chooseVC.returnNbaModel1 = ^(NBAModel1Cell *model1, NBAModel2Cell *model2, NBAModel3Cell *model3, NBAModel4Cell *model4, NBAModel5Cell *model5, NBAModel6Cell *model6, NBAModel7Cell *model7, NBAModel8Cell *model8) {
        
        [self initAllModel:model1 :model2 :model3 :model4 :model5 :model6 :model7 :model8];
        
    };
    
    
    chooseVC.model1 = self.Model1;
    chooseVC.model2 = self.Model2;
    chooseVC.model3 = self.Model3;
    chooseVC.model4 = self.Model4;
    chooseVC.model5 = self.Model5;
    chooseVC.model6 = self.Model6;
    chooseVC.model7 = self.Model7;
    chooseVC.model8 = self.Model8;
    chooseVC.typeOder_num = @"8";
    chooseVC.roomId = self.Id;
    chooseVC.type_id = self.type_num;
    chooseVC.allGZ = self.allGZ;
    [chooseVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:chooseVC animated:YES];

}




- (void)initAllModel: (NBAModel1Cell *)model1 :(NBAModel2Cell *)model2 :(NBAModel3Cell *)model3 :(NBAModel4Cell *)model4 :(NBAModel5Cell *)model5 :(NBAModel6Cell *)model6 :(NBAModel7Cell *)model7 :(NBAModel8Cell *)model8{
    
    if (model1) {
        if (model1.Id.length >= 1) {
            self.Model1 = model1;
            [self.Player_Icon5 yy_setImageWithURL:[NSURL URLWithString:model1.img] placeholder:[UIImage imageNamed:@"player-photo"]];
            self.name5.text = model1.name;
            self.wei_Lab5.text = @"控卫";
            self.gz_Lab5.text = [NSString stringWithFormat:@"$%@",model1.salary];
            self.SEL_View5.hidden = NO;
            self.OView5.hidden = YES;
            self.S_View5.hidden = YES;  //时间
            self.C_View5.hidden = NO;   //位置/工资
            self.SliderView5.hidden = NO;//进度圈
            self.chart5.chartType = PNChartFormatTypeNone;
            self.chart5.current = [NSNumber numberWithDouble:model1.average];
            [self.chart5 strokeChart];

        }else{
            self.Model1 = [[NBAModel1Cell alloc] init];

            self.SEL_View5.hidden = YES;
            self.OView5.hidden = NO;
            self.S_View5.hidden = YES;  //时间
            self.C_View5.hidden = YES;   //位置/工资
            self.SliderView5.hidden = YES;//进度圈
            [self.Player_Icon5 setImage:[UIImage imageNamed:@"player-photo"]];

        }
        [self initAAAAAA];
        
    }
    
    if (model2) {
        if (model2.Id.length >= 1) {
            self.Model2 = model2;
            [self.Player_Icon4 yy_setImageWithURL:[NSURL URLWithString:model2.img] placeholder:[UIImage imageNamed:@"player-photo"]];
            self.name4.text = model2.name;
            self.wei_Lab4.text = @"分卫";
            self.gz_Lab4.text = [NSString stringWithFormat:@"$%@",model2.salary];
            self.SEL_View4.hidden = NO;
            self.OView4.hidden = YES;
            self.S_View4.hidden = YES;  //时间
            self.C_View4.hidden = NO;   //位置/工资
            self.SliderView4.hidden = NO;//进度圈
            self.chart4.chartType = PNChartFormatTypeNone;
            self.chart4.current = [NSNumber numberWithDouble:model2.average];
            [self.chart4 strokeChart];

        }else{
            self.Model2 = [[NBAModel2Cell alloc] init];

            self.SEL_View4.hidden = YES;
            self.OView4.hidden = NO;
            self.S_View4.hidden = YES;  //时间
            self.C_View4.hidden = YES;   //位置/工资
            self.SliderView4.hidden = YES;//进度圈
            [self.Player_Icon4 setImage:[UIImage imageNamed:@"player-photo"]];
 
        }
        [self initAAAAAA];

    }
    
    if (model3) {
        if (model3.Id.length >= 1) {
            self.Model3 = model3;
            [self.Player_Icon2 yy_setImageWithURL:[NSURL URLWithString:model3.img] placeholder:[UIImage imageNamed:@"player-photo"]];
            self.name2.text = model3.name;
            self.wei_Lab2.text = @"小前";
            self.gz_Lab2.text = [NSString stringWithFormat:@"$%@",model3.salary];
            self.SEL_View2.hidden = NO;
            self.OView2.hidden = YES;
            self.S_View2.hidden = YES;  //时间
            self.C_View2.hidden = NO;   //位置/工资
            self.SliderView2.hidden = NO;//进度圈
            self.chart2.chartType = PNChartFormatTypeNone;
            self.chart2.current = [NSNumber numberWithDouble:model3.average];
            [self.chart2 strokeChart];
            
        }else{
            self.Model3 = [[NBAModel3Cell alloc] init];

            self.SEL_View2.hidden = YES;
            self.OView2.hidden = NO;
            self.S_View2.hidden = YES;  //时间
            self.C_View2.hidden = YES;   //位置/工资
            self.SliderView2.hidden = YES;//进度圈
            [self.Player_Icon2 setImage:[UIImage imageNamed:@"player-photo"]];
            
        }
        [self initAAAAAA];


    }
    if (model4) {
        if (model4.Id.length >= 1) {
            self.Model4 = model4;
            [self.Player_Icon3 yy_setImageWithURL:[NSURL URLWithString:model4.img] placeholder:[UIImage imageNamed:@"player-photo"]];
            self.name3.text = model4.name;
            self.wei_Lab3.text = @"大前";
            self.gz_Lab3.text = [NSString stringWithFormat:@"$%@",model4.salary];
            self.SEL_View3.hidden = NO;
            self.OView3.hidden = YES;
            self.S_View3.hidden = YES;  //时间
            self.C_View3.hidden = NO;   //位置/工资
            self.SliderView3.hidden = NO;//进度圈
            self.chart3.chartType = PNChartFormatTypeNone;
            self.chart3.current = [NSNumber numberWithDouble:model4.average];
            [self.chart3 strokeChart];

            
        }else{
            self.Model4 = [[NBAModel4Cell alloc] init];

            self.SEL_View3.hidden = YES;
            self.OView3.hidden = NO;
            self.S_View3.hidden = YES;  //时间
            self.C_View3.hidden = YES;   //位置/工资
            self.SliderView3.hidden = YES;//进度圈
            [self.Player_Icon3 setImage:[UIImage imageNamed:@"player-photo"]];
 
        }
        [self initAAAAAA];

    }
    if (model5) {
        if (model5.Id.length >= 1) {
            self.Model5 = model5;
            [self.Player_Icon1 yy_setImageWithURL:[NSURL URLWithString:model5.img] placeholder:[UIImage imageNamed:@"player-photo"]];
            self.name1.text = model5.name;
            self.wei_Lab1.text = @"中锋";
            self.gz_Lab1.text = [NSString stringWithFormat:@"$%@",model5.salary];
            self.SEL_View1.hidden = NO;
            self.OView1.hidden = YES;
            self.S_View1.hidden = YES;  //时间
            self.C_View1.hidden = NO;   //位置/工资
            self.SliderView1.hidden = NO;//进度圈
            self.chart1.chartType = PNChartFormatTypeNone;
            self.chart1.current = [NSNumber numberWithDouble:model5.average];
            [self.chart1 strokeChart];

        }else{
            self.Model5 = [[NBAModel5Cell alloc] init];

            self.SEL_View1.hidden = YES;
            self.OView1.hidden = NO;
            self.S_View1.hidden = YES;  //时间
            self.C_View1.hidden = YES;   //位置/工资
            self.SliderView1.hidden = YES;//进度圈
            [self.Player_Icon1 setImage:[UIImage imageNamed:@"player-photo"]];
 
        }
        [self initAAAAAA];

    }
    if (model6) {
        if (model6.Id.length >= 1) {
            self.Model6 = model6;
            [self.Player_Icon6 yy_setImageWithURL:[NSURL URLWithString:model6.img] placeholder:[UIImage imageNamed:@"player-photo"]];
            self.name6.text = model6.name;
            self.wei_Lab6.text = @"后卫";
            self.gz_Lab6.text = [NSString stringWithFormat:@"$%@",model6.salary];
            self.SEL_View6.hidden = NO;
            self.OView6.hidden = YES;
            self.S_View6.hidden = YES;  //时间
            self.C_View6.hidden = NO;   //位置/工资
            self.SliderView6.hidden = NO;//进度圈
            self.chart6.chartType = PNChartFormatTypeNone;
            self.chart6.current = [NSNumber numberWithDouble:model6.average];
            [self.chart6 strokeChart];

        }else{
            self.Model6 = [[NBAModel6Cell alloc] init];

            self.SEL_View6.hidden = YES;
            self.OView6.hidden = NO;
            self.S_View6.hidden = YES;  //时间
            self.C_View6.hidden = YES;   //位置/工资
            self.SliderView6.hidden = YES;//进度圈
            [self.Player_Icon6 setImage:[UIImage imageNamed:@"player-photo"]];
        }
        [self initAAAAAA];

    }
    if (model7) {
        if (model7.Id.length >= 1) {
            self.Model7 = model7;
            [self.Player_Icon7 yy_setImageWithURL:[NSURL URLWithString:model7.img] placeholder:[UIImage imageNamed:@"player-photo"]];
            self.name7.text = model7.name;
            self.wei_Lab7.text = @"前锋";
            self.gz_Lab7.text = [NSString stringWithFormat:@"$%@",model7.salary];
            self.SEL_View7.hidden = NO;
            self.OView7.hidden = YES;
            self.S_View7.hidden = YES;  //时间
            self.C_View7.hidden = NO;   //位置/工资
            self.SliderView7.hidden = NO;//进度圈
            self.chart7.chartType = PNChartFormatTypeNone;
            self.chart7.current = [NSNumber numberWithDouble:model7.average];
            [self.chart7 strokeChart];

        }else{
            self.Model7 = [[NBAModel7Cell alloc] init];

            self.SEL_View7.hidden = YES;
            self.OView7.hidden = NO;
            self.S_View7.hidden = YES;  //时间
            self.C_View7.hidden = YES;   //位置/工资
            self.SliderView7.hidden = YES;//进度圈
            [self.Player_Icon7 setImage:[UIImage imageNamed:@"player-photo"]];
  
        }
        [self initAAAAAA];

    }
    if (model8) {
        if (model8.Id.length >= 1) {
            self.Model8 = model8;
            [self.Player_Icon8 yy_setImageWithURL:[NSURL URLWithString:model8.img] placeholder:[UIImage imageNamed:@"player-photo"]];
            self.name8.text = model8.name;
            self.wei_Lab8.text = @"任意";
            self.gz_Lab8.text = [NSString stringWithFormat:@"$%@",model8.salary];
            self.SEL_View8.hidden = NO;
            self.OView8.hidden = YES;
            self.S_View8.hidden = YES;  //时间
            self.C_View8.hidden = NO;   //位置/工资
            self.SliderView8.hidden = NO;//进度圈
            self.chart8.chartType = PNChartFormatTypeNone;
            self.chart8.current = [NSNumber numberWithDouble:model8.average];
            [self.chart8 strokeChart];
 
        }else{
            self.Model8 = [[NBAModel8Cell alloc] init];

            self.SEL_View8.hidden = YES;
            self.OView8.hidden = NO;
            self.S_View8.hidden = YES;  //时间
            self.C_View8.hidden = YES;   //位置/工资
            self.SliderView8.hidden = YES;//进度圈
            [self.Player_Icon8 setImage:[UIImage imageNamed:@"player-photo"]];
 
        }

        [self initAAAAAA];

    }
    
    
    
    
   
    
}




//---------------------底部按钮------------------------
#pragma mark - 提交阵容
- (IBAction)turnBtnClick:(UIButton *)sender {
    
    if ([self.type_num isEqualToString:@"5"]) {    //5人间
        if ((self.Model1.Id.length >= 1) && (self.Model2.Id.length >= 1) && (self.Model3.Id.length >= 1) && (self.Model4.Id.length >= 1) && (self.Model5.Id.length >= 1)){

            if ([[self.Price_Lab.text substringFromIndex:1] floatValue] >= 0) {//判断工资是否为负数
                self.backRView = [TJZR_BackView cloosePayView];
                self.backRView.frame = CGRectMake(0, 0, screen_Width, screen_Height-64);
                self.backRView.JCDJ_Lab.text = self.price;
                self.backRView.DQYY_Lab.text = self.appCache.loginViewModel.entrance_ticket;
                //剩余可投注次数
                self.SY_num = [NSString stringWithFormat:@"%.f",[self.allow_uguess_num floatValue] - [self.join_num floatValue]];
                self.backRView.maxNum_Lab.text = [NSString stringWithFormat:@"/ %.f",[self.allow_uguess_num floatValue] - [self.join_num floatValue]];
                self.backRView.FJ_Lab.text = [NSString stringWithFormat:@"%@/%@",self.now_guess_num,self.allow_guess_num];
                self.backRView.zong_lab.text = self.price;
                self.backRView.MaxNum = [self.SY_num intValue];
                self.backRView.controller = self;
                [self.view addSubview:self.backRView];
                typeof(self) _weakSelf = self;

                self.backRView.turnblock = ^(NSString *success, NSString *num) {
                    _weakSelf.guess_num = num;
                    if ([success isEqualToString:@"success"]) {
                        [_weakSelf initSuccessData];
                    }
                };
            }else{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"超出工资帽范围"message:@"请保证所有球员的工资总和在工资帽范围内" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"message:@"所有位置都已选队员，阵容才可以提交" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }

    }else{    //8人
        if ((self.Model1.Id.length >= 1) && (self.Model2.Id.length >= 1) && (self.Model3.Id.length >= 1) && (self.Model4.Id.length >= 1) && (self.Model5.Id.length >= 1) && (self.Model6.Id.length >= 1) && (self.Model7.Id.length >= 1) && (self.Model8.Id.length >= 1)) {

            if ([[self.Price_Lab.text substringFromIndex:1] floatValue] >= 0) {
                self.backRView = [TJZR_BackView cloosePayView];
                self.backRView.frame = CGRectMake(0, 0, screen_Width, screen_Height-64);
                self.backRView.JCDJ_Lab.text = self.price;
                self.backRView.DQYY_Lab.text = self.appCache.loginViewModel.entrance_ticket;
                //剩余可投注次数
                self.SY_num = [NSString stringWithFormat:@"%.f",[self.allow_uguess_num floatValue] - [self.join_num floatValue]];
                self.backRView.maxNum_Lab.text = [NSString stringWithFormat:@"/ %.f",[self.allow_uguess_num floatValue] - [self.join_num floatValue]];
                self.backRView.FJ_Lab.text = [NSString stringWithFormat:@"%@/%@",self.now_guess_num,self.allow_guess_num];
                self.backRView.zong_lab.text = self.price;
                self.backRView.MaxNum = [self.SY_num intValue];
                self.backRView.controller = self;
                [self.view addSubview:self.backRView];
                typeof(self) _weakSelf = self;

                self.backRView.turnblock = ^(NSString *success, NSString *num) {
                    _weakSelf.guess_num = num;
                    if ([success isEqualToString:@"success"]) {
                        [_weakSelf initSuccessData];
                    }
                };
            }else{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"超出工资帽范围"message:@"请保证所有球员的工资总和在工资帽范围内" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"message:@"所有位置都已选队员，阵容才可以提交" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
}


//提交阵容2
- (void)initSuccessData{
    //一键推荐
    if (_YJTJ_Dic) {
        self.IdDic = self.YJTJ_Dic;
    }else{
        //选完所有人
        if (_Model1 && _Model2 && _Model3 && _Model4 && _Model5 && _Model6 && _Model7 && _Model8) {
            self.IdDic = @{       @"1":self.Model1.Id,
                                @"2":self.Model2.Id,
                                @"3":self.Model3.Id,
                                @"4":self.Model4.Id,
                                @"5":self.Model5.Id,
                                @"6":self.Model6.Id,
                                @"7":self.Model7.Id,
                                @"8":self.Model8.Id
                        };
        }else{
            [AppDelegate notificationRequestInfoWithStatus:@"请选择完整阵容"];
        }
    }
    if (self.IdDic) {
        NSString *urlStr = @"http://api.aifamu.com/index.php?m=bet&a=guess&apptype=app&version=1";
        NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                    @"guess_num":self.guess_num,      //竞猜数量
                                    @"id":self.Id,         //房间id
                                    @"team_info":self.IdDic, //选手id数组
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
                //(跳到成功页面）
                SuccessZRViewController *successVC = [[SuccessZRViewController alloc] init];
                successVC.IdDic = self.YJTJ_Dic;
                successVC.playeData = self.DJ_listData;
                successVC.ID = self.Id;
                successVC.name = self.name;
                successVC.iconImg = self.iconImg;
                successVC.guess_num = self.guess_num;    //竞猜数量
                successVC.nbaT_id = self.type_num;       //nba 5、8人
                successVC.lol_nba_dota = @"nba";
                [successVC setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:successVC animated:YES];
            }else{
                [AppDelegate notificationRequestInfoWithStatus:[dic objectForKey:@"msg"]];

            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
}






#pragma mark - 已存阵容
- (IBAction)playerChooseBtnClick:(UIButton *)sender {
    SaveZRViewController *chooseVC = [[SaveZRViewController alloc] init];
    chooseVC.ID = self.Id;
    chooseVC.NUM = self.num;
    chooseVC.nba_lol_data = @"nba";
    chooseVC.numZRblock = ^(NSString *zr_NUM) {
        self.num = zr_NUM;
        self.D_numLab.text = zr_NUM;
        if (self.D_numLab.text.length == 0) {
            self.D_numLab.hidden = YES;
        }else{
            self.D_numLab.hidden = NO;
        }
    };
    chooseVC.chooseZRblock = ^(ZR_ModelDataCell *Model) {
        //顶部---平均分和工资
        self.PJLab.text = [NSString stringWithFormat:@"%0.1f",Model.lineup_score];
        self.Price_Lab.text = [NSString stringWithFormat:@"$%@",Model.salary_sum];
        
        //一键推荐数组
        self.YJTJ_Dic =  Model.lineup;

        //给每个View赋值
         for (NBA_PlayerListModelCell *model in self.DJ_listData) {
             if([model.Id isEqualToString:[Model.lineup objectForKey:@"1"]]){
                 [self.Player_Icon5 yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"player-photo"]];
                 self.name5.text = model.name;
                 self.wei_Lab5.text = @"控卫";
                 self.gz_Lab5.text = [NSString stringWithFormat:@"$%@",model.salary];
                 self.SEL_View5.hidden = NO;
                 self.OView5.hidden = YES;
                 self.S_View5.hidden = YES;  //时间
                 self.C_View5.hidden = NO;   //位置/工资
                 self.SliderView5.hidden = NO;//进度圈
                 self.chart5.chartType = PNChartFormatTypeNone;
                 self.chart5.current = [NSNumber numberWithDouble:model.average];
                 [self.chart5 strokeChart];
                 //-------------------------------
                 self.Model1 = [[NBAModel1Cell alloc ]init];
                 self.Model1.name = model.name;
                 self.Model1.salary = model.salary;
                 self.Model1.Id = model.Id;
                 self.Model1.average = model.average;
                 self.Model1.play_time = model.play_time;
                 self.Model1.team_id = model.team_id;
                 self.Model1.project_id = model.project_id;
                 self.Model1.img = model.img;
                 self.Model1.nationality = model.nationality;
                 self.Model1.position = model.position;
                 self.Model1.is_undetermined = model.is_undetermined;
                 self.Model1.is_illness = model.is_illness;
                 self.Model1.is_ban = model.is_ban;
                 self.Model1.is_out = model.is_out;
                 self.Model1.match_id = model.match_id;
                 self.Model1.state = model.state;
                 self.Model1.isDisplay = model.isDisplay;
                 self.Model1.isNO = model.isNO;
                 //-------------------------

             }else if([model.Id isEqualToString:[Model.lineup objectForKey:@"2"]]){
                 [self.Player_Icon4 yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"player-photo"]];
                 self.name4.text = model.name;
                 self.wei_Lab4.text = @"分卫";
                 self.gz_Lab4.text = [NSString stringWithFormat:@"$%@",model.salary];
                 self.SEL_View4.hidden = NO;
                 self.OView4.hidden = YES;
                 self.S_View4.hidden = YES;  //时间
                 self.C_View4.hidden = NO;   //位置/工资
                 self.SliderView4.hidden = NO;//进度圈
                 self.chart4.chartType = PNChartFormatTypeNone;
                 self.chart4.current = [NSNumber numberWithDouble:model.average];
                 [self.chart4 strokeChart];
                 //-------------------------------
                 self.Model2 = [[NBAModel2Cell alloc ]init];
                 self.Model2.name = model.name;
                 self.Model2.salary = model.salary;
                 self.Model2.Id = model.Id;
                 self.Model2.average = model.average;
                 self.Model2.play_time = model.play_time;
                 self.Model2.team_id = model.team_id;
                 self.Model2.project_id = model.project_id;
                 self.Model2.img = model.img;
                 self.Model2.nationality = model.nationality;
                 self.Model2.position = model.position;
                 self.Model2.is_undetermined = model.is_undetermined;
                 self.Model2.is_illness = model.is_illness;
                 self.Model2.is_ban = model.is_ban;
                 self.Model2.is_out = model.is_out;
                 self.Model2.match_id = model.match_id;
                 self.Model2.state = model.state;
                 self.Model2.isDisplay = model.isDisplay;
                 self.Model2.isNO = model.isNO;
                 //-------------------------
                 
             }else if([model.Id isEqualToString:[Model.lineup objectForKey:@"3"]]){
                 [self.Player_Icon2 yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"player-photo"]];
                 self.name2.text = model.name;
                 self.wei_Lab2.text = @"小前";
                 self.gz_Lab2.text = [NSString stringWithFormat:@"$%@",model.salary];
                 self.SEL_View2.hidden = NO;
                 self.OView2.hidden = YES;
                 self.S_View2.hidden = YES;  //时间
                 self.C_View2.hidden = NO;   //位置/工资
                 self.SliderView2.hidden = NO;//进度圈
                 self.chart2.chartType = PNChartFormatTypeNone;
                 self.chart2.current = [NSNumber numberWithDouble:model.average];
                 [self.chart2 strokeChart];
                 //-------------------------------
                 self.Model3 = [[NBAModel3Cell alloc ]init];
                 self.Model3.name = model.name;
                 self.Model3.salary = model.salary;
                 self.Model3.Id = model.Id;
                 self.Model3.average = model.average;
                 self.Model3.play_time = model.play_time;
                 self.Model3.team_id = model.team_id;
                 self.Model3.project_id = model.project_id;
                 self.Model3.img = model.img;
                 self.Model3.nationality = model.nationality;
                 self.Model3.position = model.position;
                 self.Model3.is_undetermined = model.is_undetermined;
                 self.Model3.is_illness = model.is_illness;
                 self.Model3.is_ban = model.is_ban;
                 self.Model3.is_out = model.is_out;
                 self.Model3.match_id = model.match_id;
                 self.Model3.state = model.state;
                 self.Model3.isDisplay = model.isDisplay;
                 self.Model3.isNO = model.isNO;
                 //-------------------------
                 
                 
             }else if([model.Id isEqualToString:[Model.lineup objectForKey:@"4"]]){
                 [self.Player_Icon3 yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"player-photo"]];
                 self.name3.text = model.name;
                 self.wei_Lab3.text = @"大前";
                 self.gz_Lab3.text = [NSString stringWithFormat:@"$%@",model.salary];
                 self.SEL_View3.hidden = NO;
                 self.OView3.hidden = YES;
                 self.S_View3.hidden = YES;  //时间
                 self.C_View3.hidden = NO;   //位置/工资
                 self.SliderView3.hidden = NO;//进度圈
                 self.chart3.chartType = PNChartFormatTypeNone;
                 self.chart3.current = [NSNumber numberWithDouble:model.average];
                 [self.chart3 strokeChart];
                 //-------------------------------
                 self.Model4 = [[NBAModel4Cell alloc ]init];
                 self.Model4.name = model.name;
                 self.Model4.salary = model.salary;
                 self.Model4.Id = model.Id;
                 self.Model4.average = model.average;
                 self.Model4.play_time = model.play_time;
                 self.Model4.team_id = model.team_id;
                 self.Model4.project_id = model.project_id;
                 self.Model4.img = model.img;
                 self.Model4.nationality = model.nationality;
                 self.Model4.position = model.position;
                 self.Model4.is_undetermined = model.is_undetermined;
                 self.Model4.is_illness = model.is_illness;
                 self.Model4.is_ban = model.is_ban;
                 self.Model4.is_out = model.is_out;
                 self.Model4.match_id = model.match_id;
                 self.Model4.state = model.state;
                 self.Model4.isDisplay = model.isDisplay;
                 self.Model4.isNO = model.isNO;
                 //-------------------------
                 
                 
             }else if([model.Id isEqualToString:[Model.lineup objectForKey:@"5"]]){
                 [self.Player_Icon1 yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"player-photo"]];
                 self.name1.text = model.name;
                 self.wei_Lab1.text = @"中锋";
                 self.gz_Lab1.text = [NSString stringWithFormat:@"$%@",model.salary];
                 self.SEL_View1.hidden = NO;
                 self.OView1.hidden = YES;
                 self.S_View1.hidden = YES;  //时间
                 self.C_View1.hidden = NO;   //位置/工资
                 self.SliderView1.hidden = NO;//进度圈
                 self.chart1.chartType = PNChartFormatTypeNone;
                 self.chart1.current = [NSNumber numberWithDouble:model.average];
                 [self.chart1 strokeChart];
                 //-------------------------------
                 self.Model5 = [[NBAModel5Cell alloc ]init];
                 self.Model5.name = model.name;
                 self.Model5.salary = model.salary;
                 self.Model5.Id = model.Id;
                 self.Model5.average = model.average;
                 self.Model5.play_time = model.play_time;
                 self.Model5.team_id = model.team_id;
                 self.Model5.project_id = model.project_id;
                 self.Model5.img = model.img;
                 self.Model5.nationality = model.nationality;
                 self.Model5.position = model.position;
                 self.Model5.is_undetermined = model.is_undetermined;
                 self.Model5.is_illness = model.is_illness;
                 self.Model5.is_ban = model.is_ban;
                 self.Model5.is_out = model.is_out;
                 self.Model5.match_id = model.match_id;
                 self.Model5.state = model.state;
                 self.Model5.isDisplay = model.isDisplay;
                 self.Model5.isNO = model.isNO;
                 //-------------------------
                 
             }else if([model.Id isEqualToString:[Model.lineup objectForKey:@"6"]]){
                 [self.Player_Icon6 yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"player-photo"]];
                 self.name6.text = model.name;
                 self.wei_Lab6.text = @"后卫";
                 self.gz_Lab6.text = [NSString stringWithFormat:@"$%@",model.salary];
                 self.SEL_View6.hidden = NO;
                 self.OView6.hidden = YES;
                 self.S_View6.hidden = YES;  //时间
                 self.C_View6.hidden = NO;   //位置/工资
                 self.SliderView6.hidden = NO;//进度圈
                 self.chart6.chartType = PNChartFormatTypeNone;
                 self.chart6.current = [NSNumber numberWithDouble:model.average];
                 [self.chart6 strokeChart];
                 //-------------------------------
                 self.Model6 = [[NBAModel6Cell alloc ]init];
                 self.Model6.name = model.name;
                 self.Model6.salary = model.salary;
                 self.Model6.Id = model.Id;
                 self.Model6.average = model.average;
                 self.Model6.play_time = model.play_time;
                 self.Model6.team_id = model.team_id;
                 self.Model6.project_id = model.project_id;
                 self.Model6.img = model.img;
                 self.Model6.nationality = model.nationality;
                 self.Model6.position = model.position;
                 self.Model6.is_undetermined = model.is_undetermined;
                 self.Model6.is_illness = model.is_illness;
                 self.Model6.is_ban = model.is_ban;
                 self.Model6.is_out = model.is_out;
                 self.Model6.match_id = model.match_id;
                 self.Model6.state = model.state;
                 self.Model6.isDisplay = model.isDisplay;
                 self.Model6.isNO = model.isNO;
                 //-------------------------
                 
                 
             }else if([model.Id isEqualToString:[Model.lineup objectForKey:@"7"]]){
                 [self.Player_Icon7 yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"player-photo"]];
                 self.name7.text = model.name;
                 self.wei_Lab7.text = @"前锋";
                 self.gz_Lab7.text = [NSString stringWithFormat:@"$%@",model.salary];
                 self.SEL_View7.hidden = NO;
                 self.OView7.hidden = YES;
                 self.S_View7.hidden = YES;  //时间
                 self.C_View7.hidden = NO;   //位置/工资
                 self.SliderView7.hidden = NO;//进度圈
                 self.chart7.chartType = PNChartFormatTypeNone;
                 self.chart7.current = [NSNumber numberWithDouble:model.average];
                 [self.chart7 strokeChart];
                 //-------------------------------
                 self.Model7 = [[NBAModel7Cell alloc ]init];
                 self.Model7.name = model.name;
                 self.Model7.salary = model.salary;
                 self.Model7.Id = model.Id;
                 self.Model7.average = model.average;
                 self.Model7.play_time = model.play_time;
                 self.Model7.team_id = model.team_id;
                 self.Model7.project_id = model.project_id;
                 self.Model7.img = model.img;
                 self.Model7.nationality = model.nationality;
                 self.Model7.position = model.position;
                 self.Model7.is_undetermined = model.is_undetermined;
                 self.Model7.is_illness = model.is_illness;
                 self.Model7.is_ban = model.is_ban;
                 self.Model7.is_out = model.is_out;
                 self.Model7.match_id = model.match_id;
                 self.Model7.state = model.state;
                 self.Model7.isDisplay = model.isDisplay;
                 self.Model7.isNO = model.isNO;
                 //-------------------------
                 
             }else if([model.Id isEqualToString:[Model.lineup objectForKey:@"8"]]){

                 [self.Player_Icon8 yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"player-photo"]];
                 self.name8.text = model.name;
                 self.wei_Lab8.text = @"任意";
                 self.gz_Lab8.text = [NSString stringWithFormat:@"$%@",model.salary];
                 self.SEL_View8.hidden = NO;
                 self.OView8.hidden = YES;
                 self.S_View8.hidden = YES;  //时间
                 self.C_View8.hidden = NO;   //位置/工资
                 self.SliderView8.hidden = NO;//进度圈
                 self.chart8.chartType = PNChartFormatTypeNone;
                 self.chart8.current = [NSNumber numberWithDouble:model.average];
                 [self.chart8 strokeChart];
                 //-------------------------------
                 self.Model8 = [[NBAModel8Cell alloc ]init];
                 self.Model8.name = model.name;
                 self.Model8.salary = model.salary;
                 self.Model8.Id = model.Id;
                 self.Model8.average = model.average;
                 self.Model8.play_time = model.play_time;
                 self.Model8.team_id = model.team_id;
                 self.Model8.project_id = model.project_id;
                 self.Model8.img = model.img;
                 self.Model8.nationality = model.nationality;
                 self.Model8.position = model.position;
                 self.Model8.is_undetermined = model.is_undetermined;
                 self.Model8.is_illness = model.is_illness;
                 self.Model8.is_ban = model.is_ban;
                 self.Model8.is_out = model.is_out;
                 self.Model8.match_id = model.match_id;
                 self.Model8.state = model.state;
                 self.Model8.isDisplay = model.isDisplay;
                 self.Model8.isNO = model.isNO;
                 //-------------------------
             }else {
 
             }
         }
        
        
    };
    [chooseVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:chooseVC animated:YES];
}

#pragma mark - 一键推荐
- (IBAction)YJTJBtnClick:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"message:@"确定使用推荐队员？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *urlStr = @"http://api.aifamu.com/index.php?m=bet&a=recommendlineup&apptype=app&version=1";
        NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                    @"id":self.Id };
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
                //顶部---平均分和工资
                NSDictionary *dictionary_EXdata = [dic objectForKey:@"extra_data"];
                self.PJLab.text = [NSString stringWithFormat:@"%0.1f",[[dictionary_EXdata objectForKey:@"score_sum"]floatValue]];
                self.Price_Lab.text = [NSString stringWithFormat:@"$%@",[dictionary_EXdata objectForKey:@"salary_sum"]];
                
                NSDictionary *dictionary_data = [dic objectForKey:@"data"];
                //一键推荐数组
                self.YJTJ_Dic = dictionary_data;
                
                for (NBA_PlayerListModelCell *model in self.DJ_listData) {
                    if([model.Id isEqualToString:[dictionary_data objectForKey:@"1"]]){
                        [self.Player_Icon5 yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"player-photo"]];
                        self.name5.text = model.name;
                        self.wei_Lab5.text = @"控卫";
                        self.gz_Lab5.text = [NSString stringWithFormat:@"$%@",model.salary];
                        self.SEL_View5.hidden = NO;
                        self.OView5.hidden = YES;
                        self.S_View5.hidden = YES;  //时间
                        self.C_View5.hidden = NO;   //位置/工资
                        self.SliderView5.hidden = NO;//进度圈
                        self.chart5.chartType = PNChartFormatTypeNone;
                        self.chart5.current = [NSNumber numberWithDouble:model.average];
                        [self.chart5 strokeChart];
                        //-------------------------------
                        self.Model1 = [[NBAModel1Cell alloc ]init];
                        self.Model1.name = model.name;
                        self.Model1.salary = model.salary;
                        self.Model1.Id = model.Id;
                        self.Model1.average = model.average;
                        self.Model1.play_time = model.play_time;
                        self.Model1.team_id = model.team_id;
                        self.Model1.project_id = model.project_id;
                        self.Model1.img = model.img;
                        self.Model1.nationality = model.nationality;
                        self.Model1.position = model.position;
                        self.Model1.is_undetermined = model.is_undetermined;
                        self.Model1.is_illness = model.is_illness;
                        self.Model1.is_ban = model.is_ban;
                        self.Model1.is_out = model.is_out;
                        self.Model1.match_id = model.match_id;
                        self.Model1.state = model.state;
                        self.Model1.isDisplay = model.isDisplay;
                        self.Model1.isNO = model.isNO;
                        //-------------------------
                        
                        
                    }else if([model.Id isEqualToString:[dictionary_data objectForKey:@"2"]]){
                        [self.Player_Icon4 yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"player-photo"]];
                        self.name4.text = model.name;
                        self.wei_Lab4.text = @"分卫";
                        self.gz_Lab4.text = [NSString stringWithFormat:@"$%@",model.salary];
                        self.SEL_View4.hidden = NO;
                        self.OView4.hidden = YES;
                        self.S_View4.hidden = YES;  //时间
                        self.C_View4.hidden = NO;   //位置/工资
                        self.SliderView4.hidden = NO;//进度圈
                        self.chart4.chartType = PNChartFormatTypeNone;
                        self.chart4.current = [NSNumber numberWithDouble:model.average];
                        [self.chart4 strokeChart];
                        //-------------------------------
                        self.Model2 = [[NBAModel2Cell alloc ]init];
                        self.Model2.name = model.name;
                        self.Model2.salary = model.salary;
                        self.Model2.Id = model.Id;
                        self.Model2.average = model.average;
                        self.Model2.play_time = model.play_time;
                        self.Model2.team_id = model.team_id;
                        self.Model2.project_id = model.project_id;
                        self.Model2.img = model.img;
                        self.Model2.nationality = model.nationality;
                        self.Model2.position = model.position;
                        self.Model2.is_undetermined = model.is_undetermined;
                        self.Model2.is_illness = model.is_illness;
                        self.Model2.is_ban = model.is_ban;
                        self.Model2.is_out = model.is_out;
                        self.Model2.match_id = model.match_id;
                        self.Model2.state = model.state;
                        self.Model2.isDisplay = model.isDisplay;
                        self.Model2.isNO = model.isNO;
                        //-------------------------

                    }else if([model.Id isEqualToString:[dictionary_data objectForKey:@"3"]]){
                        [self.Player_Icon2 yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"player-photo"]];
                        self.name2.text = model.name;
                        self.wei_Lab2.text = @"小前";
                        self.gz_Lab2.text = [NSString stringWithFormat:@"$%@",model.salary];
                        self.SEL_View2.hidden = NO;
                        self.OView2.hidden = YES;
                        self.S_View2.hidden = YES;  //时间
                        self.C_View2.hidden = NO;   //位置/工资
                        self.SliderView2.hidden = NO;//进度圈
                        self.chart2.chartType = PNChartFormatTypeNone;
                        self.chart2.current = [NSNumber numberWithDouble:model.average];
                        [self.chart2 strokeChart];
                        //-------------------------------
                        self.Model3 = [[NBAModel3Cell alloc ]init];
                        self.Model3.name = model.name;
                        self.Model3.salary = model.salary;
                        self.Model3.Id = model.Id;
                        self.Model3.average = model.average;
                        self.Model3.play_time = model.play_time;
                        self.Model3.team_id = model.team_id;
                        self.Model3.project_id = model.project_id;
                        self.Model3.img = model.img;
                        self.Model3.nationality = model.nationality;
                        self.Model3.position = model.position;
                        self.Model3.is_undetermined = model.is_undetermined;
                        self.Model3.is_illness = model.is_illness;
                        self.Model3.is_ban = model.is_ban;
                        self.Model3.is_out = model.is_out;
                        self.Model3.match_id = model.match_id;
                        self.Model3.state = model.state;
                        self.Model3.isDisplay = model.isDisplay;
                        self.Model3.isNO = model.isNO;
                        //-------------------------

                        
                    }else if([model.Id isEqualToString:[dictionary_data objectForKey:@"4"]]){
                        [self.Player_Icon3 yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"player-photo"]];
                        self.name3.text = model.name;
                        self.wei_Lab3.text = @"大前";
                        self.gz_Lab3.text = [NSString stringWithFormat:@"$%@",model.salary];
                        self.SEL_View3.hidden = NO;
                        self.OView3.hidden = YES;
                        self.S_View3.hidden = YES;  //时间
                        self.C_View3.hidden = NO;   //位置/工资
                        self.SliderView3.hidden = NO;//进度圈
                        self.chart3.chartType = PNChartFormatTypeNone;
                        self.chart3.current = [NSNumber numberWithDouble:model.average];
                        [self.chart3 strokeChart];
                        //-------------------------------
                        self.Model4 = [[NBAModel4Cell alloc ]init];
                        self.Model4.name = model.name;
                        self.Model4.salary = model.salary;
                        self.Model4.Id = model.Id;
                        self.Model4.average = model.average;
                        self.Model4.play_time = model.play_time;
                        self.Model4.team_id = model.team_id;
                        self.Model4.project_id = model.project_id;
                        self.Model4.img = model.img;
                        self.Model4.nationality = model.nationality;
                        self.Model4.position = model.position;
                        self.Model4.is_undetermined = model.is_undetermined;
                        self.Model4.is_illness = model.is_illness;
                        self.Model4.is_ban = model.is_ban;
                        self.Model4.is_out = model.is_out;
                        self.Model4.match_id = model.match_id;
                        self.Model4.state = model.state;
                        self.Model4.isDisplay = model.isDisplay;
                        self.Model4.isNO = model.isNO;
                        //-------------------------

                        
                    }else if([model.Id isEqualToString:[dictionary_data objectForKey:@"5"]]){
                        [self.Player_Icon1 yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"player-photo"]];
                        self.name1.text = model.name;
                        self.wei_Lab1.text = @"中锋";
                        self.gz_Lab1.text = [NSString stringWithFormat:@"$%@",model.salary];
                        self.SEL_View1.hidden = NO;
                        self.OView1.hidden = YES;
                        self.S_View1.hidden = YES;  //时间
                        self.C_View1.hidden = NO;   //位置/工资
                        self.SliderView1.hidden = NO;//进度圈
                        self.chart1.chartType = PNChartFormatTypeNone;
                        self.chart1.current = [NSNumber numberWithDouble:model.average];
                        [self.chart1 strokeChart];
                        //-------------------------------
                        self.Model5 = [[NBAModel5Cell alloc ]init];
                        self.Model5.name = model.name;
                        self.Model5.salary = model.salary;
                        self.Model5.Id = model.Id;
                        self.Model5.average = model.average;
                        self.Model5.play_time = model.play_time;
                        self.Model5.team_id = model.team_id;
                        self.Model5.project_id = model.project_id;
                        self.Model5.img = model.img;
                        self.Model5.nationality = model.nationality;
                        self.Model5.position = model.position;
                        self.Model5.is_undetermined = model.is_undetermined;
                        self.Model5.is_illness = model.is_illness;
                        self.Model5.is_ban = model.is_ban;
                        self.Model5.is_out = model.is_out;
                        self.Model5.match_id = model.match_id;
                        self.Model5.state = model.state;
                        self.Model5.isDisplay = model.isDisplay;
                        self.Model5.isNO = model.isNO;
                        //-------------------------

                    }else if([model.Id isEqualToString:[dictionary_data objectForKey:@"6"]]){
                        [self.Player_Icon6 yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"player-photo"]];
                        self.name6.text = model.name;
                        self.wei_Lab6.text = @"后卫";
                        self.gz_Lab6.text = [NSString stringWithFormat:@"$%@",model.salary];
                        self.SEL_View6.hidden = NO;
                        self.OView6.hidden = YES;
                        self.S_View6.hidden = YES;  //时间
                        self.C_View6.hidden = NO;   //位置/工资
                        self.SliderView6.hidden = NO;//进度圈
                        self.chart6.chartType = PNChartFormatTypeNone;
                        self.chart6.current = [NSNumber numberWithDouble:model.average];
                        [self.chart6 strokeChart];
                        //-------------------------------
                        self.Model6 = [[NBAModel6Cell alloc ]init];
                        self.Model6.name = model.name;
                        self.Model6.salary = model.salary;
                        self.Model6.Id = model.Id;
                        self.Model6.average = model.average;
                        self.Model6.play_time = model.play_time;
                        self.Model6.team_id = model.team_id;
                        self.Model6.project_id = model.project_id;
                        self.Model6.img = model.img;
                        self.Model6.nationality = model.nationality;
                        self.Model6.position = model.position;
                        self.Model6.is_undetermined = model.is_undetermined;
                        self.Model6.is_illness = model.is_illness;
                        self.Model6.is_ban = model.is_ban;
                        self.Model6.is_out = model.is_out;
                        self.Model6.match_id = model.match_id;
                        self.Model6.state = model.state;
                        self.Model6.isDisplay = model.isDisplay;
                        self.Model6.isNO = model.isNO;
                        //-------------------------

                        
                    }else if([model.Id isEqualToString:[dictionary_data objectForKey:@"7"]]){
                        [self.Player_Icon7 yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"player-photo"]];
                        self.name7.text = model.name;
                        self.wei_Lab7.text = @"前锋";
                        self.gz_Lab7.text = [NSString stringWithFormat:@"$%@",model.salary];
                        self.SEL_View7.hidden = NO;
                        self.OView7.hidden = YES;
                        self.S_View7.hidden = YES;  //时间
                        self.C_View7.hidden = NO;   //位置/工资
                        self.SliderView7.hidden = NO;//进度圈
                        self.chart7.chartType = PNChartFormatTypeNone;
                        self.chart7.current = [NSNumber numberWithDouble:model.average];
                        [self.chart7 strokeChart];
                        //-------------------------------
                        self.Model7 = [[NBAModel7Cell alloc ]init];
                        self.Model7.name = model.name;
                        self.Model7.salary = model.salary;
                        self.Model7.Id = model.Id;
                        self.Model7.average = model.average;
                        self.Model7.play_time = model.play_time;
                        self.Model7.team_id = model.team_id;
                        self.Model7.project_id = model.project_id;
                        self.Model7.img = model.img;
                        self.Model7.nationality = model.nationality;
                        self.Model7.position = model.position;
                        self.Model7.is_undetermined = model.is_undetermined;
                        self.Model7.is_illness = model.is_illness;
                        self.Model7.is_ban = model.is_ban;
                        self.Model7.is_out = model.is_out;
                        self.Model7.match_id = model.match_id;
                        self.Model7.state = model.state;
                        self.Model7.isDisplay = model.isDisplay;
                        self.Model7.isNO = model.isNO;
                        //-------------------------

                    }else {
                        [self.Player_Icon8 yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"player-photo"]];
                        self.name8.text = model.name;
                        self.wei_Lab8.text = @"任意";
                        self.gz_Lab8.text = [NSString stringWithFormat:@"$%@",model.salary];
                        self.SEL_View8.hidden = NO;
                        self.OView8.hidden = YES;
                        self.S_View8.hidden = YES;  //时间
                        self.C_View8.hidden = NO;   //位置/工资
                        self.SliderView8.hidden = NO;//进度圈
                        self.chart8.chartType = PNChartFormatTypeNone;
                        self.chart8.current = [NSNumber numberWithDouble:model.average];
                        [self.chart8 strokeChart];
                        //-------------------------------
                        self.Model8 = [[NBAModel8Cell alloc ]init];
                        self.Model8.name = model.name;
                        self.Model8.salary = model.salary;
                        self.Model8.Id = model.Id;
                        self.Model8.average = model.average;
                        self.Model8.play_time = model.play_time;
                        self.Model8.team_id = model.team_id;
                        self.Model8.project_id = model.project_id;
                        self.Model8.img = model.img;
                        self.Model8.nationality = model.nationality;
                        self.Model8.position = model.position;
                        self.Model8.is_undetermined = model.is_undetermined;
                        self.Model8.is_illness = model.is_illness;
                        self.Model8.is_ban = model.is_ban;
                        self.Model8.is_out = model.is_out;
                        self.Model8.match_id = model.match_id;
                        self.Model8.state = model.state;
                        self.Model8.isDisplay = model.isDisplay;
                        self.Model8.isNO = model.isNO;
                        //-------------------------

                    }
                }
                
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }];
    
    [alertController addAction:noAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark - 清除阵容
- (IBAction)QCZRBtnClick:(UIButton *)sender {
   
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"message:@"确定清除阵容？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        self.PJLab.text = @"0";
        self.Price_Lab.text = [NSString stringWithFormat:@"$%@",self.allGZ];
        
        self.Model1 = [[NBAModel1Cell alloc] init];
        self.Model2 = [[NBAModel2Cell alloc] init];
        self.Model3 = [[NBAModel3Cell alloc] init];
        self.Model4 = [[NBAModel4Cell alloc] init];
        self.Model5 = [[NBAModel5Cell alloc] init];
        self.Model6 = [[NBAModel6Cell alloc] init];
        self.Model7 = [[NBAModel7Cell alloc] init];
        self.Model8 = [[NBAModel8Cell alloc] init];
        
        
        self.SEL_View1.hidden = YES;
        self.OView1.hidden = NO;
        self.S_View1.hidden = YES;  //时间
        self.C_View1.hidden = YES;   //位置/工资
        self.SliderView1.hidden = YES;//进度圈
        [self.Player_Icon1 setImage:[UIImage imageNamed:@"player-photo"]];
        
        self.SEL_View2.hidden = YES;
        self.OView2.hidden = NO;
        self.S_View2.hidden = YES;  //时间
        self.C_View2.hidden = YES;   //位置/工资
        self.SliderView2.hidden = YES;//进度圈
        [self.Player_Icon2 setImage:[UIImage imageNamed:@"player-photo"]];
        
        self.SEL_View3.hidden = YES;
        self.OView3.hidden = NO;
        self.S_View3.hidden = YES;  //时间
        self.C_View3.hidden = YES;   //位置/工资
        self.SliderView3.hidden = YES;//进度圈
        [self.Player_Icon3 setImage:[UIImage imageNamed:@"player-photo"]];
        
        self.SEL_View4.hidden = YES;
        self.OView4.hidden = NO;
        self.S_View4.hidden = YES;  //时间
        self.C_View4.hidden = YES;   //位置/工资
        self.SliderView4.hidden = YES;//进度圈
        [self.Player_Icon4 setImage:[UIImage imageNamed:@"player-photo"]];
        
        self.SEL_View5.hidden = YES;
        self.OView5.hidden = NO;
        self.S_View5.hidden = YES;  //时间
        self.C_View5.hidden = YES;   //位置/工资
        self.SliderView5.hidden = YES;//进度圈
        [self.Player_Icon5 setImage:[UIImage imageNamed:@"player-photo"]];
        
        self.SEL_View6.hidden = YES;
        self.OView6.hidden = NO;
        self.S_View6.hidden = YES;  //时间
        self.C_View6.hidden = YES;   //位置/工资
        self.SliderView6.hidden = YES;//进度圈
        [self.Player_Icon6 setImage:[UIImage imageNamed:@"player-photo"]];
        
        self.SEL_View7.hidden = YES;
        self.OView7.hidden = NO;
        self.S_View7.hidden = YES;  //时间
        self.C_View7.hidden = YES;   //位置/工资
        self.SliderView7.hidden = YES;//进度圈
        [self.Player_Icon7 setImage:[UIImage imageNamed:@"player-photo"]];
        
        self.SEL_View8.hidden = YES;
        self.OView8.hidden = NO;
        self.S_View8.hidden = YES;  //时间
        self.C_View8.hidden = YES;   //位置/工资
        self.SliderView8.hidden = YES;//进度圈
        [self.Player_Icon8 setImage:[UIImage imageNamed:@"player-photo"]];

   
    }];
    
    [alertController addAction:noAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];

}

#pragma mark - 定时器
//开始定时器
- (void)startTimer{
    if (self.listTimer == nil) {
        self.listTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    }
}
//结束定时器
- (void)stopTimer {
    if (self.listTimer) {
        [self.listTimer invalidate];//定时器无效
        self.listTimer = nil;
    }
}
//定时器方法
- (void)onTimer:(NSTimer *)timer {
    self.TIME_mast -- ;
    TIME = self.TIME_mast;
    self.tome_Lab.text = [NSString stringWithFormat:@"距离截止时间剩余：%@",[self ConvertStrToTime:TIME]];
    
}
//重新计算 时/分/秒
- (NSString *)ConvertStrToTime:(NSInteger )timeStr{
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",timeStr/3600];
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(timeStr%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld",timeStr%60];
    NSString *timeString = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    return timeString;
}






//---------------中间----------------
- (void)initZhongView {
    //1
    self.OView1.hidden = NO;
    self.SEL_View1.hidden = YES;
    self.S_View1.hidden = YES;      //时间
    self.C_View1.hidden = YES;      //位置/工资
    self.SliderView1.hidden = YES;   //进度圈
    self.chart1 = [[PNCircleChart alloc] initWithFrame:CGRectMake(0, 0, 30, 30)
                                                 total:[NSNumber numberWithInt:100]
                                               current:[NSNumber numberWithInt:0]
                                             clockwise:YES
                                                shadow:YES
                                           shadowColor:[UIColor getColorWithdown]
                                  displayCountingLabel:YES
                                     overrideLineWidth:[NSNumber numberWithInt:3]];
    
    self.chart1.backgroundColor = [UIColor clearColor];
    [self.chart1 setStrokeColor:[UIColor getColorWithTheme]];
    self.chart1.countingLabel.font = [UIFont systemFontOfSize:8];
    [self.SliderView1 addSubview:self.chart1];
    
    //2
    self.OView2.hidden = NO;
    self.SEL_View2.hidden = YES;
    self.S_View2.hidden = YES;      //时间
    self.C_View2.hidden = YES;      //位置/工资
    self.SliderView2.hidden = YES;   //进度圈
    self.chart2 = [[PNCircleChart alloc] initWithFrame:CGRectMake(0, 0, 30, 30)
                                                 total:[NSNumber numberWithInt:100]
                                               current:[NSNumber numberWithInt:0]
                                             clockwise:YES
                                                shadow:YES
                                           shadowColor:[UIColor getColorWithdown]
                                  displayCountingLabel:YES
                                     overrideLineWidth:[NSNumber numberWithInt:3]];
    
    self.chart2.backgroundColor = [UIColor clearColor];
    [self.chart2 setStrokeColor:[UIColor getColorWithTheme]];
    self.chart2.countingLabel.font = [UIFont systemFontOfSize:8];
    [self.SliderView2 addSubview:self.chart2];
    
    //3
    self.OView3.hidden = NO;
    self.SEL_View3.hidden = YES;
    self.S_View3.hidden = YES;      //时间
    self.C_View3.hidden = YES;      //位置/工资
    self.SliderView3.hidden = YES;   //进度圈
    self.chart3 = [[PNCircleChart alloc] initWithFrame:CGRectMake(0, 0, 30, 30)
                                                 total:[NSNumber numberWithInt:100]
                                               current:[NSNumber numberWithInt:0]
                                             clockwise:YES
                                                shadow:YES
                                           shadowColor:[UIColor getColorWithdown]
                                  displayCountingLabel:YES
                                     overrideLineWidth:[NSNumber numberWithInt:3]];
    
    self.chart3.backgroundColor = [UIColor clearColor];
    [self.chart3 setStrokeColor:[UIColor getColorWithTheme]];
    self.chart3.countingLabel.font = [UIFont systemFontOfSize:8];
    [self.SliderView3 addSubview:self.chart3];
    
    
    //4
    self.OView4.hidden = NO;
    self.SEL_View4.hidden = YES;
    self.S_View4.hidden = YES;      //时间
    self.C_View4.hidden = YES;      //位置/工资
    self.SliderView4.hidden = YES;   //进度圈
    self.chart4 = [[PNCircleChart alloc] initWithFrame:CGRectMake(0, 0, 30, 30)
                                                 total:[NSNumber numberWithInt:100]
                                               current:[NSNumber numberWithInt:0]
                                             clockwise:YES
                                                shadow:YES
                                           shadowColor:[UIColor getColorWithdown]
                                  displayCountingLabel:YES
                                     overrideLineWidth:[NSNumber numberWithInt:3]];
    
    self.chart4.backgroundColor = [UIColor clearColor];
    [self.chart4 setStrokeColor:[UIColor getColorWithTheme]];
    self.chart4.countingLabel.font = [UIFont systemFontOfSize:8];
    [self.SliderView4 addSubview:self.chart4];
    
    //5
    self.OView5.hidden = NO;
    self.SEL_View5.hidden = YES;
    self.S_View5.hidden = YES;      //时间
    self.C_View5.hidden = YES;      //位置/工资
    self.SliderView5.hidden = YES;   //进度圈
    self.chart5 = [[PNCircleChart alloc] initWithFrame:CGRectMake(0, 0, 30, 30)
                                                 total:[NSNumber numberWithInt:100]
                                               current:[NSNumber numberWithInt:0]
                                             clockwise:YES
                                                shadow:YES
                                           shadowColor:[UIColor getColorWithdown]
                                  displayCountingLabel:YES
                                     overrideLineWidth:[NSNumber numberWithInt:3]];
    
    self.chart5.backgroundColor = [UIColor clearColor];
    [self.chart5 setStrokeColor:[UIColor getColorWithTheme]];
    self.chart5.countingLabel.font = [UIFont systemFontOfSize:8];
    [self.SliderView5 addSubview:self.chart5];
    
    
    //6
    self.OView6.hidden = NO;
    self.SEL_View6.hidden = YES;
    self.S_View6.hidden = YES;      //时间
    self.C_View6.hidden = YES;      //位置/工资
    self.SliderView6.hidden = YES;   //进度圈
    self.chart6 = [[PNCircleChart alloc] initWithFrame:CGRectMake(0, 0, 30, 30)
                                                 total:[NSNumber numberWithInt:100]
                                               current:[NSNumber numberWithInt:0]
                                             clockwise:YES
                                                shadow:YES
                                           shadowColor:[UIColor getColorWithdown]
                                  displayCountingLabel:YES
                                     overrideLineWidth:[NSNumber numberWithInt:3]];
    
    self.chart6.backgroundColor = [UIColor clearColor];
    [self.chart6 setStrokeColor:[UIColor getColorWithTheme]];
    self.chart6.countingLabel.font = [UIFont systemFontOfSize:8];
    [self.SliderView6 addSubview:self.chart6];
 
    
    //7
    self.OView7.hidden = NO;
    self.SEL_View7.hidden = YES;
    self.S_View7.hidden = YES;      //时间
    self.C_View7.hidden = YES;      //位置/工资
    self.SliderView7.hidden = YES;   //进度圈
    self.chart7 = [[PNCircleChart alloc] initWithFrame:CGRectMake(0, 0, 30, 30)
                                                 total:[NSNumber numberWithInt:100]
                                               current:[NSNumber numberWithInt:0]
                                             clockwise:YES
                                                shadow:YES
                                           shadowColor:[UIColor getColorWithdown]
                                  displayCountingLabel:YES
                                     overrideLineWidth:[NSNumber numberWithInt:3]];
    
    self.chart7.backgroundColor = [UIColor clearColor];
    [self.chart7 setStrokeColor:[UIColor getColorWithTheme]];
    self.chart7.countingLabel.font = [UIFont systemFontOfSize:8];
    [self.SliderView7 addSubview:self.chart7];

    
    //8
    self.OView8.hidden = NO;
    self.SEL_View8.hidden = YES;
    self.S_View8.hidden = YES;      //时间
    self.C_View8.hidden = YES;      //位置/工资
    self.SliderView8.hidden = YES;   //进度圈
    self.chart8 = [[PNCircleChart alloc] initWithFrame:CGRectMake(0, 0, 30, 30)
                                                 total:[NSNumber numberWithInt:100]
                                               current:[NSNumber numberWithInt:0]
                                             clockwise:YES
                                                shadow:YES
                                           shadowColor:[UIColor getColorWithdown]
                                  displayCountingLabel:YES
                                     overrideLineWidth:[NSNumber numberWithInt:3]];
    
    self.chart8.backgroundColor = [UIColor clearColor];
    [self.chart8 setStrokeColor:[UIColor getColorWithTheme]];
    self.chart8.countingLabel.font = [UIFont systemFontOfSize:8];
    [self.SliderView8 addSubview:self.chart8];
    
}





@end


@implementation NBA_PlayerListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [NBA_PlayerListModelCell class]};
}
@end

@implementation NBA_PlayerListModelCell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id" };
}
@end







