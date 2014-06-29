//
//  SFLineChartView.h
//  spark-friends-ios
//
//  Created by Terry Worona on 6/26/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import "JBLineChartView.h"

// Model
#import "SFUser.h"

@class SFLineChartView;

@protocol SFLineChartViewDataSource <JBLineChartViewDataSource>

@optional

- (NSUInteger)minimumAverageInLineChartView:(JBLineChartView *)lineChartView;
- (NSUInteger)maximumAverageInLineChartView:(JBLineChartView *)lineChartView;

@end

@interface SFLineChartView : JBLineChartView

@property (nonatomic, weak) id<SFLineChartViewDataSource> dataSource;

@property (nonatomic, strong) SFUser *user;

@end
