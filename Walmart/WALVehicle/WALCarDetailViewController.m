//
//  WALCarDetailViewController.m
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALCarDetailViewController.h"
#import "WALCarPositionViewController.h"
#import "WALFindCarTrackViewController.h"
#import "WALTipsLabel.h"
#import "WALCarTapView.h"
#import "WALCarService.h"

@interface WALCarDetailViewController () <UIAlertViewDelegate>

@property (nonatomic, strong) UILabel *plateNumberLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) WALTipsLabel *driverLabel;
@property (nonatomic, strong) WALTipsLabel *addressLabel;
@property (nonatomic, strong) WALTipsLabel *statusLabel;
@property (nonatomic, strong) WALTipsLabel *speedLabel;
@property (nonatomic, strong) WALTipsLabel *mileageLabel;
@property (nonatomic, strong) WALTipsLabel *temperature1Label;
@property (nonatomic, strong) WALTipsLabel *temperature2Label;
@property (nonatomic, strong) WALTipsLabel *temperature3Label;
@property (nonatomic, strong) WALTipsLabel *temperature4Label;
@property (nonatomic, strong) WALCarTapView *carTapView;
@property (nonatomic, strong) WALCarService *carService;
@property (nonatomic, strong) WALCarDetail *carDetail;

@end

@implementation WALCarDetailViewController

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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"车辆详情";
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"正在获取数据,请稍候..."];
    [self.carService loadCarDetailWithVehicleID:self.car.vehicleID completion:^(BOOL success, WALCarDetail *carDetail, NSString *message) {
        [DejalBezelActivityView removeView];
        [[TKAlertCenter defaultCenter] postAlertWithMessage:message];
        if (success) {
            self.carDetail = carDetail;
            [self setupUI];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI
{
    self.plateNumberLabel.text = self.carDetail.regName;
    self.timeLabel.text = self.carDetail.GPSTime;
    self.typeLabel.text = self.carDetail.typeName;
    self.driverLabel.value = self.carDetail.driver;
    self.addressLabel.value = self.carDetail.roadName;
    self.statusLabel.value = self.carDetail.carStatus;
    self.speedLabel.value = [NSString stringWithFormat:@"%@ km/h", self.carDetail.speed];
    self.mileageLabel.value = [NSString stringWithFormat:@"%@ km", self.carDetail.milleage];
    self.temperature1Label.value = [NSString stringWithFormat:@"%@℃", self.carDetail.T1];
    self.temperature2Label.value = [NSString stringWithFormat:@"%@℃", self.carDetail.T2];
    self.carTapView.car = self.car;
}

#pragma mark -- alertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", alertView.message]]];
    }
}

#pragma mark -- getter

- (UILabel *)plateNumberLabel
{
    if (!_plateNumberLabel) {
        _plateNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 32)];
        [self.view addSubview:_plateNumberLabel];
    }
    return _plateNumberLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.plateNumberLabel.right, 0, 100, 32)];
        [self.view addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UILabel *)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.plateNumberLabel.left, self.plateNumberLabel.bottom, 100, 32)];
        [self.view addSubview:_typeLabel];
    }
    return _typeLabel;
}

- (WALTipsLabel *)driverLabel
{
    if (!_driverLabel) {
        _driverLabel = [[WALTipsLabel alloc] initWithFrame:CGRectMake(0, self.typeLabel.bottom, 100, 44)];
        _driverLabel.tip = @"司机";
        [self.view addSubview:_driverLabel];
    }
    return _driverLabel;
}

- (WALTipsLabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [[WALTipsLabel alloc] initWithFrame:CGRectMake(0, self.driverLabel.bottom, 100, 44)];
        _addressLabel.tip = @"当前位置";
        [self.view addSubview:_addressLabel];
    }
    return _addressLabel;
}

- (WALTipsLabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[WALTipsLabel alloc] initWithFrame:CGRectMake(0, self.addressLabel.bottom, 100, 44)];
        _statusLabel.tip = @"车辆状态";
        [self.view addSubview:_statusLabel];
    }
    return _statusLabel;
}

- (WALTipsLabel *)speedLabel
{
    if (!_speedLabel) {
        _speedLabel = [[WALTipsLabel alloc] initWithFrame:CGRectMake(0, self.statusLabel.bottom, 100, 44)];
        _speedLabel.tip = @"速度";
        [self.view addSubview:_speedLabel];
    }
    return _speedLabel;
}

- (WALTipsLabel *)mileageLabel
{
    if (!_mileageLabel) {
        _mileageLabel = [[WALTipsLabel alloc] initWithFrame:CGRectMake(0, self.speedLabel.bottom, 100, 44)];
        _mileageLabel.tip = @"里程";
        [self.view addSubview:_mileageLabel];
    }
    return _mileageLabel;
}

- (WALTipsLabel *)temperature1Label
{
    if (!_temperature1Label) {
        _temperature1Label = [[WALTipsLabel alloc] initWithFrame:CGRectMake(0, self.mileageLabel.bottom, 100, 44)];
        _temperature1Label.tip = @"温度1";
        [self.view addSubview:_temperature1Label];
    }
    return _temperature1Label;
}

- (WALTipsLabel *)temperature2Label
{
    if (!_temperature2Label) {
        _temperature2Label = [[WALTipsLabel alloc] initWithFrame:CGRectMake(0, self.temperature1Label.bottom, 100, 44)];
        _temperature2Label.tip = @"温度2";
        [self.view addSubview:_temperature2Label];
    }
    return _temperature2Label;
}

- (WALCarTapView *)carTapView
{
    if (!_carTapView) {
        _carTapView = [[WALCarTapView alloc] initWithFrame:CGRectMake(0, self.view.height - 32, self.view.width, 32)];
        __weak typeof(self) weakSelf = self;
        _carTapView.phoneBlock = ^(WALCar *car) {
            if (car.telPhone.length > 0) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确认拨打电话" message:car.telPhone delegate:weakSelf cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
                [alertView show];
            }
        };
        _carTapView.positionBlock = ^(WALCar *car) {
            WALCarPositionViewController *carPositionViewController = [[WALCarPositionViewController alloc] init];
            carPositionViewController.car = car;
            carPositionViewController.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:carPositionViewController animated:YES];
        };
        _carTapView.trackBlock = ^(WALCar *car) {
            WALFindCarTrackViewController *findCarTrackViewController = [[WALFindCarTrackViewController alloc] init];
            findCarTrackViewController.car = car;
            findCarTrackViewController.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:findCarTrackViewController animated:YES];
        };
        [self.view addSubview:_carTapView];
    }
    return _carTapView;
}

@end
