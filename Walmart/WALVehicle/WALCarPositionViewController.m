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
@property (nonatomic, strong) UIView *zoomView;

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
    
    self.locationButton.hidden = NO;
    self.zoomView.hidden = NO;
    self.carInfoView.car = self.car;
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"正在获取数据,请稍候..."];
    [self.carService loadMapMonitWithVehicleID:self.car.vehicleID completion:^(BOOL success,  WALCar *car, NSString *message) {
        [DejalBezelActivityView removeView];
        [[TKAlertCenter defaultCenter] postAlertWithMessage:message];
        if (success) {
            self.car = car;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)didClickLocationButton:(id)sender
{
    CLLocationCoordinate2D coor;
    coor.latitude = [self.car.lat doubleValue];
    coor.longitude = [self.car.lon doubleValue];
    [self.mapView setCenterCoordinate:coor animated:YES];
}

- (void)didClickZoomOutButton:(id)sender
{
    [self.mapView zoomOut];
}

- (void)didClickZoomInButton:(id)sender
{
    [self.mapView zoomIn];
}

#pragma mark - BMKMapViewDelegate

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        return newAnnotationView;
    }
    return nil;
}

#pragma mark - getter

- (BMKMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64 - 72)];
        _mapView.rotateEnabled = NO;
        _mapView.delegate = self;
        _mapView.minZoomLevel = 5;
        [self.view addSubview:_mapView];
    }
    return _mapView;
}

- (UIButton *)locationButton
{
    if (!_locationButton) {
        _locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _locationButton.frame = CGRectMake(10, self.mapView.height - 54, 44, 44);
        _locationButton.backgroundColor = RGBA(0xffffff, 0.9);
        [_locationButton addTarget:self action:@selector(didClickLocationButton:) forControlEvents:UIControlEventTouchUpInside];
        [_locationButton setImage:[UIImage imageNamed:@"icon_map_locate.png"] forState:UIControlStateNormal];
        _locationButton.layer.borderColor = RGBA(0xd4d4d4, 0.9).CGColor;
        _locationButton.layer.borderWidth = 0.5;
        _locationButton.layer.shadowColor = RGBA(0x000000, 0.3).CGColor;
        _locationButton.layer.shadowOffset = CGSizeMake(0, 1.0);
        _locationButton.layer.cornerRadius = 2.5;
        [self.view addSubview:_locationButton];
    }
    return _locationButton;
}

- (UIView *)zoomView
{
    if (!_zoomView) {
        _zoomView = [[UIView alloc] initWithFrame:CGRectMake(self.view.width - 54, self.mapView.height - 98, 44, 88)];
        _zoomView.backgroundColor = RGBA(0xffffff, 0.9);
        _zoomView.layer.borderColor = RGBA(0xd4d4d4, 0.9).CGColor;
        _zoomView.layer.borderWidth = 0.5;
        _zoomView.layer.shadowColor = RGBA(0x000000, 0.3).CGColor;
        _zoomView.layer.shadowOffset = CGSizeMake(0, 1.0);
        _zoomView.layer.cornerRadius = 2.5;
        [self.view addSubview:_zoomView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _zoomView.height / 2.0, _zoomView.width, 0.5)];
        lineView.backgroundColor = RGB(0xd8d8d8);
        [_zoomView addSubview:lineView];
        
        UIButton *zoomInButton = [UIButton buttonWithType:UIButtonTypeCustom];
        zoomInButton.frame = CGRectMake(0, 0, _zoomView.width, _zoomView.width);
        [zoomInButton addTarget:self action:@selector(didClickZoomInButton:) forControlEvents:UIControlEventTouchUpInside];
        [zoomInButton setImage:[UIImage imageNamed:@"icon_map_zoom.png"] forState:UIControlStateNormal];
        [_zoomView addSubview:zoomInButton];
        
        UIButton *zoomOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        zoomOutButton.frame = CGRectMake(0, zoomInButton.bottom + 0.5, _zoomView.width, _zoomView.width);
        [zoomOutButton addTarget:self action:@selector(didClickZoomOutButton:) forControlEvents:UIControlEventTouchUpInside];
        [zoomOutButton setImage:[UIImage imageNamed:@"icon_map_narrow.png"] forState:UIControlStateNormal];
        [_zoomView addSubview:zoomOutButton];
    }
    return _zoomView;
}

- (WALCarInfoView *)carInfoView
{
    if (!_carInfoView) {
        _carInfoView = [[WALCarInfoView alloc] initWithFrame:CGRectMake(0, self.view.height - 64 - 72, self.view.width, 72)];
        [self.view addSubview:_carInfoView];
    }
    return _carInfoView;
}

@end
