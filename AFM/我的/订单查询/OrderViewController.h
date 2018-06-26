//
//  OrderViewController.h
//  AFM
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BaseViewController.h"

@class OrderListModel;
@class OrderListModelCell;
@class OrderInfoModelCell;

@interface OrderViewController : BaseViewController

@property (nonatomic , strong) OrderInfoModelCell *infoCell;

@end


@interface OrderListModel : NSObject
@property (nonatomic, strong) NSArray<OrderListModelCell *> *data;


@end


@interface OrderListModelCell : NSObject
@property (nonatomic , strong) NSString *address_id;      //为0表示虚拟商品
@property (nonatomic , strong) NSString *addtime;         //时间
@property (nonatomic , strong) NSString *avatar_img;      //图片
@property (nonatomic , strong) NSString *goods_nums;      //数量
@property (nonatomic , strong) NSString *Id;              //商品id号
@property (nonatomic , strong) NSString *name;            //商品名称
@property (nonatomic , strong) NSString *numbers;         //sn_201710100708389453
@property (nonatomic , strong) NSString *price;           //价格
@property (nonatomic , strong) NSString *shop_sub_id;     //8 商品的分类ID
@property (nonatomic , strong) NSString *status;          //2。订单状态1为未发货、2为已发货、3为已签收；虚拟物品不显示
@property (nonatomic , strong) NSString *type;            //2  1为砖石，2为木头

@end




@interface OrderInfoModelCell : NSObject
@property (nonatomic , strong) NSString *name;         //名称
@property (nonatomic , strong) NSString *nums;         //数量
@property (nonatomic , strong) NSMutableArray *codes_list;      //虚拟
@property (nonatomic , strong) NSString *company;         //韵达--实物
@property (nonatomic , strong) NSString *track_num;       //运单号--实物

@end
