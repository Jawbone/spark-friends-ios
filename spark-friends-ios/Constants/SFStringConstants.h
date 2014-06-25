//
//  SFStringConstants.h
//  spark-friends-ios
//
//  Created by Terry Worona on 6/24/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#define localize(key, default) NSLocalizedStringWithDefaultValue(key, nil, [NSBundle mainBundle], default, nil)

#pragma mark - Labels

#define kSFStringLabelProfile localize(@"label.profile", @"Profile")
