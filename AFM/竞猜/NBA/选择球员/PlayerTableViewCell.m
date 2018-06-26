//
//  PlayerTableViewCell.m
//  AFM
//
//  Created by admin on 2017/9/14.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "PlayerTableViewCell.h"
@interface PlayerTableViewCell (){
    PNLineChart *lineChart;
}

@end

@implementation PlayerTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"PlayerTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self initView];
    }
    return self;
}


- (void)initView{
    self.biao_Lab.layer.masksToBounds = YES;
    self.biao_Lab.layer.cornerRadius = 4;
    self.daiD_Lab.layer.masksToBounds = YES;
    self.daiD_Lab.layer.cornerRadius = 4;
    //曲线图
    lineChart = [[PNLineChart alloc]initWithFrame:CGRectMake(0, 0, 220, 70)];
    //设置背景颜色
    lineChart.backgroundColor = [UIColor clearColor];
    lineChart.axisWidth = 1.0;
    [lineChart setXLabels:@[@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" "]];
    [lineChart setYLabels:@[@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" "]];

    [self.qulineView addSubview:lineChart];


}

- (void)setModel:(Player_ListModelCell *)Model {
    // Line Chart No.1
    NSMutableArray *data01Array = Model.last_ten_score;
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = [UIColor redColor];
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // Line Chart No.2
    NSMutableArray *AAAAAA = [[NSMutableArray alloc] init];
    for(int i = 0;i < 10;i++){
        AAAAAA[i] = [NSString stringWithFormat:@"%0.2f",Model.average];
    }
    NSMutableArray * data02Array = AAAAAA;
    PNLineChartData *data02 = [PNLineChartData new];
    data02.color = [UIColor grayColor];
    data02.itemCount = lineChart.xLabels.count;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    lineChart.chartData = @[data01, data02];
    [lineChart strokeChart];
}





@end
