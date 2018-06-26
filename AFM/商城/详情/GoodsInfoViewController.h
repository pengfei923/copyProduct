//
//  GoodsInfoViewController.h
//  AFM
//
//  Created by admin on 2017/9/6.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "BaseViewController.h"

@class GoodsInfoModel;
@class GoodsInfoIMGModelCell;
@interface GoodsInfoViewController : BaseViewController


@property (nonatomic , strong) GoodsInfoModel  *GoodsInfoModel;

@property (nonatomic, strong) NSString *goods_ID;


@property (nonatomic, strong) NSString *name_L;
@property (nonatomic, strong) NSString *phone_L;
@property (nonatomic, strong) NSString *addr_L;
@property (nonatomic, strong) NSString *NumF;
@property (nonatomic, strong) NSString *ID_L;
@end


@interface GoodsInfoModel : NSObject
@property (nonatomic, strong) NSString *avatar_img;          //商品的缩略图
@property (nonatomic, strong) NSString *Id;                  //ID
@property (nonatomic, strong) NSString *name;                //商品名
@property (nonatomic, strong) NSString *attr_id;             //属性ID（虚拟商品属性ID为空）
@property (nonatomic, strong) NSString *album_id;            //相册ID
@property (nonatomic, strong) NSString *detail;              //商品详情
@property (nonatomic, assign) NSString *has_nums;            //库存数量
@property (nonatomic, strong) NSString *hot_sort;            //是否为热门商品
@property (nonatomic, strong) NSString *intro;                //商品描述
@property (nonatomic, strong) NSString *is_virtual;           //是否为虚拟商品
@property (nonatomic, strong) NSString *price;                //价格
@property (nonatomic, strong) NSString *remain_num;           //单人最大购买数量
@property (nonatomic, strong) NSString *state;                //是否上架
@property (nonatomic, strong) NSString *type;                 //商品消耗资源类型1为砖石，2为木头（实物必须为木头）

@property (nonatomic , strong) NSMutableArray  *album;


@end


@interface GoodsInfoIMGModelCell : NSObject


@end

//@interface GoodsInfoModelCell : NSObject
//@property (nonatomic, strong) NSString *avatar_img;          //商品的缩略图
//@property (nonatomic, strong) NSString *Id;                  //ID
//@property (nonatomic, strong) NSString *name;                //商品名
//@property (nonatomic, strong) NSString *attr_id;             //属性ID（虚拟商品属性ID为空）
//@property (nonatomic, strong) NSString *album_id;            //相册ID
//@property (nonatomic, strong) NSString *detail;              //商品详情
//@property (nonatomic, strong) NSString *has_nums;            //库存数量
//@property (nonatomic, strong) NSString *hot_sort;            //是否为热门商品
//
//
//@property (nonatomic, strong) NSString *intro;                //商品描述
//@property (nonatomic, strong) NSString *is_virtual;           //是否为虚拟商品
//@property (nonatomic, strong) NSString *price;                //价格
//@property (nonatomic, strong) NSString *remain_num;           //单人最大购买数量
//@property (nonatomic, strong) NSString *state;                //是否上架
//@property (nonatomic, strong) NSString *type;                 //商品消耗资源类型1为砖石，2为木头（实物必须为木头）
//

//@property (nonatomic , strong) NSMutableArray <GoodsInfoIMGModelCell   *> *album;

//@end



