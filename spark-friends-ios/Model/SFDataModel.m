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
#import "SFUser+Additions.h"

// Numerics
NSUInteger static const kSFDataModelMonthsInYear = 12;
NSUInteger static const kSFDataModelDaysInYear = 365;
NSUInteger static const kSFDataModelMaxUsers = 10;
NSUInteger static const kSFDataModelMaxStep = 15000;
NSUInteger static const kSFDataModelMinStep = 3000;

@interface SFDataModel ()

@property (nonatomic, strong) NSArray *users;
@property (nonatomic, strong) NSArray *firstNames;
@property (nonatomic, strong) NSArray *lastNames;

// Helpers
- (NSUInteger)randomStep;
- (NSString *)randomLastName;
- (NSString *)randomFirstName;
- (NSDate *)randomCreateDate;
- (UIImage *)randomProfileImageWithGender:(SFUserGender)gender;

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

- (SFUser *)currentUser
{
    return [self.users firstObject];
}

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
            user.createDate = [self randomCreateDate];
            user.profileImage =  [self randomProfileImageWithGender:[user gender]];
            
            NSMutableArray *mutableSteps = [NSMutableArray array];
            for (NSUInteger dayIndex=0; dayIndex<kSFDataModelMonthsInYear; dayIndex++)
            {
                SFStep *step = [[SFStep alloc] initWithValue:[self randomStep]];
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

- (NSDate *)randomCreateDate
{
    NSUInteger minimumDate = kSFDataModelDaysInYear;
    NSUInteger maximumDate = kSFDataModelDaysInYear * 3;
    u_int32_t randomDays = arc4random_uniform(maximumDate - minimumDate + 1) + minimumDate;
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:today];
    [dateComponents setDay:dateComponents.day - randomDays];
    return [calendar dateFromComponents:dateComponents];
}

- (UIImage *)randomProfileImageWithGender:(SFUserGender)gender
{
    // TODO - real random images
    return [UIImage imageNamed:@"profile_photo_male_1.png"];
}

@end
