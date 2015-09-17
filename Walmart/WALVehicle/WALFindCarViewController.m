//
//  WALFindCarViewController.m
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALFindCarViewController.h"
#import "WALChooseView.h"
#import "WALFindCarTableViewCell.h"
#import "WALCarService.h"
#import "WALSimpleCar.h"

@interface WALFindCarViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UIButton *provinceButton;
@property (nonatomic, strong) UIButton *letterButton;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) WALChooseView *chooseView;
@property (nonatomic, strong) UIButton *currentButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *carsArray;
@property (nonatomic, strong) NSArray *filterCarsArray;
@property (nonatomic, strong) WALCarService *carService;

@end

@implementation WALFindCarViewController
{
    CGFloat _buttonWidth;
    CGFloat _buttonGap;
    CGFloat _buttonVerticalGap;
    BOOL _filtered;
    BOOL _filteredProvice;
    BOOL _filteredCity;
}

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
    self.navigationItem.title = @"查询车辆";
    
    _buttonWidth = 44;
    _buttonGap = 8;
    _buttonVerticalGap = 5;
    _filtered = NO;
    _filteredProvice = NO;
    _filteredCity = NO;
    self.searchBar.hidden = NO;
    [self.tableView reloadData];
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"正在获取数据,请稍候..."];
    [self.carService loadSimpleCarList:^(BOOL success, NSArray *simpleCarList, NSString *message) {
        [DejalBezelActivityView removeView];
        [[TKAlertCenter defaultCenter] postAlertWithMessage:message];
        if (success) {
            self.filterCarsArray = self.carsArray = simpleCarList;
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - actions

- (void)filterWithText
{
    NSString *searchText = @"";
    if (_filteredProvice) {
        searchText = [searchText stringByAppendingString:self.provinceButton.titleLabel.text];
    }
    if (_filteredCity) {
        searchText = [searchText stringByAppendingString:self.letterButton.titleLabel.text];
    }
    searchText = [searchText stringByAppendingString:self.searchBar.text];
    NSLog(@"searchText:%@", searchText);
    NSMutableArray *filterList = [NSMutableArray array];
    
    NSPredicate *predicateRegName = [NSPredicate predicateWithFormat:@"regName contains [cd] %@", searchText];
    [filterList addObjectsFromArray:[self.carsArray  filteredArrayUsingPredicate:predicateRegName]];
    
    self.filterCarsArray = filterList;
    [self.tableView reloadData];
}

- (void)didClickProvinceButton:(id)sender
{
    [self.searchBar resignFirstResponder];
    self.currentButton = self.provinceButton;
    self.chooseView.title = @"选择省代号";
    self.chooseView.dataArray = @[@"京", @"津", @"沪", @"渝", @"冀", @"晋", @"蒙", @"辽", @"吉", @"黑", @"苏", @"浙", @"皖", @"闽", @"赣", @"鲁", @"豫", @"鄂", @"湘", @"粤", @"桂", @"琼", @"川", @"贵", @"云", @"藏", @"陕", @"甘", @"青", @"宁", @"新", @"港", @"澳", @"台"];
    [self.chooseView showInView:self.view];
}

- (void)didClickLetterButton:(id)sender
{
    [self.searchBar resignFirstResponder];
    self.currentButton = self.letterButton;
    self.chooseView.title = @"选择市代号";
    self.chooseView.dataArray = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    [self.chooseView showInView:self.view];
}

- (void)didClickSelectedIndex:(NSInteger)selectedIndex
{
    _filtered = YES;
    if (self.currentButton == self.provinceButton) {
        [self.provinceButton setTitle:self.chooseView.dataArray[selectedIndex] forState:UIControlStateNormal];
        _filteredProvice = YES;
    } else if (self.currentButton == self.letterButton) {
        [self.letterButton setTitle:self.chooseView.dataArray[selectedIndex] forState:UIControlStateNormal];
        _filteredCity = YES;
    }
    [self filterWithText];
}
#pragma mark - tableViewDataSource/Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.filterCarsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kWALFindCarTableViewCell = @"kWALFindCarTableViewCell";
    WALFindCarTableViewCell *findCarTableViewCell = [tableView dequeueReusableCellWithIdentifier:kWALFindCarTableViewCell];
    if (findCarTableViewCell == nil) {
        findCarTableViewCell = [[WALFindCarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kWALFindCarTableViewCell];
    }
    WALSimpleCar *simpleCar = self.filterCarsArray[indexPath.row];
    findCarTableViewCell.width = self.tableView.width;
    findCarTableViewCell.simpleCar = simpleCar;
    return findCarTableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_selectedBlock) {
        _selectedBlock(self.filterCarsArray[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.provinceButton.hidden = self.letterButton.hidden = NO;
    self.searchBar.left = self.letterButton.right + _buttonGap;
    self.searchBar.width = self.view.width - self.searchBar.left - _buttonGap;
    self.searchBar.placeholder = @"车牌号";
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    _filtered = YES;
    [self filterWithText];
}

#pragma mark - getter

- (UIButton *)provinceButton
{
    if (!_provinceButton) {
        _provinceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _provinceButton.frame = CGRectMake(_buttonGap, _buttonVerticalGap, _buttonWidth, 44 - _buttonVerticalGap * 2);
        [_provinceButton setTitleColor:RGB(0x666666) forState:UIControlStateNormal];
        [_provinceButton addTarget:self action:@selector(didClickProvinceButton:) forControlEvents:UIControlEventTouchUpInside];
        [_provinceButton setTitle:@"省" forState:UIControlStateNormal];
        _provinceButton.hidden = YES;
        [self.view addSubview:_provinceButton];
    }
    return _provinceButton;
}

- (UIButton *)letterButton
{
    if (!_letterButton) {
        _letterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _letterButton.frame = CGRectMake(self.provinceButton.right + _buttonGap, _buttonVerticalGap, _buttonWidth, 44 - _buttonVerticalGap * 2);
        [_letterButton setTitleColor:RGB(0x666666) forState:UIControlStateNormal];
        [_letterButton addTarget:self action:@selector(didClickLetterButton:) forControlEvents:UIControlEventTouchUpInside];
        [_letterButton setTitle:@"市" forState:UIControlStateNormal];
        _letterButton.hidden = YES;
        [self.view addSubview:_letterButton];
    }
    return _letterButton;
}

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, _buttonVerticalGap, self.view.width - 2 * _buttonGap, 44 - 2 * _buttonVerticalGap)];
        _searchBar.barTintColor = [UIColor whiteColor];
        _searchBar.layer.borderColor = RGB(kLineColor).CGColor;
        _searchBar.layer.borderWidth = 0.5;
        _searchBar.delegate = self;
        _searchBar.placeholder = @"请输入车辆名称";
        [self.view addSubview:_searchBar];
    }
    return _searchBar;
}

- (WALChooseView *)chooseView
{
    if (!_chooseView) {
        _chooseView = [[WALChooseView alloc] initWithFrame:CGRectZero];
        __weak typeof(self) weakSelf = self;
        _chooseView.selectBlock = ^(NSInteger selectedIndex) {
            [weakSelf didClickSelectedIndex:selectedIndex];
        };
    }
    return _chooseView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.width, self.view.height - 64 - 44) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
