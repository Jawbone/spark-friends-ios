//
//  SFUserTableViewCell.m
//  spark-friends-ios
//
//  Created by Terry Worona on 6/24/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import "SFUserTableViewCell.h"

// Numerics
CGFloat const kSFUserTableViewCellPadding = 10.0f;

@implementation SFUserTableViewCell

#pragma mark - Alloc/Init

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _userImageView = [[UIImageView alloc] init];
        _userImageView.backgroundColor = [UIColor redColor];
        [self addSubview:_userImageView];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor purpleColor];
        [self addSubview:_nameLabel];
        
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:_dateLabel];
        
        _lineChartView = [[SFLineChartView alloc] init];
        _lineChartView.backgroundColor = [UIColor blackColor];
        [self addSubview:_lineChartView];
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // User image
    CGSize userImageViewSize = CGSizeMake(self.bounds.size.height - (kSFUserTableViewCellPadding * 2), self.bounds.size.height - (kSFUserTableViewCellPadding * 2));
    self.userImageView.frame = CGRectMake(kSFUserTableViewCellPadding, kSFUserTableViewCellPadding, userImageViewSize.width, userImageViewSize.height);
    
    // Line chart
    CGSize chartViewSize = CGSizeMake(self.bounds.size.height - (kSFUserTableViewCellPadding * 2), self.bounds.size.height - (kSFUserTableViewCellPadding * 2));
    self.lineChartView.frame = CGRectMake(self.bounds.size.width - chartViewSize.width - kSFUserTableViewCellPadding, kSFUserTableViewCellPadding, chartViewSize.width, chartViewSize.height);

    CGFloat availableLabelWidth = self.bounds.size.width - self.userImageView.frame.size.width - self.lineChartView.frame.size.width - (kSFUserTableViewCellPadding * 4);
    
    // Labels
    self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.userImageView.frame) + kSFUserTableViewCellPadding, kSFUserTableViewCellPadding, availableLabelWidth, 30);
    self.dateLabel.frame = CGRectMake(CGRectGetMaxX(self.userImageView.frame) + kSFUserTableViewCellPadding, CGRectGetMaxY(self.nameLabel.frame), availableLabelWidth, 30);
}

@end
