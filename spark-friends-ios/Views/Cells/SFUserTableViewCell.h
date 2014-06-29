//
//  SFUserTableViewCell.h
//  spark-friends-ios
//
//  Created by Terry Worona on 6/24/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import <UIKit/UIKit.h>

// Views
#import "SFLineChartView.h"

// Numerics
extern CGFloat const kSFUserTableViewCellHeight;

@interface SFUserTableViewCell : UITableViewCell

@property (nonatomic, readonly) UIImageView *userImageView;
@property (nonatomic, readonly) UILabel *nameLabel;
@property (nonatomic, readonly) UILabel *dateLabel;
@property (nonatomic, readonly) SFLineChartView *lineChartView;

@end
