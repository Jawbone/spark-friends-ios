//
//  SFColorConstants.h
//  spark-friends-ios
//
//  Created by Terry Worona on 6/24/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#define UIColorFromHex(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]

#pragma mark - Base

#define kSFColorBaseBackgroundColor UIColorFromHex(0xf5f4f0)
#define kSFColorChartLineColor UIColorFromHex(0x222222)
#define kSFColorChartFooterSeparatorColor UIColorFromHex(0x222222)
#define kSFColorChartFooterSideTextColor UIColorFromHex(0x222222)
#define kSFColorChartFooterCenterTextColor UIColorFromHex(0x787878)
