//
//  SFChartViewController.m
//  spark-friends-ios
//
//  Created by Terry Worona on 6/26/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import "SFChartViewController.h"

// Models
#import "SFUser+Additions.h"

@interface SFChartViewController ()

@property (nonatomic, strong) SFUser *user;

@end

@implementation SFChartViewController

#pragma mark - Alloc/Init

- (id)initWithUser:(SFUser *)user
{
    self = [super init];
    if (self)
    {
        _user = user;
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)loadView
{
    [super loadView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:kSFStringLabelClose style:UIBarButtonItemStyleBordered target:self action:@selector(closeButtonPressed:)];
    self.view.backgroundColor = kSFColorBaseBackgroundColor;
    self.title = [self.user fullName];
}

#pragma mark - Buttons

- (void)closeButtonPressed:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
