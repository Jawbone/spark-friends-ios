//
//  SFUser+Additions.m
//  spark-friends-ios
//
//  Created by Terry Worona on 6/24/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import "SFUser+Additions.h"

// Model
#import "SFDataModel.h"

@interface SFDataModel (Private)

- (NSArray *)users;

@end

@implementation SFUser (Additions)

- (NSString *)fullName
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

- (NSArray *)friends
{
    NSArray *masterUserUsers = [[SFDataModel sharedInstance] users];
    NSArray *friends = [masterUserUsers subarrayWithRange:NSMakeRange(1, [masterUserUsers count] - 1)];
    return friends;
}

@end
