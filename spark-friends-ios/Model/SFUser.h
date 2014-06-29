//
//  SFUser.h
//  spark-friends-ios
//
//  Created by Terry Worona on 6/10/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFUser : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSDate *createDate;
@property (nonatomic, strong) NSArray *steps;
@property (nonatomic, strong) UIImage *profileImage;

@end
