//
//  Top_PlayerTableViewCell.m
//  AFM
//
//  Created by admin on 2017/9/14.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "Top_PlayerTableViewCell.h"
@interface Top_PlayerTableViewCell (){
    PNLineChart *lineChart;
}

@end

@implementation Top_PlayerTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"Top_PlayerTableViewCell" owner:nil options:nil];
        self = [nib firstObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
        [self initData];

    }
    return self;
}


- (void)initView{
    
    [self initPNChartView];
    self.money_Lab.layer.masksToBounds = YES;
    self.money_Lab.layer.cornerRadius  = 6;

    //曲线图
    lineChart = [[PNLineChart alloc]initWithFrame:CGRectMake(0, 0, 220, 70)];
    //设置背景颜色
    lineChart.backgroundColor = [UIColor clearColor];
    lineChart.axisWidth = 1.0;
    [lineChart setXLabels:@[@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" "]];
    [lineChart setYLabels:@[@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" "]];
    
    [self.quView addSubview:lineChart];

}

- (void)setModel:(Player_ModelCell *)Model {
        
    // Line Chart No.1
    NSMutableArray *data01Array = Model.last_ten_score;
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = [UIColor whiteColor];
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // Line Chart No.2
    NSMutableArray *AAAAAA = [[NSMutableArray alloc] init];
    for(int i = 0;i < 10;i++){
        AAAAAA[i] = [NSString stringWithFormat:@"%0.2f",Model.player_data.average];
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


- (void)initData {

    int Avg_number = [self.pjfen intValue];
    int Num_number = [self.play_num intValue];
    int Time_number = [self.play_time intValue];
    self.chart.chartType = PNChartFormatTypeNone;
    self.chart1.chartType = PNChartFormatTypeNone;
    self.chart2.chartType = PNChartFormatTypeNone;
    self.chart.current = [NSNumber numberWithInt:Avg_number];
    self.chart1.current = [NSNumber numberWithInt:Num_number];
    self.chart2.current = [NSNumber numberWithInt:Time_number];
    [self.chart strokeChart];
    [self.chart1 strokeChart];
    [self.chart2 strokeChart];
}
//进度圆圈
- (void)initPNChartView{
    //平均分
    self.chart = [[PNCircleChart alloc] initWithFrame:CGRectMake((self.lableview.bounds.size.width - 30)/2, (self.lableview.bounds.size.height - 30)/2-5, 30, 30)
                                                total:[NSNumber numberWithInt:100]
                                              current:[NSNumber numberWithInt:0]
                                            clockwise:YES
                                               shadow:YES
                                          shadowColor:[UIColor getColorWithdown]
                                 displayCountingLabel:YES
                                    overrideLineWidth:[NSNumber numberWithInt:3]];
    
    self.chart.backgroundColor = [UIColor clearColor];
    [self.chart setStrokeColor:[UIColor getColorWithTheme]];
    self.chart.countingLabel.font = [UIFont systemFontOfSize:8];
    [self.lableview addSubview:self.chart];
    
    //出场次数
    self.chart1 = [[PNCircleChart alloc] initWithFrame:CGRectMake((self.lableview.bounds.size.width - 30)/2, (self.lableview.bounds.size.height - 30)/2-5, 30, 30)
                                                 total:[NSNumber numberWithInt:100]
                                               current:[NSNumber numberWithInt:0]
                                             clockwise:YES
                                                shadow:YES
                                           shadowColor:[UIColor getColorWithdown]
                                  displayCountingLabel:YES
                                     overrideLineWidth:[NSNumber numberWithInt:3]];
    
    self.chart1.backgroundColor = [UIColor clearColor];
    [self.chart1 setStrokeColor:[UIColor getColorWithTheme]];
    self.chart1.countingLabel.font = [UIFont systemFontOfSize:8];
    [self.Lableview1 addSubview:self.chart1];
    
    
    
    //场均时间
    self.chart2 = [[PNCircleChart alloc] initWithFrame:CGRectMake((self.lableview.bounds.size.width - 30)/2, (self.lableview.bounds.size.height - 30)/2-5, 30, 30)
                                                 total:[NSNumber numberWithInt:100]
                                               current:[NSNumber numberWithInt:0]
                                             clockwise:YES
                                                shadow:YES
                                           shadowColor:[UIColor getColorWithdown]
                                  displayCountingLabel:YES
                                     overrideLineWidth:[NSNumber numberWithInt:3]];
    
    self.chart2.backgroundColor = [UIColor clearColor];
    [self.chart2 setStrokeColor:[UIColor getColorWithTheme]];
    self.chart2.countingLabel.font = [UIFont systemFontOfSize:8];
    [self.Lableview2 addSubview:self.chart2];
}

@end
