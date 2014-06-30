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

// Enums
typedef NS_ENUM(NSUInteger, SFDataModelMockUserType){
	SFDataModelMockUserType1,
    SFDataModelMockUserType2,
    SFDataModelMockUserType3,
    SFDataModelMockUserType4,
    SFDataModelMockUserType5,
    SFDataModelMockUserType6,
    SFDataModelMockUserType7,
    SFDataModelMockUserType8,
    SFDataModelMockUserType9,
    SFDataModelMockUserType10,
    SFDataModelMockUserTypeCount
};

// Numerics
NSUInteger static const kSFDataModelMonthsInYear = 12;
NSUInteger static const kSFDataModelDaysInYear = 365;
NSUInteger static const kSFDataModelMaxStep = 15000;
NSUInteger static const kSFDataModelMinStep = 3000;

@interface SFDataModel ()

@property (nonatomic, strong) NSArray *users;

// Random helpers
- (NSUInteger)randomStep;
- (NSDate *)randomCreateDate;

// Users helpers
- (SFUser *)generateMockUserType:(SFDataModelMockUserType)userType;

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
        for (NSUInteger userIndex=0; userIndex<SFDataModelMockUserTypeCount; userIndex++)
        {
            SFUser *user = [self generateMockUserType:userIndex];
            
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

#pragma mark - Random Helpers

- (NSUInteger)randomStep
{
    return ((arc4random() % (kSFDataModelMaxStep - kSFDataModelMinStep + 1)) + kSFDataModelMinStep);
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

- (SFUser *)generateMockUserType:(SFDataModelMockUserType)userType
{
    SFUser *mockUser = [[SFUser alloc] init];
    mockUser.createDate = [self randomCreateDate];

    if (userType == SFDataModelMockUserType1)
    {
        mockUser.firstName = @"Terry";
        mockUser.lastName = @"Worona";
        mockUser.profileImage = [UIImage imageNamed:@"profile_photo_mock_user_1.png"];
    }
    else if (userType == SFDataModelMockUserType2)
    {
        
    }
    else if (userType == SFDataModelMockUserType3)
    {
        
    }
    else if (userType == SFDataModelMockUserType4)
    {
        
    }
    else if (userType == SFDataModelMockUserType5)
    {
        
    }
    else if (userType == SFDataModelMockUserType6)
    {
        
    }
    else if (userType == SFDataModelMockUserType7)
    {
        
    }
    else if (userType == SFDataModelMockUserType8)
    {
        
    }
    else if (userType == SFDataModelMockUserType9)
    {
        
    }
    else if (userType == SFDataModelMockUserType10)
    {
        
    }
    
    return mockUser;
}

@end
