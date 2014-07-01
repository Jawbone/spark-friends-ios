//
//  SFChartHeaderView.m
//  spark-friends-ios
//
//  Created by Terry Worona on 6/30/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import "SFChartHeaderView.h"

@interface SFChartHeaderView ()

@property (nonatomic, strong) UIView *underlineView;

@end

@implementation SFChartHeaderView

#pragma mark - Alloc/Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:18.0];
        _titleLabel.textColor = [UIColor blackColor];
        [self addSubview:_titleLabel];
        
        _underlineView = [[UIView alloc] init];
        _underlineView.backgroundColor = [UIColor blackColor];
        [self addSubview:_underlineView];
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize titleLabelSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    self.titleLabel.frame = CGRectMake(ceil(self.bounds.size.width * 0.5) - ceil(titleLabelSize.width * 0.5), self.bounds.origin.y, titleLabelSize.width, titleLabelSize.height);
    self.underlineView.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame), titleLabelSize.width, 0.5f);
}

@end
