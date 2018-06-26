//
//  AddZuanTableViewCell.h
//  AFM
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^isSH_CBlock) (NSString *isSH_C);
typedef void (^PriceBlock) (NSString *Price);

@interface AddZuanTableViewCell : UITableViewCell
@property (copy, nonatomic) PriceBlock PriceValueBlock;
@property (copy, nonatomic) isSH_CBlock isSH_Block;

@property (weak, nonatomic) IBOutlet UIImageView *SC_View1;
@property (weak, nonatomic) IBOutlet UIImageView *SC_View2;
@property (weak, nonatomic) IBOutlet UIImageView *SC_View3;
@property (weak, nonatomic) IBOutlet UIImageView *SC_View4;
@property (weak, nonatomic) IBOutlet UIImageView *SC_View5;
@property (weak, nonatomic) IBOutlet UIImageView *SC_View6;

@property (nonatomic, strong) NSString *isSH_C;  //是否首充  1 是  2  否


@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;

//赠送钻石
@property (weak, nonatomic) IBOutlet UILabel *SzLab1;
@property (weak, nonatomic) IBOutlet UILabel *SzLab2;
@property (weak, nonatomic) IBOutlet UILabel *SzLab3;
@property (weak, nonatomic) IBOutlet UILabel *SzLab4;
@property (weak, nonatomic) IBOutlet UILabel *SzLab5;
@property (weak, nonatomic) IBOutlet UILabel *SzLab6;

//钻石间距
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ZandP1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ZandP2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ZandP3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ZandP4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ZandP5;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ZandP6;


//钻石
@property (weak, nonatomic) IBOutlet UILabel *zLab1;
@property (weak, nonatomic) IBOutlet UILabel *zLab2;
@property (weak, nonatomic) IBOutlet UILabel *zLab3;
@property (weak, nonatomic) IBOutlet UILabel *zLab4;
@property (weak, nonatomic) IBOutlet UILabel *zLab5;
@property (weak, nonatomic) IBOutlet UILabel *zLab6;

//钻石价格
@property (weak, nonatomic) IBOutlet UILabel *mLab1;
@property (weak, nonatomic) IBOutlet UILabel *mLab2;
@property (weak, nonatomic) IBOutlet UILabel *mLab3;
@property (weak, nonatomic) IBOutlet UILabel *mLab4;
@property (weak, nonatomic) IBOutlet UILabel *mLab5;
@property (weak, nonatomic) IBOutlet UILabel *mLab6;





@end
