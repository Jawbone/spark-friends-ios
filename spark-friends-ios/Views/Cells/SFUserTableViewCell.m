//
//  SFUserTableViewCell.m
//  spark-friends-ios
//
//  Created by Terry Worona on 6/24/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import "SFUserTableViewCell.h"

// Quartz
#import <QuartzCore/QuartzCore.h>

// Numerics
CGFloat const kSFUserTableViewCellPadding = 10.0f;
CGFloat const kSFUserTableViewCellHeight = 80.0f;
CGFloat const kSFUserTableViewCellNameLabelHeight = 25.0f;
CGFloat const kSFUserTableViewCellDateLabelHeight = 15.0f;

@interface SFUserTableViewCell ()

// Getters
- (CGSize)userImageViewSize;
- (CGRect)userImageViewRect;

- (CGSize)lineChartViewSize;
- (CGRect)lineChartViewRect;

@end

@implementation SFUserTableViewCell

#pragma mark - Alloc/Init

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _userImageView = [[UIImageView alloc] initWithFrame:[self userImageViewRect]];
        _userImageView.layer.cornerRadius = ceil([self userImageViewRect].size.width * 0.5);
        _userImageView.layer.masksToBounds = YES;
        [self addSubview:_userImageView];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.numberOfLines = 1;
        _nameLabel.font = [UIFont boldSystemFontOfSize:16.0];
        _nameLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_nameLabel];
        
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.numberOfLines = 1;
        _dateLabel.font = [UIFont italicSystemFontOfSize:12.0];
        _dateLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_dateLabel];
        
        _lineChartView = [[SFLineChartView alloc] initWithFrame:[self lineChartViewRect]];
        [self addSubview:_lineChartView];
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // User image
    self.userImageView.frame = [self userImageViewRect];
    
    // Line chart
    self.lineChartView.frame = [self lineChartViewRect];

    CGFloat availableLabelWidth = self.bounds.size.width - self.userImageView.frame.size.width - self.lineChartView.frame.size.width - (kSFUserTableViewCellPadding * 4);
    
    // Labels
    self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.userImageView.frame) + kSFUserTableViewCellPadding, kSFUserTableViewCellPadding, availableLabelWidth, kSFUserTableViewCellNameLabelHeight);
    self.dateLabel.frame = CGRectMake(CGRectGetMaxX(self.userImageView.frame) + kSFUserTableViewCellPadding, CGRectGetMaxY(self.nameLabel.frame), availableLabelWidth, kSFUserTableViewCellDateLabelHeight);
}

#pragma mark - Getters

- (CGSize)userImageViewSize
{
    return CGSizeMake(kSFUserTableViewCellHeight - (kSFUserTableViewCellPadding * 2), kSFUserTableViewCellHeight - (kSFUserTableViewCellPadding * 2));
}

- (CGRect)userImageViewRect
{
    return CGRectMake(kSFUserTableViewCellPadding, kSFUserTableViewCellPadding, [self userImageViewSize].width, [self userImageViewSize].height);
}

- (CGSize)lineChartViewSize
{
    return CGSizeMake(kSFUserTableViewCellHeight - (kSFUserTableViewCellPadding * 2), kSFUserTableViewCellHeight - (kSFUserTableViewCellPadding * 2));
}

- (CGRect)lineChartViewRect
{
    return CGRectMake(self.bounds.size.width - [self lineChartViewSize].width - kSFUserTableViewCellPadding, kSFUserTableViewCellPadding, [self lineChartViewSize].width, [self lineChartViewSize].height);
}

@end
