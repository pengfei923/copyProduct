//
//  MyInfoTableViewCell.m
//  AFM
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "MyInfoTableViewCell.h"
#import "AddZuanViewController.h"
#import "MenpiaoViewController.h"

@implementation MyInfoTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MyInfoTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
    self.icon_Img.layer.masksToBounds = YES;
    self.icon_Img.layer.cornerRadius = 30;

    //上架原因
//    self.CZ_Img.hidden = YES;
}

//钻石充值
- (IBAction)zuanBtnClick:(UIButton *)sender {
    if (self.controller) {
        //上架原因
        AddZuanViewController *addZ = [[AddZuanViewController alloc]init];
        addZ.hidesBottomBarWhenPushed = YES;
        [self.controller.navigationController pushViewController:addZ animated:YES];
    }

}

//门票购买
- (IBAction)menBtnClick:(UIButton *)sender {
    if (self.controller) {
        //上架原因
        MenpiaoViewController *infoView = [[MenpiaoViewController alloc]init];
        infoView.hidesBottomBarWhenPushed = YES;
        [self.controller.navigationController pushViewController:infoView animated:YES];
    }
    
}

- (IBAction)muBtnClick:(UIButton *)sender {
    
    
}

@end
