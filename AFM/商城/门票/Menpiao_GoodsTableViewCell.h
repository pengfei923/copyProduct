//
//  Menpiao_GoodsTableViewCell.h
//  AFM
//
//  Created by 年少 on 2017/10/6.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MPvalueBlock) (NSString *MPvalue);


@interface Menpiao_GoodsTableViewCell : UITableViewCell
@property (copy, nonatomic) MPvalueBlock mpValueBlock;
@property (weak, nonatomic) IBOutlet UITextField *MP_field;

@end
