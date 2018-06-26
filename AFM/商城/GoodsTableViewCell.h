//
//  GoodsTableViewCell.h
//  AFM
//
//  Created by admin on 2017/9/5.
//  Copyright © 2017年 sgamer. All rights reserved.
//

@class GoodsListModel;
@class GoodsListModelCell;
@class GoodsModel_Info;


#import <UIKit/UIKit.h>

@interface GoodsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Top_Lab;
@property (weak, nonatomic) IBOutlet UIButton *more_Btn;
@property (nonatomic, strong) GoodsListModelCell *model;
@property (nonatomic, strong) UIViewController *controller;


@end

@interface GoodsListModel : NSObject
@property (nonatomic, strong) NSMutableArray <GoodsListModelCell *> *data;
@end




@interface GoodsListModelCell : NSObject
@property (nonatomic, strong) NSString *list;                 //
@property (nonatomic, strong) NSMutableArray <GoodsModel_Info *> *goods;           //
@end



@interface GoodsModel_Info : NSObject
@property (nonatomic, strong) NSString *avatar_img;          //图片
@property (nonatomic, strong) NSString *Id;                  //ID
@property (nonatomic, strong) NSString *name;                //商品名
@property (nonatomic, strong) NSString *nums;                //
@property (nonatomic, strong) NSString *price;               //价格
@property (nonatomic, strong) NSString *sell_num;            //卖出数量
@property (nonatomic, strong) NSString *shop_sub_id;         //商品的分类ID
@property (nonatomic, strong) NSString *type;                //1为砖石，2为木头
@end
