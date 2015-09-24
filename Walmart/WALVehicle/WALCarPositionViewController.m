//
//  WALCarPositionViewController.m
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALCarPositionViewController.h"
#import "WALCarInfoView.h"
#import "WALCarService.h"

@interface WALCarPositionViewController () <BMKMapViewDelegate>

@property (nonatomic, strong) WALCarInfoView *carInfoView;
@property (nonatomic, strong) WALCarService *carService;
@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) UIButton *locationButton;

@end

@implementation WALCarPositionViewController

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
    self.navigationItem.title = @"位置跟踪";
    
    self.locationButton.backgroundColor = RGB(0xff0000);
    self.carInfoView.car = self.car;
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"正在获取数据,请稍候..."];
    [self.carService loadMapMonitWithVehicleID:self.car.vehicleID completion:^(BOOL success,  WALCar *car, NSString *message) {
        [DejalBezelActivityView removeView];
        [[TKAlertCenter defaultCenter] postAlertWithMessage:message];
        if (success) {
            self.carInfoView.car = car;
            BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
            CLLocationCoordinate2D coor;
            coor.latitude = [car.lat doubleValue];
            coor.longitude = [car.lon doubleValue];
            annotation.coordinate = coor;
            annotation.title = car.placeName;
            [self.mapView addAnnotation:annotation];
            [self.locationButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didClickLocationButton:(id)sender
{
    CLLocationCoordinate2D coor;
    coor.latitude = [self.car.lat doubleValue];
    coor.longitude = [self.car.lon doubleValue];
    [self.mapView setCenterCoordinate:coor animated:YES];
}

#pragma mark - BMKMapViewDelegate

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

#pragma mark - getter

- (BMKMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64 - 72)];
        _mapView.delegate = self;
        [self.view addSubview:_mapView];
    }
    return _mapView;
}

- (UIButton *)locationButton
{
    if (!_locationButton) {
        _locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _locationButton.frame = CGRectMake(0, self.mapView.height - 40, 40, 40);
        [_locationButton addTarget:self action:@selector(didClickLocationButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_locationButton];
    }
    return _locationButton;
}

- (WALCarInfoView *)carInfoView
{
    if (!_carInfoView) {
        _carInfoView = [[WALCarInfoView alloc] initWithFrame:CGRectMake(0, self.view.height - 64 - 72, self.view.width, 72)];
        _carInfoView.alpha = 0.1;
        [self.view addSubview:_carInfoView];
    }
    return _carInfoView;
}

@end
