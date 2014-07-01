//
//  SFLineChartView.m
//  spark-friends-ios
//
//  Created by Terry Worona on 6/26/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import "SFLineChartView.h"

#import "SFDataModel.h"

@interface SFLineChartView ()

@property (nonatomic, strong) UIView *averageRangeView;
@property (nonatomic, strong) UILabel *lastValueLabel;

@end

@interface JBLineChartView (Private)

- (CGFloat)availableHeight;

@end

@implementation SFLineChartView

#pragma mark - Alloc/Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _averageRangeView = [[UIView alloc] init];
        _averageRangeView.backgroundColor = kSFColorRangeViewBackgroundColor;
        [self addSubview:_averageRangeView];
        
        _lastValueLabel = [[UILabel alloc] init];
        [self addSubview:_lastValueLabel];
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger minimumAverage = 0;
    if ([self.dataSource respondsToSelector:@selector(minimumAverageInLineChartView:)])
    {
        minimumAverage = [self.dataSource minimumAverageInLineChartView:self];
    }
    CGFloat yOffsetTop = (((CGFloat)minimumAverage) / self.maximumValue) * [self availableHeight];
    
    NSUInteger maximumAverage = 0;
    if ([self.dataSource respondsToSelector:@selector(maximumAverageInLineChartView:)])
    {
        maximumAverage = [self.dataSource maximumAverageInLineChartView:self];
    }
    CGFloat yOffsetBottom = (((CGFloat)maximumAverage) / self.maximumValue) * [self availableHeight];
    
    NSLog(@"minimum %d maximum %d and average %f", minimumAverage, maximumAverage, [[SFDataModel sharedInstance] averageStepValue]);
    
    self.averageRangeView.frame = CGRectMake(0, yOffsetTop, self.bounds.size.width, self.bounds.size.height - yOffsetTop - yOffsetBottom);
}

#pragma mark - Data

- (void)reloadData
{
    [super reloadData];
    self.averageRangeView.hidden = !(([self.dataSource respondsToSelector:@selector(minimumAverageInLineChartView:)] && [self.dataSource respondsToSelector:@selector(maximumAverageInLineChartView:)]));
}

@end
