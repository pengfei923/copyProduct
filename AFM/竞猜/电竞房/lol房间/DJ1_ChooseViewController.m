 //
//  DJ1_ChooseViewController.m
//  AFM
//
//  Created by admin on 2017/10/17.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "DJ1_ChooseViewController.h"
#import "SuccessZRViewController.h"
#import "PlayerChooseViewController.h"
#import "SaveZRViewController.h"
#import "TJZR_BackView.h"

@interface DJ1_ChooseViewController (){
    NSTimeInterval TIME;         //时间间隔
    
}
@property (nonatomic , strong) TJZR_BackView *backRView;       //提交阵容
@property (nonatomic , strong) NSMutableArray *DJ_listData;    //所有选手
@property (nonatomic , strong) NSDictionary  *YJTJ_Dic;        //一键推荐
@property (nonatomic , strong) NSMutableArray *PJ_arr;         //平均分总和数组
@property (nonatomic , strong) NSMutableArray *GZ_arr;         //工资总和数组
@property (nonatomic , strong) NSTimer *listTimer;            //定时器


@property (nonatomic , strong) DJModel1Cell *Model1;            //
@property (nonatomic , strong) DJModel2Cell *Model2;            //
@property (nonatomic , strong) DJModel3Cell *Model3;            //
@property (nonatomic , strong) DJModel4Cell *Model4;            //
@property (nonatomic , strong) DJModel5Cell *Model5;            //
@property (nonatomic , strong) DJModel6Cell *Model6;            //
@property (nonatomic , strong) DJModel7Cell *Model7;            //
@property (nonatomic , strong) DJModel8Cell *Model8;            //

@end

@implementation DJ1_ChooseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startTimer];
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
    
    if (self.ZR_Type) {
        
    }else{
        [self initAAAAAA];
    }

}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"房间布阵";
    
}

//初始化界面
- (void)initView {
    self.icon_Btn1.layer.masksToBounds = YES;
    self.icon_Btn2.layer.masksToBounds = YES;
    self.icon_Btn3.layer.masksToBounds = YES;
    self.icon_Btn4.layer.masksToBounds = YES;
    self.icon_Btn5.layer.masksToBounds = YES;
    self.icon_Btn6.layer.masksToBounds = YES;
    self.icon_Btn7.layer.masksToBounds = YES;
    self.icon_Btn8.layer.masksToBounds = YES;
    self.icon_Btn1.layer.cornerRadius = 27.5;
    self.icon_Btn2.layer.cornerRadius = 27.5;
    self.icon_Btn3.layer.cornerRadius = 27.5;
    self.icon_Btn4.layer.cornerRadius = 27.5;
    self.icon_Btn5.layer.cornerRadius = 27.5;
    self.icon_Btn6.layer.cornerRadius = 27.5;
    self.icon_Btn7.layer.cornerRadius = 27.5;
    self.icon_Btn8.layer.cornerRadius = 27.5;
    self.SELView1.hidden = YES;
    self.SELView2.hidden = YES;
    self.SELView3.hidden = YES;
    self.SELView4.hidden = YES;
    self.SELView5.hidden = YES;
    self.SELView6.hidden = YES;
    self.SELView7.hidden = YES;
    self.SELView8.hidden = YES;
    self.zhong_View1.layer.cornerRadius = 6.0;
    self.zhong_View2.layer.cornerRadius = 6.0;
    self.zhong_View3.layer.cornerRadius = 6.0;
    self.zhong_View4.layer.cornerRadius = 6.0;
    self.zhong_View5.layer.cornerRadius = 6.0;
    self.zhong_View6.layer.cornerRadius = 6.0;
    self.zhong_View7.layer.cornerRadius = 6.0;
    self.zhong_View8.layer.cornerRadius = 6.0;
    self.ZR_num.layer.masksToBounds = YES;
    self.ZR_num.layer.cornerRadius = 6.0;
    
    self.Price_Lab.text = [NSString stringWithFormat:@"%@",self.allGZ];
    if ( self.num.length == 0) {
        self.ZR_num.text = @"0";
        self.ZR_num.hidden = YES;
    }else{
        self.ZR_num.text = self.num;
        self.ZR_num.hidden = NO;
    }
    
}



//初始化数据
- (void)initData {
    //    获取房间的所有参赛的球员信息
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
            DJ1_PlayerListModel *listModel = [DJ1_PlayerListModel yy_modelWithDictionary:dic];
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
    self.PJ_Lab.text = [NSString stringWithFormat:@"%@",sumPJ];
    //工资
    NSNumber *sumGZ = [self.GZ_arr valueForKeyPath:@"@sum.floatValue"];
    self.Price_Lab.text = [NSString stringWithFormat:@"$%.0f",[self.allGZ floatValue] - [sumGZ floatValue]];
    
    
}

#pragma mark - 按钮点击事件
- (IBAction)button1_Click:(UIButton *)sender {
    PlayerChooseViewController *ChooseVC = [[PlayerChooseViewController alloc] init];
    ChooseVC.returnDJModel1 = ^(DJModel1Cell *model1, DJModel2Cell *model2, DJModel3Cell *model3, DJModel4Cell *model4, DJModel5Cell *model5, DJModel6Cell *model6, DJModel7Cell *model7, DJModel8Cell *model8) {
        
        [self initAllModel:model1 :model2 :model3 :model4 :model5 :model6 :model7 :model8];
        
    };
    ChooseVC.model1 = self.Model1;
    ChooseVC.model2 = self.Model2;
    ChooseVC.model3 = self.Model3;
    ChooseVC.model4 = self.Model4;
    ChooseVC.model5 = self.Model5;
    ChooseVC.model6 = self.Model6;
    ChooseVC.model7 = self.Model7;
    ChooseVC.model8 = self.Model8;

    ChooseVC.typeOder_num = @"1";
    ChooseVC.roomId = self.Id;
    ChooseVC.allGZ = self.allGZ;
    ChooseVC.type_Ren = @"lol";
    [ChooseVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:ChooseVC animated:YES];
    
}
- (IBAction)button2_Click:(UIButton *)sender {
    PlayerChooseViewController *ChooseVC = [[PlayerChooseViewController alloc] init];
    ChooseVC.returnDJModel1 = ^(DJModel1Cell *model1, DJModel2Cell *model2, DJModel3Cell *model3, DJModel4Cell *model4, DJModel5Cell *model5, DJModel6Cell *model6, DJModel7Cell *model7, DJModel8Cell *model8) {
        
        [self initAllModel:model1 :model2 :model3 :model4 :model5 :model6 :model7 :model8];
        
    };
    ChooseVC.model1 = self.Model1;
    ChooseVC.model2 = self.Model2;
    ChooseVC.model3 = self.Model3;
    ChooseVC.model4 = self.Model4;
    ChooseVC.model5 = self.Model5;
    ChooseVC.model6 = self.Model6;
    ChooseVC.model7 = self.Model7;
    ChooseVC.model8 = self.Model8;
    
    ChooseVC.typeOder_num = @"2";
    ChooseVC.roomId = self.Id;
    ChooseVC.type_Ren = @"lol";
    ChooseVC.allGZ = self.allGZ;
    [ChooseVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:ChooseVC animated:YES];
    
}
- (IBAction)button3_Click:(UIButton *)sender {
    PlayerChooseViewController *ChooseVC = [[PlayerChooseViewController alloc] init];
    ChooseVC.returnDJModel1 = ^(DJModel1Cell *model1, DJModel2Cell *model2, DJModel3Cell *model3, DJModel4Cell *model4, DJModel5Cell *model5, DJModel6Cell *model6, DJModel7Cell *model7, DJModel8Cell *model8) {
        
        [self initAllModel:model1 :model2 :model3 :model4 :model5 :model6 :model7 :model8];
        
    };
    
    ChooseVC.model1 = self.Model1;
    ChooseVC.model2 = self.Model2;
    ChooseVC.model3 = self.Model3;
    ChooseVC.model4 = self.Model4;
    ChooseVC.model5 = self.Model5;
    ChooseVC.model6 = self.Model6;
    ChooseVC.model7 = self.Model7;
    ChooseVC.model8 = self.Model8;

    ChooseVC.typeOder_num = @"3";
    ChooseVC.roomId = self.Id;
    ChooseVC.type_Ren = @"lol";
    ChooseVC.allGZ = self.allGZ;
    [ChooseVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:ChooseVC animated:YES];
    
}
- (IBAction)button4_Click:(UIButton *)sender {
    PlayerChooseViewController *ChooseVC = [[PlayerChooseViewController alloc] init];
    ChooseVC.returnDJModel1 = ^(DJModel1Cell *model1, DJModel2Cell *model2, DJModel3Cell *model3, DJModel4Cell *model4, DJModel5Cell *model5, DJModel6Cell *model6, DJModel7Cell *model7, DJModel8Cell *model8) {
        
        [self initAllModel:model1 :model2 :model3 :model4 :model5 :model6 :model7 :model8];
        
    };
    
    ChooseVC.model1 = self.Model1;
    ChooseVC.model2 = self.Model2;
    ChooseVC.model3 = self.Model3;
    ChooseVC.model4 = self.Model4;
    ChooseVC.model5 = self.Model5;
    ChooseVC.model6 = self.Model6;
    ChooseVC.model7 = self.Model7;
    ChooseVC.model8 = self.Model8;
    
    ChooseVC.typeOder_num = @"4";
    ChooseVC.roomId = self.Id;
    ChooseVC.type_Ren = @"lol";
    ChooseVC.allGZ = self.allGZ;
    [ChooseVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:ChooseVC animated:YES];
    
}
- (IBAction)button5_Click:(UIButton *)sender {
    PlayerChooseViewController *ChooseVC = [[PlayerChooseViewController alloc] init];
    ChooseVC.returnDJModel1 = ^(DJModel1Cell *model1, DJModel2Cell *model2, DJModel3Cell *model3, DJModel4Cell *model4, DJModel5Cell *model5, DJModel6Cell *model6, DJModel7Cell *model7, DJModel8Cell *model8) {
        
        [self initAllModel:model1 :model2 :model3 :model4 :model5 :model6 :model7 :model8];
        
    };
    
    ChooseVC.model1 = self.Model1;
    ChooseVC.model2 = self.Model2;
    ChooseVC.model3 = self.Model3;
    ChooseVC.model4 = self.Model4;
    ChooseVC.model5 = self.Model5;
    ChooseVC.model6 = self.Model6;
    ChooseVC.model7 = self.Model7;
    ChooseVC.model8 = self.Model8;

    ChooseVC.typeOder_num = @"5";
    ChooseVC.roomId = self.Id;
    ChooseVC.type_Ren = @"lol";
    ChooseVC.allGZ = self.allGZ;
    [ChooseVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:ChooseVC animated:YES];
    
}
- (IBAction)button6_Click:(UIButton *)sender {
    PlayerChooseViewController *ChooseVC = [[PlayerChooseViewController alloc] init];
    ChooseVC.returnDJModel1 = ^(DJModel1Cell *model1, DJModel2Cell *model2, DJModel3Cell *model3, DJModel4Cell *model4, DJModel5Cell *model5, DJModel6Cell *model6, DJModel7Cell *model7, DJModel8Cell *model8) {
        
        [self initAllModel:model1 :model2 :model3 :model4 :model5 :model6 :model7 :model8];
        
    };
    
    ChooseVC.model1 = self.Model1;
    ChooseVC.model2 = self.Model2;
    ChooseVC.model3 = self.Model3;
    ChooseVC.model4 = self.Model4;
    ChooseVC.model5 = self.Model5;
    ChooseVC.model6 = self.Model6;
    ChooseVC.model7 = self.Model7;
    ChooseVC.model8 = self.Model8;
    
    ChooseVC.typeOder_num = @"6";
    ChooseVC.roomId = self.Id;
    ChooseVC.type_Ren = @"lol";
    ChooseVC.allGZ = self.allGZ;
    [ChooseVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:ChooseVC animated:YES];
}
- (IBAction)button7_Click:(UIButton *)sender {
    PlayerChooseViewController *ChooseVC = [[PlayerChooseViewController alloc] init];
    ChooseVC.returnDJModel1 = ^(DJModel1Cell *model1, DJModel2Cell *model2, DJModel3Cell *model3, DJModel4Cell *model4, DJModel5Cell *model5, DJModel6Cell *model6, DJModel7Cell *model7, DJModel8Cell *model8) {
        
        [self initAllModel:model1 :model2 :model3 :model4 :model5 :model6 :model7 :model8];
        
    };
    
    ChooseVC.model1 = self.Model1;
    ChooseVC.model2 = self.Model2;
    ChooseVC.model3 = self.Model3;
    ChooseVC.model4 = self.Model4;
    ChooseVC.model5 = self.Model5;
    ChooseVC.model6 = self.Model6;
    ChooseVC.model7 = self.Model7;
    ChooseVC.model8 = self.Model8;
    
    ChooseVC.typeOder_num = @"7";
    ChooseVC.roomId = self.Id;
    ChooseVC.type_Ren = @"lol";
    ChooseVC.allGZ = self.allGZ;
    [ChooseVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:ChooseVC animated:YES];
    
}
- (IBAction)button8_Click:(UIButton *)sender {
    PlayerChooseViewController *ChooseVC = [[PlayerChooseViewController alloc] init];
    ChooseVC.returnDJModel1 = ^(DJModel1Cell *model1, DJModel2Cell *model2, DJModel3Cell *model3, DJModel4Cell *model4, DJModel5Cell *model5, DJModel6Cell *model6, DJModel7Cell *model7, DJModel8Cell *model8) {
        
        [self initAllModel:model1 :model2 :model3 :model4 :model5 :model6 :model7 :model8];
        
    };
    ChooseVC.model1 = self.Model1;
    ChooseVC.model2 = self.Model2;
    ChooseVC.model3 = self.Model3;
    ChooseVC.model4 = self.Model4;
    ChooseVC.model5 = self.Model5;
    ChooseVC.model6 = self.Model6;
    ChooseVC.model7 = self.Model7;
    ChooseVC.model8 = self.Model8;
    
    ChooseVC.typeOder_num = @"8";
    ChooseVC.roomId = self.Id;
    ChooseVC.type_Ren = @"lol";
    ChooseVC.allGZ = self.allGZ;
    [ChooseVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:ChooseVC animated:YES];
    
}


- (void)initAllModel: (DJModel1Cell *)model1 :(DJModel2Cell *)model2 :(DJModel3Cell *)model3 :(DJModel4Cell *)model4 :(DJModel5Cell *)model5 :(DJModel6Cell *)model6 :(DJModel7Cell *)model7 :(DJModel8Cell *)model8{
    
    if (model1) {
        if (model1.Id.length >= 1) {
            self.Model1 = model1;
            [self.icon_Btn1 yy_setImageWithURL:[NSURL URLWithString:model1.img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"lol-defult"]];
            self.name1.text = model1.name;
            self.PJ_Lab1.text = [NSString stringWithFormat:@"%0.1f",model1.average];
            self.price1.text = [NSString stringWithFormat:@"$%@",model1.salary];
            self.SELView1.hidden = NO;
            self.OView1.hidden = YES;
            
        }else{
            self.Model1 = [[DJModel1Cell alloc] init];
            self.SELView1.hidden = YES;
            self.OView1.hidden = NO;
            [self.icon_Btn1 setImage:[UIImage imageNamed:@"lol-defult"] forState:UIControlStateNormal];
            
        }
        [self initAAAAAA];
        
    }
    
    if (model2) {
        if (model2.Id.length >= 1) {
            self.Model2 = model2;
            [self.icon_Btn2 yy_setImageWithURL:[NSURL URLWithString:model2.img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"lol-defult"]];
            self.name2.text = model2.name;
            self.PJ_Lab2.text = [NSString stringWithFormat:@"%0.1f",model2.average];
            self.price2.text = [NSString stringWithFormat:@"$%@",model2.salary];
            self.SELView2.hidden = NO;
            self.OView2.hidden = YES;
            
        }else{
            self.Model2 = [[DJModel2Cell alloc] init];
            
            self.SELView2.hidden = YES;
            self.OView2.hidden = NO;
            [self.icon_Btn2 setImage:[UIImage imageNamed:@"lol-defult"] forState:UIControlStateNormal];
            
        }
        [self initAAAAAA];
        
    }
    
    if (model3) {
        if (model3.Id.length >= 1) {
            self.Model3 = model3;
            [self.icon_Btn3 yy_setImageWithURL:[NSURL URLWithString:model3.img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"lol-defult"]];
            self.name3.text = model3.name;
            self.PJ_Lab3.text = [NSString stringWithFormat:@"%0.1f",model3.average];
            self.price3.text = [NSString stringWithFormat:@"$%@",model3.salary];
            self.SELView3.hidden = NO;
            self.OView3.hidden = YES;
            
        }else{
            self.Model3 = [[DJModel3Cell alloc] init];
            
            self.SELView3.hidden = YES;
            self.OView3.hidden = NO;
            [self.icon_Btn3 setImage:[UIImage imageNamed:@"lol-defult"] forState:UIControlStateNormal];
        }
        [self initAAAAAA];
        
        
    }
    
    if (model4) {
        if (model4.Id.length >= 1) {
            self.Model4 = model4;
            [self.icon_Btn4 yy_setImageWithURL:[NSURL URLWithString:model4.img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"lol-defult"]];
            self.name4.text = model4.name;
            self.PJ_Lab4.text = [NSString stringWithFormat:@"%0.1f",model4.average];
            self.price4.text = [NSString stringWithFormat:@"$%@",model4.salary];
            self.SELView4.hidden = NO;
            self.OView4.hidden = YES;
            
            
        }else{
            self.Model4 = [[DJModel4Cell alloc] init];
            
            self.SELView4.hidden = YES;
            self.OView4.hidden = NO;
            [self.icon_Btn4 setImage:[UIImage imageNamed:@"lol-defult"] forState:UIControlStateNormal];
            
            
        }
        [self initAAAAAA];
        
    }
    
    if (model5) {
        if (model5.Id.length >= 1) {
            self.Model5 = model5;
            [self.icon_Btn5 yy_setImageWithURL:[NSURL URLWithString:model5.img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"lol-defult"]];
            self.name5.text = model5.name;
            self.PJ_Lab5.text = [NSString stringWithFormat:@"%0.1f",model5.average];
            self.price5.text = [NSString stringWithFormat:@"$%@",model5.salary];
            self.SELView5.hidden = NO;
            self.OView5.hidden = YES;
        }else{
            self.Model5 = [[DJModel5Cell alloc] init];
            
            self.SELView5.hidden = YES;
            self.OView5.hidden = NO;
            [self.icon_Btn5 setImage:[UIImage imageNamed:@"lol-defult"] forState:UIControlStateNormal];
        }
        [self initAAAAAA];
        
    }
    
    if (model6) {
        if (model6.Id.length >= 1) {
            self.Model6 = model6;
            [self.icon_Btn6 yy_setImageWithURL:[NSURL URLWithString:model6.img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"lol-defult"]];
            self.name6.text = model6.name;
            self.PJ_Lab6.text = [NSString stringWithFormat:@"%0.1f",model6.average];
            self.price6.text = [NSString stringWithFormat:@"$%@",model6.salary];
            self.SELView6.hidden = NO;
            self.OView6.hidden = YES;
            
        }else{
            self.Model6 = [[DJModel6Cell alloc] init];
            
            self.SELView6.hidden = YES;
            self.OView6.hidden = NO;
            [self.icon_Btn6 setImage:[UIImage imageNamed:@"lol-defult"] forState:UIControlStateNormal];
        }
        [self initAAAAAA];
        
    }
    
    if (model7) {
        if (model7.Id.length >= 1) {
            self.Model7 = model7;
            [self.icon_Btn7 yy_setImageWithURL:[NSURL URLWithString:model7.img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"lol-defult"]];
            self.name7.text = model7.name;
            self.PJ_Lab7.text = [NSString stringWithFormat:@"%0.1f",model7.average];
            self.price7.text = [NSString stringWithFormat:@"$%@",model7.salary];
            self.SELView7.hidden = NO;
            self.OView7.hidden = YES;
            
        }else{
            self.Model7 = [[DJModel7Cell alloc] init];
            
            self.SELView7.hidden = YES;
            self.OView7.hidden = NO;
            [self.icon_Btn7 setImage:[UIImage imageNamed:@"lol-defult"] forState:UIControlStateNormal];
            
        }
        [self initAAAAAA];
        
    }
    
    if (model8) {
        if (model8.Id.length >= 1) {
            self.Model8 = model8;
            [self.icon_Btn8 yy_setImageWithURL:[NSURL URLWithString:model8.img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"lol-defult"]];
            self.name8.text = model8.name;
            self.PJ_Lab8.text = [NSString stringWithFormat:@"%0.1f",model8.average];
            self.price8.text = [NSString stringWithFormat:@"$%@",model8.salary];
            self.SELView8.hidden = NO;
            self.OView8.hidden = YES;
            
        }else{
            self.Model8 = [[DJModel8Cell alloc] init];
            
            self.SELView8.hidden = YES;
            self.OView8.hidden = NO;
            [self.icon_Btn8 setImage:[UIImage imageNamed:@"lol-defult"] forState:UIControlStateNormal];
            
        }
        
        [self initAAAAAA];
        
    }
    
}

#pragma mark - 提交阵容
- (IBAction)turn_BtnClick:(UIButton *)sender {
    if ((self.Model1.Id.length >= 1) && (self.Model2.Id.length >= 1) && (self.Model3.Id.length >= 1) && (self.Model4.Id.length >= 1) && (self.Model5.Id.length >= 1) && (self.Model6.Id.length >= 1) && (self.Model7.Id.length >= 1) && (self.Model8.Id.length >= 1)) {
        
        if ([[self.Price_Lab.text substringFromIndex:1] floatValue] >= 0) {  //判断工资是否为负数
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
                successVC.guess_num = self.guess_num;  //竞猜数量
                successVC.lol_nba_dota = @"dota";
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
- (IBAction)YCZR_BtnClick:(UIButton *)sender {
    SaveZRViewController *chooseVC = [[SaveZRViewController alloc] init];
    chooseVC.ID = self.Id;
    chooseVC.NUM = self.num;
    chooseVC.nba_lol_data = @"lol";
    chooseVC.numZRblock = ^(NSString *zr_NUM) {
        self.num = zr_NUM;
        self.ZR_num.text = zr_NUM;
        if (self.ZR_num.text.length == 0) {
            self.ZR_num.hidden = YES;
        }else{
            self.ZR_num.hidden = NO;
        }
    };
    chooseVC.chooseZRblock = ^(ZR_ModelDataCell *Model) {
        //顶部---平均分和工资
        self.PJ_Lab.text = [NSString stringWithFormat:@"%0.1f",Model.lineup_score];
        self.Price_Lab.text = [NSString stringWithFormat:@"$%@",Model.salary_sum];
        
        //一键推荐数组
        self.YJTJ_Dic = Model.lineup;
        
        //给每个View赋值
        for (DJ_PlayerListModelCell *model in self.DJ_listData) {
            if([model.Id isEqualToString:[Model.lineup objectForKey:@"1"]]){
                [self.icon_Btn1 yy_setImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@""]];
                self.name1.text = model.name;
                self.PJ_Lab1.text = [NSString stringWithFormat:@"%0.1f",model.average];
                self.price1.text = [NSString stringWithFormat:@"$%@",model.salary];
                self.SELView1.hidden = NO;
                self.OView1.hidden = YES;
                //-------------------------------
                self.Model1 = [[DJModel1Cell alloc ]init];
                self.Model1.name = model.name;
                self.Model1.salary = model.salary;
                self.Model1.Id = model.Id;
                self.Model1.average = model.average;
                self.Model1.KDA = model.KDA;
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
                [self.icon_Btn2 yy_setImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@""]];
                self.name2.text = model.name;
                self.PJ_Lab2.text = [NSString stringWithFormat:@"%0.1f",model.average];
                self.price2.text = [NSString stringWithFormat:@"$%@",model.salary];
                self.SELView2.hidden = NO;
                self.OView2.hidden = YES;
                //-------------------------------
                self.Model2 = [[DJModel2Cell alloc ]init];
                self.Model2.name = model.name;
                self.Model2.salary = model.salary;
                self.Model2.Id = model.Id;
                self.Model2.average = model.average;
                self.Model2.KDA = model.KDA;
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
                [self.icon_Btn3 yy_setImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@""]];
                self.name3.text = model.name;
                self.PJ_Lab3.text = [NSString stringWithFormat:@"%0.1f",model.average];
                self.price3.text = [NSString stringWithFormat:@"$%@",model.salary];
                self.SELView3.hidden = NO;
                self.OView3.hidden = YES;
                //-------------------------------
                self.Model3 = [[DJModel3Cell alloc ]init];
                self.Model3.name = model.name;
                self.Model3.salary = model.salary;
                self.Model3.Id = model.Id;
                self.Model3.average = model.average;
                self.Model3.KDA = model.KDA;
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
                [self.icon_Btn4 yy_setImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@""]];
                self.name4.text = model.name;
                self.PJ_Lab4.text = [NSString stringWithFormat:@"%0.1f",model.average];
                self.price4.text = [NSString stringWithFormat:@"$%@",model.salary];
                self.SELView4.hidden = NO;
                self.OView4.hidden = YES;
                //-------------------------------
                self.Model4 = [[DJModel4Cell alloc ]init];
                self.Model4.name = model.name;
                self.Model4.salary = model.salary;
                self.Model4.Id = model.Id;
                self.Model4.average = model.average;
                self.Model4.KDA = model.KDA;
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
                [self.icon_Btn5 yy_setImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@""]];
                self.name5.text = model.name;
                self.PJ_Lab5.text = [NSString stringWithFormat:@"%0.1f",model.average];
                self.price5.text = [NSString stringWithFormat:@"$%@",model.salary];
                self.SELView5.hidden = NO;
                self.OView5.hidden = YES;
                //-------------------------------
                self.Model5 = [[DJModel5Cell alloc ]init];
                self.Model5.name = model.name;
                self.Model5.salary = model.salary;
                self.Model5.Id = model.Id;
                self.Model5.average = model.average;
                self.Model5.KDA = model.KDA;
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
                
            }else if([model.Id isEqualToString:[Model.lineup objectForKey:@"6"]]){  //战队
                [self.icon_Btn8 yy_setImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@""]];
                self.name8.text = model.name;
                self.PJ_Lab8.text = [NSString stringWithFormat:@"%0.1f",model.average];
                self.price8.text = [NSString stringWithFormat:@"$%@",model.salary];
                self.SELView8.hidden = NO;
                self.OView8.hidden = YES;
                //-------------------------------
                self.Model6 = [[DJModel6Cell alloc ]init];
                self.Model6.name = model.name;
                self.Model6.salary = model.salary;
                self.Model6.Id = model.Id;
                self.Model6.average = model.average;
                self.Model6.KDA = model.KDA;
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
                [self.icon_Btn7 yy_setImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@""]];
                self.name7.text = model.name;
                self.PJ_Lab7.text = [NSString stringWithFormat:@"%0.1f",model.average];
                self.price7.text = [NSString stringWithFormat:@"$%@",model.salary];
                self.SELView7.hidden = NO;
                self.OView7.hidden = YES;
                //-------------------------------
                self.Model7 = [[DJModel7Cell alloc ]init];
                self.Model7.name = model.name;
                self.Model7.salary = model.salary;
                self.Model7.Id = model.Id;
                self.Model7.average = model.average;
                self.Model7.KDA = model.KDA;
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
                [self.icon_Btn6 yy_setImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@""]];
                self.name6.text = model.name;
                self.PJ_Lab6.text = [NSString stringWithFormat:@"%0.1f",model.average];
                self.price6.text = [NSString stringWithFormat:@"$%@",model.salary];
                self.SELView6.hidden = NO;
                self.OView6.hidden = YES;
                //-------------------------------
                self.Model8 = [[DJModel8Cell alloc ]init];
                self.Model8.name = model.name;
                self.Model8.salary = model.salary;
                self.Model8.Id = model.Id;
                self.Model8.average = model.average;
                self.Model8.KDA = model.KDA;
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
                
            }else {}
            
        }
    };
    [chooseVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:chooseVC animated:YES];
    
}
//清除阵容
- (IBAction)QC_BtnClick:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"message:@"确定清除阵容？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        self.PJ_Lab.text = @"0";
        self.Price_Lab.text = [NSString stringWithFormat:@"$%@",self.allGZ];
        
        self.Model1 = [[DJModel1Cell alloc] init];
        self.Model2 = [[DJModel2Cell alloc] init];
        self.Model3 = [[DJModel3Cell alloc] init];
        self.Model4 = [[DJModel4Cell alloc] init];
        self.Model5 = [[DJModel5Cell alloc] init];
        self.Model6 = [[DJModel6Cell alloc] init];
        self.Model7 = [[DJModel7Cell alloc] init];
        self.Model8 = [[DJModel8Cell alloc] init];
        
        
        self.SELView1.hidden = YES;
        self.OView1.hidden = NO;
        [self.icon_Btn1 setImage:[UIImage imageNamed:@"lol-defult"] forState:UIControlStateNormal];
        
        self.SELView2.hidden = YES;
        self.OView2.hidden = NO;
        [self.icon_Btn2 setImage:[UIImage imageNamed:@"lol-defult"] forState:UIControlStateNormal];
        
        
        self.SELView3.hidden = YES;
        self.OView3.hidden = NO;
        [self.icon_Btn3 setImage:[UIImage imageNamed:@"lol-defult"] forState:UIControlStateNormal];
        
        self.SELView4.hidden = YES;
        self.OView4.hidden = NO;
        [self.icon_Btn4 setImage:[UIImage imageNamed:@"lol-defult"] forState:UIControlStateNormal];
        
        self.SELView5.hidden = YES;
        self.OView5.hidden = NO;
        [self.icon_Btn5 setImage:[UIImage imageNamed:@"lol-defult"] forState:UIControlStateNormal];
        
        self.SELView6.hidden = YES;
        self.OView6.hidden = NO;
        [self.icon_Btn6 setImage:[UIImage imageNamed:@"lol-defult"] forState:UIControlStateNormal];
        
        self.SELView7.hidden = YES;
        self.OView7.hidden = NO;
        [self.icon_Btn7 setImage:[UIImage imageNamed:@"lol-defult"] forState:UIControlStateNormal];
        
        self.SELView8.hidden = YES;
        self.OView8.hidden = NO;
        [self.icon_Btn8 setImage:[UIImage imageNamed:@"lol-defult"] forState:UIControlStateNormal];
        
        //------------------清除阵容---网络请求
        //        [self initQCZRdata];
        
        
    }];
    
    [alertController addAction:noAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

//--------------------------------------------------------------------------------------------------------------警告-------------
//清除阵容---网络请求
- (void) initQCZRdata{
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=bet&a=revokelineup&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                @"id":self.Id,
                                @"lineup_id":self.C_lineup_ID, //所选阵容的id
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
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
}




#pragma mark - 一键推荐
- (IBAction)YJTJ_BtnClick:(UIButton *)sender {
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
                self.PJ_Lab.text = [NSString stringWithFormat:@"%0.1f",[[dictionary_EXdata objectForKey:@"score_sum"]floatValue]];
                self.Price_Lab.text = [NSString stringWithFormat:@"$%@",[dictionary_EXdata objectForKey:@"salary_sum"]];
                
                NSDictionary *dictionary_data = [dic objectForKey:@"data"];
                self.YJTJ_Dic = dictionary_data;
                
                for (DJ_PlayerListModelCell *model in self.DJ_listData) {
                    if([model.Id isEqualToString:[dictionary_data objectForKey:@"1"]]){
                        [self.icon_Btn1 yy_setImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@""]];
                        self.name1.text = model.name;
                        self.PJ_Lab1.text = [NSString stringWithFormat:@"%0.1f",model.average];
                        self.price1.text = [NSString stringWithFormat:@"$%@",model.salary];
                        self.SELView1.hidden = NO;
                        self.OView1.hidden = YES;
                        //-------------------------------
                        self.Model1 = [[DJModel1Cell alloc ]init];
                        self.Model1.name = model.name;
                        self.Model1.salary = model.salary;
                        self.Model1.Id = model.Id;
                        self.Model1.average = model.average;
                        self.Model1.KDA = model.KDA;
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
                        [self.icon_Btn2 yy_setImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@""]];
                        self.name2.text = model.name;
                        self.PJ_Lab2.text = [NSString stringWithFormat:@"%0.1f",model.average];
                        self.price2.text = [NSString stringWithFormat:@"$%@",model.salary];
                        self.SELView2.hidden = NO;
                        self.OView2.hidden = YES;
                        //-------------------------------
                        self.Model2 = [[DJModel2Cell alloc ]init];
                        self.Model2.name = model.name;
                        self.Model2.salary = model.salary;
                        self.Model2.Id = model.Id;
                        self.Model2.average = model.average;
                        self.Model2.KDA = model.KDA;
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
                        [self.icon_Btn3 yy_setImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@""]];
                        self.name3.text = model.name;
                        self.PJ_Lab3.text = [NSString stringWithFormat:@"%0.1f",model.average];
                        self.price3.text = [NSString stringWithFormat:@"$%@",model.salary];
                        self.SELView3.hidden = NO;
                        self.OView3.hidden = YES;
                        //-------------------------------
                        self.Model3 = [[DJModel3Cell alloc ]init];
                        self.Model3.name = model.name;
                        self.Model3.salary = model.salary;
                        self.Model3.Id = model.Id;
                        self.Model3.average = model.average;
                        self.Model3.KDA = model.KDA;
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
                        [self.icon_Btn4 yy_setImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@""]];
                        self.name4.text = model.name;
                        self.PJ_Lab4.text = [NSString stringWithFormat:@"%0.1f",model.average];
                        self.price4.text = [NSString stringWithFormat:@"$%@",model.salary];
                        self.SELView4.hidden = NO;
                        self.OView4.hidden = YES;
                        //-------------------------------
                        self.Model4 = [[DJModel4Cell alloc ]init];
                        self.Model4.name = model.name;
                        self.Model4.salary = model.salary;
                        self.Model4.Id = model.Id;
                        self.Model4.average = model.average;
                        self.Model4.KDA = model.KDA;
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
                        [self.icon_Btn5 yy_setImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@""]];
                        self.name5.text = model.name;
                        self.PJ_Lab5.text = [NSString stringWithFormat:@"%0.1f",model.average];
                        self.price5.text = [NSString stringWithFormat:@"$%@",model.salary];
                        self.SELView5.hidden = NO;
                        self.OView5.hidden = YES;
                        //-------------------------------
                        self.Model5 = [[DJModel5Cell alloc ]init];
                        self.Model5.name = model.name;
                        self.Model5.salary = model.salary;
                        self.Model5.Id = model.Id;
                        self.Model5.average = model.average;
                        self.Model5.KDA = model.KDA;
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
                        
                    }else if([model.Id isEqualToString:[dictionary_data objectForKey:@"6"]]){  //战队
                        [self.icon_Btn8 yy_setImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@""]];
                        self.name8.text = model.name;
                        self.PJ_Lab8.text = [NSString stringWithFormat:@"%0.1f",model.average];
                        self.price8.text = [NSString stringWithFormat:@"$%@",model.salary];
                        self.SELView8.hidden = NO;
                        self.OView8.hidden = YES;
                        //-------------------------------
                        self.Model6 = [[DJModel6Cell alloc ]init];
                        self.Model6.name = model.name;
                        self.Model6.salary = model.salary;
                        self.Model6.Id = model.Id;
                        self.Model6.average = model.average;
                        self.Model6.KDA = model.KDA;
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
                        [self.icon_Btn7 yy_setImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@""]];
                        self.name7.text = model.name;
                        self.PJ_Lab7.text = [NSString stringWithFormat:@"%0.1f",model.average];
                        self.price7.text = [NSString stringWithFormat:@"$%@",model.salary];
                        self.SELView7.hidden = NO;
                        self.OView7.hidden = YES;
                        //-------------------------------
                        self.Model7 = [[DJModel7Cell alloc ]init];
                        self.Model7.name = model.name;
                        self.Model7.salary = model.salary;
                        self.Model7.Id = model.Id;
                        self.Model7.average = model.average;
                        self.Model7.KDA = model.KDA;
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
                        [self.icon_Btn6 yy_setImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@""]];
                        self.name6.text = model.name;
                        self.PJ_Lab6.text = [NSString stringWithFormat:@"%0.1f",model.average];
                        self.price6.text = [NSString stringWithFormat:@"$%@",model.salary];
                        self.SELView6.hidden = NO;
                        self.OView6.hidden = YES;
                        //-------------------------------
                        self.Model8 = [[DJModel8Cell alloc ]init];
                        self.Model8.name = model.name;
                        self.Model8.salary = model.salary;
                        self.Model8.Id = model.Id;
                        self.Model8.average = model.average;
                        self.Model8.KDA = model.KDA;
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
                        //-------------------------
                        
                    }
                }
                
            }else{
                [AppDelegate notificationRequestInfoWithStatus:[dic objectForKey:@"msg"]];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
        
        
        
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



















@end




@implementation DJ1_PlayerListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [DJ1_PlayerListModelCell class]};
}
@end

@implementation DJ1_PlayerListModelCell
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id" };
}
@end

