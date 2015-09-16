//
//  WALFindCarTrackViewController.m
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALFindCarTrackViewController.h"
#import "WALCarTrackViewController.h"
#import "WALFindCarViewController.h"
#import "WALTipsButton.h"

@interface WALFindCarTrackViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) WALTipsButton *plateNumberButton;
@property (nonatomic, strong) WALTipsButton *timeButton;
@property (nonatomic, strong) UITextField *timeTextField;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) NSString *vehicleID;
@property (nonatomic, strong) NSString *plateNumber;

@end

@implementation WALFindCarTrackViewController
{
    NSArray *_timeArray;
    NSInteger _selectedTimeRow;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"查询车辆轨迹";
    
    self.plateNumberButton.tips = @"车牌号码";
    self.timeButton.tips = @"查询时长";
    [self.searchButton setTitle:@"查询" forState:UIControlStateNormal];
    _timeArray = @[@"今天", @"昨天", @"三天内"];
    _selectedTimeRow = 0;
    self.vehicleID = self.car.vehicleID;
    self.plateNumber = self.car.regName;
    self.plateNumberButton.value = self.car.regName;
    self.timeButton.value = _timeArray[_selectedTimeRow];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didClickPlateNumberButton:(id)sender
{
    WALFindCarViewController *findCarViewController = [[WALFindCarViewController alloc] init];
    findCarViewController.selectedBlock = ^(WALSimpleCar *simpleCar) {
        self.plateNumberButton.value = simpleCar.regName;
        self.vehicleID = simpleCar.vehicleID;
        self.plateNumber = simpleCar.regName;
    };
    [self.navigationController pushViewController:findCarViewController animated:YES];
}

- (void)didClickTimeButton:(id)sender
{
    [self.timeTextField becomeFirstResponder];
}

- (void)didClickSearchButton:(id)sender
{
    WALCarTrackViewController *carTrackViewController = [[WALCarTrackViewController alloc] init];
    carTrackViewController.timeType = _selectedTimeRow;
    carTrackViewController.vehicleID = self.vehicleID;
    carTrackViewController.plateNumber = self.plateNumber;
    [self.navigationController pushViewController:carTrackViewController animated:YES];
}

- (void)didClickCancelItem:(id)sender
{
    [self.timeTextField resignFirstResponder];
}

- (void)didClickDoneItem:(id)sender
{
    self.timeButton.value = _timeArray[_selectedTimeRow];
    [self.timeTextField resignFirstResponder];
}

#pragma mark -- UIPickerViewDataSource/Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_timeArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_timeArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selectedTimeRow = row;
}

#pragma mark - getter

- (WALTipsButton *)plateNumberButton
{
    if (!_plateNumberButton) {
        _plateNumberButton = [WALTipsButton buttonWithType:UIButtonTypeCustom];
        _plateNumberButton.frame = CGRectMake(0, 0, self.view.width, 44);
        [_plateNumberButton addTarget:self action:@selector(didClickPlateNumberButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_plateNumberButton];
    }
    return _plateNumberButton;
}

- (WALTipsButton *)timeButton
{
    if (!_timeButton) {
        _timeButton = [WALTipsButton buttonWithType:UIButtonTypeCustom];
        _timeButton.frame = CGRectMake(0, self.plateNumberButton.bottom, self.view.width, 44);
        [_timeButton addTarget:self action:@selector(didClickTimeButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_timeButton];
        
        _timeTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        
        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 300)];
        pickerView.dataSource = self;
        pickerView.delegate = self;
        _timeTextField.inputView = pickerView;
        
        UIToolbar *toolbar = [[UIToolbar alloc] init];
        toolbar.frame = CGRectMake(0, 0, self.view.width, 44);
        
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(didClickCancelItem:)];
        UIBarButtonItem *flexibleItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *titleItem = [[UIBarButtonItem alloc] initWithTitle:@"查询时长" style:UIBarButtonItemStylePlain target:nil action:nil];
        UIBarButtonItem *flexibleItem2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(didClickDoneItem:)];
        
        toolbar.items = @[cancelItem, flexibleItem1, titleItem, flexibleItem2, doneItem];
        _timeTextField.inputAccessoryView = toolbar;
        [_timeButton addSubview:_timeTextField];
    }
    return _timeButton;
}

- (UIButton *)searchButton
{
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchButton.frame = CGRectMake(0, self.timeButton.bottom, self.view.width, 44);
        _searchButton.backgroundColor = [UIColor blueColor];
        [_searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_searchButton addTarget:self action:@selector(didClickSearchButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_searchButton];
    }
    return _searchButton;
}

@end
