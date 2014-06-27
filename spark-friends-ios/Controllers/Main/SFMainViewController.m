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

// Model
#import "SFDataModel.h"
#import "SFUser+Additions.h"

// Controllers
#import "SFBaseNavigationController.h"
#import "SFChartViewController.h"

// Numerics
CGFloat static const kSFMainViewControllerCellHeight = 100.0f;

// Enums
typedef NS_ENUM(NSInteger, SFMainViewControllerSection){
    SFMainViewControllerSectionCurrentUser,
	SFMainViewControllerSectionFriends,
    SFMainViewControllerSectionCount
};

// Strings
NSString * const kSFMainViewControllerCellIdentifier = @"kSFMainViewControllerCellIdentifier";

@interface SFMainViewController () <SFLineChartViewDataSource, JBLineChartViewDelegate>

@end

@implementation SFMainViewController

#pragma mark - View Lifecycle

- (void)loadView
{
    [super loadView];

    self.title = kSFStringLabelProfile;
    self.view.backgroundColor = kSFColorBaseBackgroundColor;
    
    [self.tableView registerClass:[SFUserTableViewCell class] forCellReuseIdentifier:kSFMainViewControllerCellIdentifier];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return SFMainViewControllerSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == SFMainViewControllerSectionCurrentUser)
    {
        return 1;
    }
    else if (section == SFMainViewControllerSectionFriends)
    {
        return [[[SFDataModel sharedInstance].currentUser friends] count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SFUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSFMainViewControllerCellIdentifier forIndexPath:indexPath];
    
    SFUser *user;
    if (indexPath.section == SFMainViewControllerSectionCurrentUser)
    {
        user = [SFDataModel sharedInstance].currentUser;
    }
    else if (indexPath.section == SFMainViewControllerSectionFriends)
    {
        user = [[[SFDataModel sharedInstance].currentUser friends] objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = [user fullName];
    cell.lineChartView.delegate = self;
    cell.lineChartView.dataSource = self;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == SFMainViewControllerSectionCurrentUser)
    {
        return kSFStringLabelCurrentUser;
    }
    else if (section == SFMainViewControllerSectionFriends)
    {
        return kSFStringLabelFriends;
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SFUser *user;
    if (indexPath.section == SFMainViewControllerSectionCurrentUser)
    {
        user = [SFDataModel sharedInstance].currentUser;
    }
    else if (indexPath.section == SFMainViewControllerSectionFriends)
    {
        user = [[[SFDataModel sharedInstance].currentUser friends] objectAtIndex:indexPath.row];
    }
    
    SFChartViewController *chartViewController = [[SFChartViewController alloc] initWithUser:user];
    SFBaseNavigationController *navigationController = [[SFBaseNavigationController alloc] initWithRootViewController:chartViewController];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kSFMainViewControllerCellHeight;
}

#pragma mark - SFLineChartViewDataSource

- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView;
{
    return 1;
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex
{
    return 2;
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForLineAtLineIndex:(NSUInteger)lineIndex
{
    return [UIColor blueColor];
}

#pragma mark - JBLineChartViewDelegate

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex
{
    return horizontalIndex % 2 == 0 ? 10 : 50;
}

- (BOOL)lineChartView:(JBLineChartView *)lineChartView smoothLineAtLineIndex:(NSUInteger)lineIndex
{
    return YES;
}

@end
