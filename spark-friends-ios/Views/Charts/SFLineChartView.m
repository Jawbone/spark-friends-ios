//
//  SFLineChartView.m
//  spark-friends-ios
//
//  Created by Terry Worona on 6/26/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import "SFLineChartView.h"

@interface SFLineChartView ()

@property (nonatomic, strong) UIView *averageRangeView;

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
        _averageRangeView.backgroundColor = [UIColor redColor];
        [self addSubview:_averageRangeView];
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
    
    NSUInteger maximumAverage = 0;
    if ([self.dataSource respondsToSelector:@selector(maximumAverageInLineChartView:)])
    {
        maximumAverage = [self.dataSource maximumAverageInLineChartView:self];
    }
    
    
    
    
    self.averageRangeView.frame = CGRectMake(0, 50, self.bounds.size.width, self.bounds.size.height - 100);
}

#pragma mark - Data

- (void)reloadData
{
    [super reloadData];
    self.averageRangeView.hidden = !(([self.dataSource respondsToSelector:@selector(minimumAverageInLineChartView:)] && [self.dataSource respondsToSelector:@selector(maximumAverageInLineChartView:)]));
}

@end
