//
//  SFDataModel.m
//  spark-friends-ios
//
//  Created by Terry Worona on 6/10/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import "SFDataModel.h"

// Models
#import "SFStep.h"

// Numerics
NSUInteger static const kSFDataModelDaysInYear = 365; // 1 year
NSUInteger static const kSFDataModelMaxStep = 15000;
NSUInteger static const kSFDataModelMinStep = 3000;

@interface SFDataModel ()

@property (nonatomic, strong) SFUser *user;
@property (nonatomic, strong) NSArray *friends;

// Helpers
- (NSUInteger)randomStep;

@end

@implementation SFDataModel

#pragma mark - Getters

- (SFUser *)user
{
    if (_user == nil)
    {
        _user = [[SFUser alloc] init];
        _user.firstName = @"John";
        _user.lastName = @"Doe";
        
        NSMutableArray *mutableSteps = [NSMutableArray array];
        for (NSUInteger dayIndex=0; dayIndex<kSFDataModelDaysInYear; dayIndex++)
        {
            SFStep *step = [[SFStep alloc] initWithValue:[self randomStep] createDate:[NSDate date]];
            [mutableSteps addObject:step];
        }
        _user.steps = [NSArray arrayWithArray:mutableSteps];
    }
    return _user;
}

- (NSArray *)friends
{
    if (_friends == nil)
    {
        
    }
    return _friends;
}

#pragma mark - Helpers

- (NSUInteger)randomStep
{
    return ((arc4random() % (kSFDataModelMaxStep - kSFDataModelMinStep + 1)) + kSFDataModelMinStep);
}

@end
