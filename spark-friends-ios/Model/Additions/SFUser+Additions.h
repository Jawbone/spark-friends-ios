//
//  SFUser+Additions.h
//  spark-friends-ios
//
//  Created by Terry Worona on 6/24/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import "SFUser.h"

@interface SFUser (Additions)

- (NSString *)fullName;
- (NSArray *)friends;

// Ranges across all friend's steps
- (CGFloat)maximumStepValue;
- (CGFloat)minimumStepValue;
- (CGFloat)averageStepValue;
- (CGFloat)stepRange;

@end
