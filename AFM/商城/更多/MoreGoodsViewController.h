//
//  MoreGoodsViewController.h
//  AFM
//
//  Created by admin on 2017/9/6.
//  Copyright © 2017年 sgamer. All rights reserved.
//


@class GoodsAllListModel;
@class GoodsAllListModelCell;


#import "BaseViewController.h"



@interface MoreGoodsViewController : BaseViewController
@property (nonatomic , strong) NSString *typeName;


@end



@interface GoodsAllListModel : NSObject
@property (nonatomic, strong) NSMutableArray <GoodsAllListModelCell *> *data;
@end




@interface GoodsAllListModelCell : NSObject
@property (nonatomic, strong) NSString *avatar_img;          //图片
@property (nonatomic, strong) NSString *Id;                  //ID
@property (nonatomic, strong) NSString *name;                //商品名
@property (nonatomic, strong) NSString *nums;                //
@property (nonatomic, strong) NSString *price;               //价格
@property (nonatomic, strong) NSString *sell_num;            //卖出数量
@property (nonatomic, strong) NSString *shop_sub_id;         //商品的分类ID
@property (nonatomic, strong) NSString *type;                //1为砖石，2为木头
@end


/*
 {
	extra_data = (
 );
	data = (
 {
 "avatar_img" = "http://img3.sgamer.com/gift/201601/_569c5f27ddd8f1769.jpg";
 id = 12;
 "is_virtual" = 1;
 name = "\U66b4\U96ea\U6218\U7f51\U4e00\U5361\U901a 30\U5143\U6218\U7f51\U70b9\U6570";
 price = 3600;
 "sell_num" = 18;
 "shop_sub_id" = 11;
 type = 2;
 },
 {
 "avatar_img" = "http://static.aifamu.com/images/gift/201606/_574fce0eed0d61183.jpg";
 id = 22;
 "is_virtual" = 1;
 name = "\U957f\U8005\U4e4b\U68ee \U4e50\U8299\U5170";
 price = 11900;
 "sell_num" = 1;
 "shop_sub_id" = 9;
 type = 2;
 },
 {
 "avatar_img" = "http://static.aifamu.com/images/gift/201606/_574fcf619ea8d1006.jpg";
 id = 23;
 "is_virtual" = 1;
 name = "\U94f6\U6cb3\U9b54\U88c5\U673a\U795e \U5343\U73cf";
 price = 8300;
 "sell_num" = 1;
 "shop_sub_id" = 9;
 type = 2;
 },
 {
 "avatar_img" = "http://static.aifamu.com/images/gift/201606/_574fcfa7bbb6e9472.jpg";
 id = 24;
 "is_virtual" = 1;
 name = "\U94f6\U6cb3\U9b54\U88c5\U673a\U795e \U83f2\U5179";
 price = 8300;
 "sell_num" = 0;
 "shop_sub_id" = 9;
 type = 2;
 },
 {
 "avatar_img" = "http://static.aifamu.com/images/gift/201606/_574fd3929936a5703.jpg";
 id = 26;
 "is_virtual" = 1;
 name = "\U94f6\U6cb3\U9b54\U88c5\U673a\U795e \U5e0c\U74e6\U5a1c";
 price = 8300;
 "sell_num" = 0;
 "shop_sub_id" = 9;
 type = 2;
 },
 {
 "avatar_img" = "http://static.aifamu.com/images/gift/201606/_574fd4038a9184315.jpg";
 id = 27;
 "is_virtual" = 1;
 name = "\U5f17\U96f7\U5c14\U5353\U5fb7 \U5854\U8389\U57ad";
 price = 8300;
 "sell_num" = 0;
 "shop_sub_id" = 9;
 type = 2;
 },
 {
 "avatar_img" = "http://static.aifamu.com/images/gift/201606/_574fd45b4655f9023.jpg";
 id = 28;
 "is_virtual" = 1;
 name = "\U5ca9\U96c0 \U5854\U8389\U57ad";
 price = 5400;
 "sell_num" = 0;
 "shop_sub_id" = 9;
 type = 2;
 },
 {
 "avatar_img" = "http://static.aifamu.com/images/gift/201606/_574fd4b12da299191.jpg";
 id = 29;
 "is_virtual" = 1;
 name = "\U9ed1\U8272\U5929\U707e \U8f9b\U5409\U5fb7";
 price = 5400;
 "sell_num" = 0;
 "shop_sub_id" = 9;
 type = 2;
 },
 {
 "avatar_img" = "http://static.aifamu.com/images/gift/201606/_574fd4f1d7adc9823.jpg";
 id = 30;
 "is_virtual" = 1;
 name = "\U6076\U5492\U4ea1\U9b42 \U9b54\U817e";
 price = 5400;
 "sell_num" = 0;
 "shop_sub_id" = 9;
 type = 2;
 },
 {
 "avatar_img" = "http://static.aifamu.com/images/gift/201606/_574fd5181e8497097.jpg";
 id = 31;
 "is_virtual" = 1;
 name = "\U94a2\U94c1\U5ba1\U5224\U5b98 \U51ef\U5c14";
 price = 5400;
 "sell_num" = 1;
 "shop_sub_id" = 9;
 type = 2;
 }
 );
	msg = 获取成功;
	error = 0;
 }
 **/
