//
//  SFStep.h
//  spark-friends-ios
//
//  Created by Terry Worona on 6/10/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFStep : NSObject

- (id)initWithValue:(NSUInteger)value;

@property (nonatomic, readonly) NSUInteger value;

@end
