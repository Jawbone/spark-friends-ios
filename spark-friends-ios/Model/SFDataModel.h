//
//  SFDataModel.h
//  spark-friends-ios
//
//  Created by Terry Worona on 6/10/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import <Foundation/Foundation.h>

// Models
#import "SFUser.h"

@interface SFDataModel : NSObject

+ (SFDataModel *)sharedInstance;
- (SFUser *)currentUser;

@end
