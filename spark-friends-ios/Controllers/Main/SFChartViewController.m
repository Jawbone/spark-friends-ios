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
#import "SFStep.h"

// Views
#import "SFLineChartView.h"

// Numerics
NSUInteger static const kSFChartViewContainerPadding = 10;

@interface SFChartViewContainer : UIView

@property (nonatomic, strong) JBLineChartView *lineChartView;

@end

@interface SFChartViewController () <JBLineChartViewDataSource, SFLineChartViewDelegate>

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
    
    [self.chartContainer.lineChartView reloadData];
}

#pragma mark - Buttons

- (void)closeButtonPressed:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - JBLineChartViewDataSource

- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView;
{
    return 1;
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex
{
    return [self.user.steps count];
}

#pragma mark - SFLineChartViewDelegate

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
        
        _lineChartView = [[JBLineChartView alloc] initWithFrame:self.bounds];
        _lineChartView.backgroundColor = kSFColorBaseBackgroundColor;
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
