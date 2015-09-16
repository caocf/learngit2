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

@interface WALChildVehicleViewController () <UITableViewDataSource, UITableViewDelegate, PullTableViewDelegate>

@property (nonatomic, strong) PullTableView *tableView;
@property (nonatomic, strong) NSArray *contentsArray;
@property (nonatomic, strong) NSArray *carsArray;
@property (nonatomic, strong) NSArray *filterCarsArray;
@property (nonatomic, strong) WALCarService *carService;
@property (nonatomic, assign) YLYRunStatus runStatus;

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - actions

- (void)refreshTableView
{
    self.tableView.pullTableIsRefreshing = YES;
    [self.carService loadCarListWithType:_runStatus completion:^(BOOL success, NSArray *carsArray, WALStatusCount *statusCount, NSString *message) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:message];
        self.tableView.pullTableIsRefreshing = NO;
        if (success) {
            self.carsArray = self.filterCarsArray = carsArray;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    [self refreshTableView];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    self.tableView.pullTableIsLoadingMore = NO;
}

#pragma mark - tableViewDataSource/Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 32 * 3;
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
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", car.telPhone]]];
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

#pragma mark -- getter

- (PullTableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[PullTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64 - 44 - 49)];
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
