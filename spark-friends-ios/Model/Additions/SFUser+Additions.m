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
#import "SFStep.h"

@interface SFDataModel (Private)

- (NSArray *)users;

@end

@implementation SFUser (Additions)

#pragma mark - Getters

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

- (CGFloat)maximumStepValue
{
    NSArray *allUsers = [self.friends arrayByAddingObject:self];
    NSUInteger currentMaxStepValue = 0;
    for (SFUser *user in allUsers)
    {
        for (SFStep *step in user.steps)
        {
            if (step.value > currentMaxStepValue)
            {
                currentMaxStepValue = step.value;
            }
        }
    }
    return currentMaxStepValue;
}

- (CGFloat)minimumStepValue
{
    NSArray *allUsers = [self.friends arrayByAddingObject:self];
    NSUInteger currentMinStepValue = INT_MAX;
    for (SFUser *user in allUsers)
    {
        for (SFStep *step in user.steps)
        {
            if (step.value < currentMinStepValue)
            {
                currentMinStepValue = step.value;
            }
        }
    }
    return currentMinStepValue;
}

- (CGFloat)averageStepValue
{
    NSArray *allUsers = [self.friends arrayByAddingObject:self];
    NSUInteger totalStepValue = 0;
    NSUInteger totalStepCount = 0;
    for (SFUser *user in allUsers)
    {
        for (SFStep *step in user.steps)
        {
            totalStepValue += step.value;
            totalStepCount++;
        }
    }    
    return totalStepValue / totalStepCount;
}

- (CGFloat)stepRange
{
    return abs([self maximumStepValue] - [self minimumStepValue]);
}

#pragma mark - Demographics

- (SFUserGender)gender
{
    if ([self.firstName isEqualToString:@"Shannon"] ||
        [self.firstName isEqualToString:@"Tracy"] ||
        [self.firstName isEqualToString:@"Kate"] ||
        [self.firstName isEqualToString:@"Laurel"])
    {
        return SFUserGenderFemale;
    }
    return SFUserGenderMale;
}

@end
