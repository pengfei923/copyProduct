//
//  MessageTableViewCell.m
//  AFM
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "MessageTableViewCell.h"

@interface MessageTableViewCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left;

@end

@implementation MessageTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MessageTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


- (void)initView{
    self.YandN.layer.masksToBounds = YES;
    self.YandN.layer.cornerRadius = 6;
}

- (void)setModel:(MessageListModelCell *)Model{
    if ([Model.state isEqualToString:@"1"]) {  //未读
        self.YandN.hidden = NO;
        self.left.constant = 28;
    }else{
        self.YandN.hidden = YES;
        self.left.constant = 12;
    }
}

@end
