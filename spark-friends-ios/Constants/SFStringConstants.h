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
#define kSFStringLabelYou localize(@"label.you", @"You")
#define kSFStringLabelFriends localize(@"label.friends", @"Friends")
#define kSFStringLabelClose localize(@"label.close", @"Close")
#define kSFStringLabelJan localize(@"label.jan", @"Jan")
#define kSFStringLabelDec localize(@"label.dec", @"Dec")
#define kSFStringLabel2013 localize(@"label.2013", @"2013")
#define kSFStringLabelMemberSince localize(@"label.member.since", @"Member since %@")
