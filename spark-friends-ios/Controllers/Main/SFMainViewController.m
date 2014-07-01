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
#import "SFStep.h"

// Controllers
#import "SFBaseNavigationController.h"
#import "SFChartViewController.h"

// Enums
typedef NS_ENUM(NSInteger, SFMainViewControllerSection){
    SFMainViewControllerSectionCurrentUser,
	SFMainViewControllerSectionFriends,
    SFMainViewControllerSectionCount
};

// Strings
NSString * const kSFMainViewControllerCellIdentifier = @"kSFMainViewControllerCellIdentifier";

// Numerics
CGFloat static const kSFMainViewControllerLineChartLineWidth = 1.0f;
CGFloat static const kSFMainViewControllerSeparatorPadding = 10.0f;
NSUInteger static const kSFMainViewControllerChartLineCount = 1;

@interface SFMainViewController () <SFLineChartViewDataSource, JBLineChartViewDelegate>

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation SFMainViewController

#pragma mark - View Lifecycle

- (void)loadView
{
    [super loadView];

    self.title = kSFStringLabelProfile;
    self.view.backgroundColor = kSFColorBaseBackgroundColor;
    
    [self.tableView registerClass:[SFUserTableViewCell class] forCellReuseIdentifier:kSFMainViewControllerCellIdentifier];
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, kSFMainViewControllerSeparatorPadding, 0, 0)];
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

    cell.userImageView.image = user.profileImage;
    cell.nameLabel.text = [user fullName];
    cell.dateLabel.text = [NSString stringWithFormat:kSFStringLabelMemberSince, [self.dateFormatter stringFromDate:user.createDate]];
    
    cell.lineChartView.user = user;
    cell.lineChartView.delegate = self;
    cell.lineChartView.dataSource = self;
    cell.lineChartView.maximumValue = [[SFDataModel sharedInstance] maximumStepValue];
    cell.lineChartView.minimumValue = [[SFDataModel sharedInstance] minimumStepValue];
    
    [cell.lineChartView reloadData];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == SFMainViewControllerSectionCurrentUser)
    {
        return kSFStringLabelYou;
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
    return kSFUserTableViewCellHeight;
}

#pragma mark - SFLineChartViewDataSource

- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView;
{
    return kSFMainViewControllerChartLineCount;
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex
{
    if ([lineChartView isKindOfClass:[SFLineChartView class]])
    {
        return [((SFLineChartView *)lineChartView).user.steps count];
    }
    return 0;
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForLineAtLineIndex:(NSUInteger)lineIndex
{
    return kSFColorSparkChartLineColor;
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView widthForLineAtLineIndex:(NSUInteger)lineIndex
{
    return kSFMainViewControllerLineChartLineWidth;
}

- (NSUInteger)minimumAverageInLineChartView:(JBLineChartView *)lineChartView
{
    if ([lineChartView isKindOfClass:[SFLineChartView class]])
    {
        return [[SFDataModel sharedInstance] averageStepValue];
    }
    return 0;
}

- (NSUInteger)maximumAverageInLineChartView:(JBLineChartView *)lineChartView
{
    if ([lineChartView isKindOfClass:[SFLineChartView class]])
    {
        return [[SFDataModel sharedInstance] averageStepValue];
    }
    return 0;
}

#pragma mark - JBLineChartViewDelegate

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex
{
    if ([lineChartView isKindOfClass:[SFLineChartView class]])
    {
        SFUser *user = ((SFLineChartView *)lineChartView).user;
        SFStep *step =  [user.steps objectAtIndex:horizontalIndex];
        return step.value;
    }
    return 0.0f;
}

- (BOOL)lineChartView:(JBLineChartView *)lineChartView smoothLineAtLineIndex:(NSUInteger)lineIndex
{
    return YES;
}

#pragma mark - Getters

- (NSDateFormatter *)dateFormatter
{
    if (_dateFormatter == nil)
    {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterShortStyle];
    }
    return _dateFormatter;
}

@end
