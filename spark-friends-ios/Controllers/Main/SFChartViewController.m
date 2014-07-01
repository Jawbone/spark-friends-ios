//
//  SFChartViewController.m
//  spark-friends-ios
//
//  Created by Terry Worona on 6/26/14.
//  Copyright (c) 2014 Jawbone. All rights reserved.
//

#import "SFChartViewController.h"

// Models
#import "SFDataModel.h"
#import "SFUser+Additions.h"
#import "SFStep.h"

// Views
#import "SFLineChartView.h"
#import "SFChartFooterView.h"
#import "SFChartHeaderView.h"

// Numerics
CGFloat static const kSFChartViewContainerPadding = 20.0f;
CGFloat static const kSFChartViewContainerHeaderHeight = 40.0f;
CGFloat static const kSFChartViewContainerFooterHeight = 30.0f;
CGFloat static const kSFChartViewContainerLineChartLineWidth = 3.0f;
NSUInteger static const kSFChartViewControllerFooterSectionCount = 2;
NSUInteger static const kSFChartViewControllerChartLineCount = 1;

@interface SFChartViewContainer : UIView

@property (nonatomic, strong) SFLineChartView *lineChartView;

@end

@interface SFChartViewController () <JBLineChartViewDelegate, SFLineChartViewDataSource>

@property (nonatomic, strong) SFUser *user;
@property (nonatomic, strong) SFChartViewContainer *chartContainer;

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
    self.title = [self.user fullName];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.chartContainer = [[SFChartViewContainer alloc] initWithFrame:self.view.bounds];
    self.view = self.chartContainer;

    self.chartContainer.lineChartView.delegate = self;
    self.chartContainer.lineChartView.dataSource = self;

    self.chartContainer.lineChartView.maximumValue = [[SFDataModel sharedInstance] maximumStepValue];
    self.chartContainer.lineChartView.minimumValue = [[SFDataModel sharedInstance] minimumStepValue];
    
    SFChartHeaderView *headerView = [[SFChartHeaderView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, kSFChartViewContainerHeaderHeight)];
    headerView.titleLabel.text = kSFStringLabelAnnualStepData;
    self.chartContainer.lineChartView.headerView = headerView;

    SFChartFooterView *footerView = [[SFChartFooterView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, kSFChartViewContainerFooterHeight)];
    footerView.sectionCount = kSFChartViewControllerFooterSectionCount;
    footerView.leftLabel.text = [kSFStringLabelJan uppercaseString];
    footerView.rightLabel.text = [kSFStringLabelDec uppercaseString];
    footerView.centerLabel.text = kSFStringLabel2013;
    self.chartContainer.lineChartView.footerView = footerView;
    
    [self.chartContainer.lineChartView reloadData];
}

#pragma mark - Buttons

- (void)closeButtonPressed:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - SFLineChartViewDataSource

- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView;
{
    return kSFChartViewControllerChartLineCount;
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex
{
    return [self.user.steps count];
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForLineAtLineIndex:(NSUInteger)lineIndex
{
    return kSFColorChartLineColor;
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView widthForLineAtLineIndex:(NSUInteger)lineIndex
{
    return kSFChartViewContainerLineChartLineWidth;
}

- (NSUInteger)minimumAverageInLineChartView:(JBLineChartView *)lineChartView
{
    return [[SFDataModel sharedInstance] minimumAverageStepValue];
}

- (NSUInteger)maximumAverageInLineChartView:(JBLineChartView *)lineChartView
{
    return [[SFDataModel sharedInstance] maximumAverageStepValue];
}

#pragma mark - JBLineChartViewDelegate

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex
{
    SFStep *step = [self.user.steps objectAtIndex:horizontalIndex];
    return step.value;
}

- (BOOL)lineChartView:(JBLineChartView *)lineChartView smoothLineAtLineIndex:(NSUInteger)lineIndex
{
    return YES;
}

@end

@implementation SFChartViewContainer

#pragma mark - Alloc/Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = kSFColorBaseBackgroundColor;
        
        _lineChartView = [[SFLineChartView alloc] initWithFrame:self.bounds];
        _lineChartView.backgroundColor = kSFColorBaseBackgroundColor;
        _lineChartView.showsLineSelection = NO;
        _lineChartView.showsVerticalSelection = NO;
        [self addSubview:_lineChartView];
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.lineChartView.frame = CGRectMake(kSFChartViewContainerPadding, kSFChartViewContainerPadding, self.bounds.size.width - (kSFChartViewContainerPadding * 2), self.bounds.size.height - (kSFChartViewContainerPadding * 2));
    [self.lineChartView reloadData];
}

@end
