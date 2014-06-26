//
//  SFChartFooterView.h
//  spark-friends-ios
//
//  Created by Terry Worona on 6/26/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFChartFooterView : UIView

@property (nonatomic, assign) NSInteger sectionCount;
@property (nonatomic, readonly) UILabel *leftLabel;
@property (nonatomic, readonly) UILabel *centerLabel;
@property (nonatomic, readonly) UILabel *rightLabel;

@end
