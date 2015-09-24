//
//  WALTotalVehicleViewController.m
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALChildVehicleViewController.h"
#import "WALCarDetailViewController.h"
#import "WALCarPositionViewController.h"
#import "WALFindCarTrackViewController.h"
#import "WALCarTableViewCell.h"
#import "PullTableView.h"
#import "WALCarService.h"

@interface WALChildVehicleViewController () <UITableViewDataSource, UITableViewDelegate, PullTableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) PullTableView *tableView;
@property (nonatomic, strong) NSArray *contentsArray;
@property (nonatomic, strong) NSMutableArray *filterCarsArray;
@property (nonatomic, strong) WALCarService *carService;
@property (nonatomic, assign) YLYRunStatus runStatus;
@property (nonatomic, assign) BOOL hasMore;

@end

@implementation WALChildVehicleViewController

- (id)initWithType:(YLYRunStatus)runStatus
{
    if (self = [super init]) {
        _carService = [[WALCarService alloc] init];
        _runStatus = runStatus;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView reloadData];
    [self refreshTableView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)dealloc
{
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    _tableView.pullDelegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - actions

- (void)refreshTableView
{
    self.tableView.pullTableIsRefreshing = YES;
    [self.carService resetCarListOffset];
    [self.carService loadCarListWithType:_runStatus completion:^(BOOL success, BOOL hasMore, NSArray *carsArray, WALStatusCount *statusCount, NSString *message) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:message];
        self.tableView.pullTableIsRefreshing = NO;
        self.hasMore = hasMore;
        if (success) {
            self.filterCarsArray = [NSMutableArray arrayWithArray:carsArray];
            [self.tableView reloadData];
        }
    }];
}

- (CGFloat)cellHeightWithCar:(WALCar *)car
{
    NSString *info = [NSString stringWithFormat:@"%@;%@", car.eInfo, car.aInfo];
    NSArray *infoArray = [info componentsSeparatedByString:@";"];
    CGFloat outGap = 8;
    CGFloat inGap = 5;
    CGFloat widthLimit = self.tableView.width - outGap * 2;
    CGFloat labelHeight = 10 + 2 *inGap;
    CGFloat totalWidth = 0;
    CGFloat totalHeight = 97;
    BOOL hasInfoLabel = NO;
    for (NSString *string in infoArray) {
        if (string.length <= 0) {
            continue;
        }
        hasInfoLabel = YES;
        CGFloat labelWidth = [string sizeWithFont:Font(10)].width + inGap * 2;
        if (totalWidth + labelWidth > widthLimit) {
            totalHeight += labelHeight + outGap;
            totalWidth = labelWidth + outGap;
        } else {
            totalWidth += labelWidth + outGap;
        }
    }
    if (hasInfoLabel) {
        return totalHeight + labelHeight + 10;
    } else {
        return totalHeight;
    }
}

#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    [self refreshTableView];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    if (!_hasMore) {
        self.tableView.pullTableIsLoadingMore = NO;
        return;
    }
    [self.carService loadCarListWithType:_runStatus completion:^(BOOL success, BOOL hasMore, NSArray *carsArray, WALStatusCount *statusCount, NSString *message) {
        self.tableView.pullTableIsLoadingMore = NO;
        if (success) {
            [self.filterCarsArray addObjectsFromArray:carsArray];
            self.hasMore = hasMore;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - tableViewDataSource/Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WALCar *car = self.filterCarsArray[indexPath.row];
    return [self cellHeightWithCar:car] + 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.filterCarsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kWALCarTableViewCell = @"kWALCarTableViewCell";
    WALCarTableViewCell *carTableViewCell = [tableView dequeueReusableCellWithIdentifier:kWALCarTableViewCell];
    if (carTableViewCell == nil) {
        carTableViewCell = [[WALCarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kWALCarTableViewCell];
    }
    WALCar *car = self.filterCarsArray[indexPath.row];
    carTableViewCell.width = self.tableView.width;
    carTableViewCell.phoneBlock = ^(WALCar *car) {
        if (car.telPhone.length > 0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确认拨打电话" message:car.telPhone delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            [alertView show];
        }
    };
    carTableViewCell.positionBlock = ^(WALCar *car) {
        WALCarPositionViewController *carPositionViewController = [[WALCarPositionViewController alloc] init];
        carPositionViewController.car = car;
        carPositionViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:carPositionViewController animated:YES];
    };
    carTableViewCell.trackBlock = ^(WALCar *car) {
        WALFindCarTrackViewController *findCarTrackViewController = [[WALFindCarTrackViewController alloc] init];
        findCarTrackViewController.car = car;
        findCarTrackViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:findCarTrackViewController animated:YES];
    };
    [carTableViewCell setCar:car];
    return carTableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WALCarDetailViewController *carDetailViewController = [[WALCarDetailViewController alloc] init];
    carDetailViewController.car = self.filterCarsArray[indexPath.row];
    carDetailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:carDetailViewController animated:YES];
}

#pragma mark -- alertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", alertView.message]]];
    }
}

#pragma mark -- getter

- (PullTableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[PullTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64 - 44 - 49)];
        _tableView.backgroundColor = RGB(0xf0f0f0);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.pullDelegate = self;
        _tableView.pullTableViewEnable = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
