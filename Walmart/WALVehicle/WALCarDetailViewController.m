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

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) WALTipsLabel *driverLabel;
@property (nonatomic, strong) WALTipsLabel *timeLabel;
@property (nonatomic, strong) WALTipsLabel *addressLabel;
@property (nonatomic, strong) WALTipsLabel *statusLabel;
@property (nonatomic, strong) WALTipsLabel *alarmLabel;
@property (nonatomic, strong) WALTipsLabel *speedLabel;
@property (nonatomic, strong) WALTipsLabel *oilLabel;
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
    self.view.backgroundColor = RGB(0xf0f0f0);
    
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
    CGFloat valueWidth = self.view.width - 100;
    self.driverLabel.value = self.carDetail.driver;
    self.timeLabel.value = self.carDetail.GPSTime;
    self.addressLabel.height = MAX([self.carDetail.roadName sizeWithFont:Font(15) constrainedToSize:CGSizeMake(valueWidth, MAXFLOAT)].height, 44);
    self.addressLabel.value = self.carDetail.roadName;
    self.statusLabel.height = MAX([self.carDetail.carStatus sizeWithFont:Font(15) constrainedToSize:CGSizeMake(valueWidth, MAXFLOAT)].height, 44);
    self.statusLabel.value = self.carDetail.carStatus;
    NSString *alarm = @"";
    if (self.carDetail.eInfo.length > 0) {
        alarm = [alarm stringByAppendingString:self.carDetail.eInfo];
    }
    if (self.carDetail.aInfo.length > 0) {
        alarm = [alarm stringByAppendingString:self.carDetail.aInfo];
    }
    self.alarmLabel.height = MAX([alarm sizeWithFont:Font(15) constrainedToSize:CGSizeMake(valueWidth, MAXFLOAT)].height, 44);
    self.alarmLabel.value = alarm;
    [self.speedLabel setAttributedValueWithKey:self.carDetail.speed unit:@"km/h"];
    [self.mileageLabel setAttributedValueWithKey:self.carDetail.milleage unit:@"km"];
    [self.oilLabel setAttributedValueWithKey:self.carDetail.oil unit:@"L"];
    [self.temperature1Label setAttributedValueWithKey:self.carDetail.T1 unit:@"℃"];
    [self.temperature2Label setAttributedValueWithKey:self.carDetail.T2 unit:@"℃"];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, MAX(self.temperature2Label.bottom, self.scrollView.height));
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

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 47)];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (WALTipsLabel *)driverLabel
{
    if (!_driverLabel) {
        _driverLabel = [[WALTipsLabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
        _driverLabel.tip = @"司机";
        [self.scrollView addSubview:_driverLabel];
    }
    return _driverLabel;
}

- (WALTipsLabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[WALTipsLabel alloc] initWithFrame:CGRectMake(self.driverLabel.left, self.driverLabel.bottom, self.view.width, 44)];
        _timeLabel.tip = @"GPS时间";
        [self.scrollView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (WALTipsLabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [[WALTipsLabel alloc] initWithFrame:CGRectMake(0, self.timeLabel.bottom, self.view.width, 44)];
        _addressLabel.numberOfLines = 0;
        _addressLabel.tip = @"当前位置";
        [self.scrollView addSubview:_addressLabel];
    }
    return _addressLabel;
}

- (WALTipsLabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[WALTipsLabel alloc] initWithFrame:CGRectMake(0, self.addressLabel.bottom, self.view.width, 44)];
        _statusLabel.numberOfLines = 0;
        _statusLabel.tip = @"车辆状态";
        [self.scrollView addSubview:_statusLabel];
    }
    return _statusLabel;
}

- (WALTipsLabel *)alarmLabel
{
    if (!_alarmLabel) {
        _alarmLabel = [[WALTipsLabel alloc] initWithFrame:CGRectMake(0, self.statusLabel.bottom, self.view.width, 44)];
        _alarmLabel.numberOfLines = 0;
        _alarmLabel.isAlarm = YES;
        _alarmLabel.tip = @"报警";
        [self.scrollView addSubview:_alarmLabel];
    }
    return _alarmLabel;
}

- (WALTipsLabel *)speedLabel
{
    if (!_speedLabel) {
        _speedLabel = [[WALTipsLabel alloc] initWithFrame:CGRectMake(0, self.alarmLabel.bottom, self.view.width, 44)];
        _speedLabel.tip = @"速度";
        [self.scrollView addSubview:_speedLabel];
    }
    return _speedLabel;
}

- (WALTipsLabel *)mileageLabel
{
    if (!_mileageLabel) {
        _mileageLabel = [[WALTipsLabel alloc] initWithFrame:CGRectMake(0, self.speedLabel.bottom, self.view.width, 44)];
        _mileageLabel.tip = @"里程";
        [self.scrollView addSubview:_mileageLabel];
    }
    return _mileageLabel;
}

- (WALTipsLabel *)oilLabel
{
    if (!_oilLabel) {
        _oilLabel = [[WALTipsLabel alloc] initWithFrame:CGRectMake(0, self.mileageLabel.bottom, self.view.width, 44)];
        _oilLabel.tip = @"油量";
        [self.scrollView addSubview:_oilLabel];
    }
    return _oilLabel;
}

- (WALTipsLabel *)temperature1Label
{
    if (!_temperature1Label) {
        _temperature1Label = [[WALTipsLabel alloc] initWithFrame:CGRectMake(0, self.oilLabel.bottom, self.view.width, 44)];
        _temperature1Label.tip = @"温度1";
        [self.scrollView addSubview:_temperature1Label];
    }
    return _temperature1Label;
}

- (WALTipsLabel *)temperature2Label
{
    if (!_temperature2Label) {
        _temperature2Label = [[WALTipsLabel alloc] initWithFrame:CGRectMake(0, self.temperature1Label.bottom, self.view.width, 44)];
        _temperature2Label.tip = @"温度2";
        [self.scrollView addSubview:_temperature2Label];
    }
    return _temperature2Label;
}

- (WALCarTapView *)carTapView
{
    if (!_carTapView) {
        _carTapView = [[WALCarTapView alloc] initWithFrame:CGRectMake(0, self.view.height - 47, self.view.width, 47)];
        _carTapView.backgroundColor = RGB(0xf7f7f7);
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
