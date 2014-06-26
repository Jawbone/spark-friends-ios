//
//  SFLineChartView.h
//  spark-friends-ios
//
//  Created by Terry Worona on 6/26/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import "JBLineChartView.h"

@class SFLineChartView;

@protocol SFLineChartViewDelegate <JBLineChartViewDelegate>

@end

@interface SFLineChartView : JBLineChartView

@property (nonatomic, weak) id<SFLineChartViewDelegate> delegate;

@end
