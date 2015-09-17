//
//  WALAreaVehicleViewController.m
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALAreaVehicleViewController.h"
#import "WALAreaTotalVehicleViewController.h"
#import "WALAreaTableViewCell.h"
#import "WALCarService.h"
#import "WALArea.h"

@interface WALAreaVehicleViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UILabel *resultLabel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *areaArray;
@property (nonatomic, strong) NSArray *filterAreaArray;
@property (nonatomic, strong) WALCarService *carService;

@end

@implementation WALAreaVehicleViewController

- (id)init
{
    if (self = [super init]) {
        _carService = [[WALCarService alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupResultLabelWithCarArray:[NSArray array]];
    [self.tableView reloadData];
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"正在获取数据,请稍候..."];
    [self.carService loadAreaList:^(BOOL success, NSArray *areaArray, NSString *message) {
        [DejalBezelActivityView removeView];
        [[TKAlertCenter defaultCenter] postAlertWithMessage:message];
        if (success) {
            self.filterAreaArray = self.areaArray = areaArray;
            [self setupResultLabelWithCarArray:areaArray];
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)filterWithText
{
    NSMutableArray *filterList = [NSMutableArray array];
    if (self.searchBar.text.length > 0) {
        NSPredicate *predicateName = [NSPredicate predicateWithFormat:@"name contains [cd] %@", self.searchBar.text];
        [filterList addObjectsFromArray:[self.areaArray  filteredArrayUsingPredicate:predicateName]];
        self.filterAreaArray = filterList;
    } else {
        self.filterAreaArray = self.areaArray;
    }
    [self setupResultLabelWithCarArray:self.filterAreaArray];
    [self.tableView reloadData];
}

- (void)setupResultLabelWithCarArray:(NSArray *)carArray
{
    if (carArray.count > 0) {
        NSString *numString = [@(carArray.count) stringValue];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"查询到%@个有车辆的区域", numString]];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(3, numString.length)];
        self.resultLabel.attributedText = str;
    } else {
        self.resultLabel.text = @"此区域中无车辆";
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self filterWithText];
}

#pragma mark - tableViewDataSource/Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.filterAreaArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kWALAreaTableViewCell = @"kWALAreaTableViewCell";
    WALAreaTableViewCell *areaTableViewCell = [tableView dequeueReusableCellWithIdentifier:kWALAreaTableViewCell];
    if (areaTableViewCell == nil) {
        areaTableViewCell = [[WALAreaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kWALAreaTableViewCell];
    }
    WALArea *area = self.filterAreaArray[indexPath.row];
    areaTableViewCell.width = self.tableView.width;
    areaTableViewCell.area = area;
    return areaTableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WALAreaTotalVehicleViewController *totalVehicleViewController = [[WALAreaTotalVehicleViewController alloc] init];
    totalVehicleViewController.area = self.filterAreaArray[indexPath.row];
    totalVehicleViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:totalVehicleViewController animated:YES];
}

#pragma mark - getter

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
        _searchBar.barTintColor = [UIColor whiteColor];
        _searchBar.layer.borderColor = RGB(kLineColor).CGColor;
        _searchBar.layer.borderWidth = 0.5;
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索区域名称";
        [self.view addSubview:_searchBar];
    }
    return _searchBar;
}

- (UILabel *)resultLabel
{
    if (!_resultLabel) {
        _resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.searchBar.bottom, self.view.width, 32)];
        _resultLabel.textColor = RGB(0x666666);
        _resultLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_resultLabel];
    }
    return _resultLabel;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.resultLabel.bottom, self.view.width, self.view.height - 64 - self.resultLabel.bottom - 49) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
