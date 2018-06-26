//
//  Top_JCTableViewCell.h
//  AFM
//
//  Created by admin on 2017/9/12.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol headDelegate <NSObject>

@optional
- (void)refreshHead:(NSString *)Tag;

@end

@interface Top_JCTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *downBankImgView;

@property (weak, nonatomic) IBOutlet UILabel *time_Lab;
@property (weak, nonatomic) IBOutlet UIView *tagView;

@property (weak, nonatomic) IBOutlet UILabel *men_Lab;
@property (weak, nonatomic) IBOutlet UILabel *jiang_Lab;
@property (weak, nonatomic) IBOutlet UILabel *zhu_Lab;
@property (weak, nonatomic) IBOutlet UILabel *gozhu_Lab;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIView *line3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIView *line4;
@property (weak, nonatomic) IBOutlet UIImageView *img_jiang;

@property (weak, nonatomic) IBOutlet UIImageView *biao_image1;
@property (weak, nonatomic) IBOutlet UIImageView *biao_image2;
@property (weak, nonatomic) IBOutlet UIImageView *biao_image3;


@property(nonatomic,assign)id<headDelegate>delegate;
@property(nonatomic,strong)NSString *Tag;

@end
