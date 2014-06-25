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
NSUInteger static const kSFDataModelDaysInYear = 365;
NSUInteger static const kSFDataModelMaxUsers = 10;
NSUInteger static const kSFDataModelMaxStep = 15000;
NSUInteger static const kSFDataModelMinStep = 3000;
NSUInteger static const kSFDataModelTimeIntervalDay = 86400;

@interface SFDataModel ()

@property (nonatomic, strong) NSArray *users;
@property (nonatomic, strong) NSArray *firstNames;
@property (nonatomic, strong) NSArray *lastNames;

// Helpers
- (NSUInteger)randomStep;
- (NSString *)randomLastName;
- (NSString *)randomFirstName;

@end

@implementation SFDataModel

#pragma mark - Alloc/Init

+ (SFDataModel *)sharedInstance
{
    static dispatch_once_t pred;
    static SFDataModel *instance = nil;
    dispatch_once(&pred, ^{
        instance = [[self alloc] init];
    });
	return instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _firstNames = @[@"Shannon",
                        @"Barrie",
                        @"Tracy",
                        @"Terrance",
                        @"Ben",
                        @"Steve",
                        @"Kate",
                        @"Russ",
                        @"Laurel",
                        @"Jake"];

        _lastNames = @[@"Hale",
                        @"Smith",
                        @"McGee",
                        @"Gibb",
                        @"Weekes",
                        @"Barr",
                        @"Brannon",
                        @"Bundy",
                        @"Slater",
                        @"Thomas"];
    }
    return self;
}

#pragma mark - Getters

- (NSArray *)users
{
    if (_users == nil)
    {
        NSMutableArray *mutableUsers = [NSMutableArray array];
        for (NSUInteger userIndex=0; userIndex<kSFDataModelMaxUsers; userIndex++)
        {
            SFUser *user = [[SFUser alloc] init];
            user.firstName = [self randomFirstName];
            user.lastName = [self randomLastName];            
            NSMutableArray *mutableSteps = [NSMutableArray array];
            NSDate *baseDate = [NSDate date];
            for (NSUInteger dayIndex=0; dayIndex<kSFDataModelDaysInYear; dayIndex++)
            {
                NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:[baseDate timeIntervalSinceNow] - (kSFDataModelTimeIntervalDay * dayIndex)];
                SFStep *step = [[SFStep alloc] initWithValue:[self randomStep] createDate:createDate];
                [mutableSteps addObject:step];
            }
            user.steps = [NSArray arrayWithArray:mutableSteps];
            [mutableUsers addObject:user];
        }
        _users = [NSArray arrayWithArray:mutableUsers];
    }
    return _users;
}

#pragma mark - Helpers

- (NSUInteger)randomStep
{
    return ((arc4random() % (kSFDataModelMaxStep - kSFDataModelMinStep + 1)) + kSFDataModelMinStep);
}

- (NSString *)randomFirstName
{
    return [self.firstNames objectAtIndex:arc4random() % [self.firstNames count]];
}

- (NSString *)randomLastName
{
    return [self.lastNames objectAtIndex:arc4random() % [self.lastNames count]];
}

@end
