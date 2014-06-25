//
//  SFMainViewController.m
//  spark-friends-ios
//
//  Created by Terry Worona on 6/10/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import "SFMainViewController.h"

// Views
#import "SFUserTableViewCell.h"

// Strings
NSString * const kSFMainViewControllerCellIdentifier = @"kSFMainViewControllerCellIdentifier";

@interface SFMainViewController ()

@end

@implementation SFMainViewController

#pragma mark - View Lifecycle

- (void)loadView
{
    [super loadView];

    self.title = kSFStringLabelProfile;
    
    [self.tableView registerClass:[SFUserTableViewCell class] forCellReuseIdentifier:kSFMainViewControllerCellIdentifier];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SFUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSFMainViewControllerCellIdentifier forIndexPath:indexPath];
    return cell;
}

@end
