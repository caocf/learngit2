//
//  WALCarTrackViewController.m
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALCarTrackViewController.h"
#import <BaiduMapAPI/BMKPolylineView.h>
#import "WALCarStopPosition.h"

@interface WALCarTrackViewController () <BMKMapViewDelegate>

@property (nonatomic, strong) WALCarService *carService;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *plateNumberLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UIView *playView;
@property (nonatomic, strong) UILabel *playTimeLabel;
@property (nonatomic, strong) UILabel *speedLabel;
@property (nonatomic, strong) UILabel *milleageLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSArray *playArray;
@property (nonatomic, strong) NSArray *trackArray;
@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) BMKPointAnnotation *annotation;
@property (nonatomic, assign) BMKCoordinateRegion originRegion;
@property (nonatomic, strong) NSArray *carStopArray;

@end

@implementation WALCarTrackViewController
{
    BOOL _played;
    NSInteger _playIndex;
}

- (id)init
{
    if (self = [super init]) {
        _carService = [[WALCarService alloc] init];
        _played = NO;
        _playIndex = 0;
        _annotation = [[BMKPointAnnotation alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"车辆轨迹";
    
    self.mapView.hidden = NO;
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"正在获取数据,请稍候..."];
    NSString *startTime = [NSDate startStringWithType:self.timeType];
    NSString *endTime = [NSDate endStringWithType:self.timeType];
    self.playButton.enabled = NO;
    [self.carService loadCarTrackListWithVehicleID:self.vehicleID startTime:startTime endTime:endTime completion:^(BOOL success, WALCarTrack *carTrack, NSString *message) {
        [DejalBezelActivityView removeView];
        [[TKAlertCenter defaultCenter] postAlertWithMessage:message];
        if (success) {
            self.trackArray = carTrack.positionArray;
//            self.trackArray = @[@"23.122833,113.86124599999999", @"24.122833,113.86124599999999", @"23.122833,114.86124599999999", @"25.122833,113.86124599999999", @"23.122833,115.86124599999999", @"26.122833,113.86124599999999"];
            CLLocationCoordinate2D coords[10000] = {0};
            CGFloat minLat = MAXFLOAT;
            CGFloat maxLat = 0;
            CGFloat minLon = MAXFLOAT;
            CGFloat maxLon = 0;
            NSInteger i = 0;
//            for (int i = 0; i < 6; i++) {
            for (WALCoor *coor in self.trackArray) {
//                NSArray *pointArray = [self.trackArray[i] componentsSeparatedByString:@","];
//                if ([pointArray count] >= 2) {
//                    coords[i].latitude = [pointArray[0] doubleValue];
//                    coords[i].longitude = [pointArray[1] doubleValue];
                coords[i].latitude = [coor.lat doubleValue];
                coords[i].longitude = [coor.lon doubleValue];
                minLat = MIN(coords[i].latitude, minLat);
                maxLat = MAX(coords[i].latitude, maxLat);
                minLon = MIN(coords[i].longitude, minLon);
                maxLon = MAX(coords[i].longitude, maxLon);
                i++;
//                }
            }
            
            //构建BMKPolyline,使用分段纹理
            BMKPolyline *polyLine = [BMKPolyline polylineWithCoordinates:coords count:[self.trackArray count]];
            //添加分段纹理绘制折线覆盖物
            [self.mapView addOverlay:polyLine];
            
            CLLocationCoordinate2D centerCoor;
            centerCoor.latitude = (minLat + maxLat)/2.0;
            centerCoor.longitude = (minLon + maxLon)/2.0;
            BMKCoordinateSpan span;
            span.latitudeDelta = (maxLat - minLat) * 1.5;
            span.longitudeDelta = (maxLon - minLon) * 1.5;
            BMKCoordinateRegion region;
            region.center = centerCoor;
            region.span = span;
            [self.mapView setRegion:region animated:YES];
            self.originRegion = region;
            [self.carService loadCarPlayTrackListWithVehicleID:self.vehicleID startTime:startTime endTime:endTime completion:^(BOOL success, WALCarPlayTrack *carPlayTrack, NSString *message) {
                if (success) {
                    self.playArray = carPlayTrack.trackArray;
//                    self.playArray = @[@"23.122833,113.86124599999999", @"24.122833,113.86124599999999", @"23.122833,114.86124599999999", @"25.122833,113.86124599999999", @"23.122833,115.86124599999999", @"26.122833,113.86124599999999"];
                    self.playButton.enabled = YES;
                }
            }];
        }
    }];
    
    [self.carService loadCarStopListWithVehicleID:self.vehicleID startTime:startTime endTime:endTime completion:^(BOOL success, NSArray *posArray, NSString *message) {
        if (success) {
            self.carStopArray = posArray;
            NSMutableArray *annotationArray = [NSMutableArray array];
            for (WALCarStopPosition *position in posArray) {
                BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
                CLLocationCoordinate2D coor;
                coor.latitude = [position.lat doubleValue];
                coor.longitude = [position.lon doubleValue];
                annotation.coordinate = coor;
                [annotationArray addObject:annotation];
            }
            [self.mapView addAnnotations:annotationArray];
        }
    }];
    self.plateNumberLabel.text = self.plateNumber;
    self.timeLabel.text = [NSString stringWithFormat:@"%@ 00:00 至 %@ 23:59", [startTime substringWithRange:NSMakeRange(5, 5)], [endTime substringWithRange:NSMakeRange(5, 5)]];
    self.searchButton.hidden = self.playButton.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didClickSearchButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didClickPlayButton:(id)sender
{
    _played = !_played;
    if (_played) {
        self.playView.hidden = NO;
        self.playView.top = self.bottomView.top - 64;
        self.playView.height = 64;
        self.addressLabel.hidden = YES;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerfire) userInfo:nil repeats:YES];
    } else {
        WALCarPlayPosition *carPlayPosition = self.playArray[_playIndex];
        [self.timer invalidate];
        [self.mapView removeAnnotation:self.annotation];
        [self.mapView setRegion:self.originRegion animated:YES];
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"正在获取数据,请稍候..."];
        [self.carService loadPlaceNameWithVehicleID:self.vehicleID
                                                lon:carPlayPosition.lon
                                                lat:carPlayPosition.lat
                                         completion:^(BOOL success, NSString *placeName, NSString *message) {
                                             [DejalBezelActivityView removeView];
                                             [[TKAlertCenter defaultCenter] postAlertWithMessage:message];
                                             if (success) {
                                                 self.playView.top = self.bottomView.top - 96;
                                                 self.playView.height = 96;
                                                 self.addressLabel.hidden = NO;
                                                 self.addressLabel.text = placeName;
                                             }
                                         }];
    }
}

- (void)timerfire
{
    if (_playIndex < self.playArray.count) {
        WALCarPlayPosition *carPlayPosition = self.playArray[_playIndex];
        self.playTimeLabel.text = carPlayPosition.time;
        self.speedLabel.text = carPlayPosition.speed;
        self.milleageLabel.text = carPlayPosition.milleage;
//        CLLocationCoordinate2D coords[6] = {0};
//        for (int i = 0; i < 6; i++) {
//            NSArray *pointArray = [self.trackArray[i] componentsSeparatedByString:@","];
//            coords[i].latitude = [pointArray[0] doubleValue];
//            coords[i].longitude = [pointArray[1] doubleValue];
//        }
//        self.annotation.coordinate = coords[_playIndex];
        CLLocationCoordinate2D coor;
        coor.latitude = [carPlayPosition.lat doubleValue];
        coor.longitude = [carPlayPosition.lon doubleValue];
        self.annotation.coordinate = coor;
        if (![self.mapView viewForAnnotation:self.annotation]) {
            [self.mapView addAnnotation:self.annotation];
        }
        BMKCoordinateRegion region = self.mapView.region;
        BMKCoordinateRegion freshRegion;
        freshRegion.span.latitudeDelta = region.span.latitudeDelta * 0.1;
        freshRegion.span.longitudeDelta = region.span.longitudeDelta * 0.1;
        region.center = self.annotation.coordinate;
        [self.mapView setRegion:region animated:YES];
        _playIndex++;
    } else {
        _playIndex = 0;
        [self didClickPlayButton:nil];
    }
}

#pragma mark - BMKMapViewDelegate

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        newAnnotationView.layer.transform = CATransform3DMakeRotation((M_PI / 2.0 / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
        return newAnnotationView;
    }
    return nil;
}

- (BMKOverlayView *)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView *polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.lineWidth = 5;
        polylineView.isFocus = YES;
        polylineView.strokeColor = RGB(0x00ff00);
        return polylineView;
    }
    return nil;
}

#pragma mark - getter

- (BMKMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.bottomView.top)];
        _mapView.delegate = self;
        [self.view addSubview:_mapView];
    }
    return _mapView;
}

- (UIView *)playView
{
    if (!_playView) {
        _playView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bottomView.top - 64, self.view.width, 64)];
        _playView.backgroundColor = RGBA(0x000000, 0.5);
        _playView.hidden = YES;
        [self.view addSubview:_playView];
    }
    return _playView;
}

- (UILabel *)playTimeLabel
{
    if (!_playTimeLabel) {
        _playTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 32)];
        [self.playView addSubview:_playTimeLabel];
    }
    return _playTimeLabel;
}

- (UILabel *)speedLabel
{
    if (!_speedLabel) {
        _speedLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.playTimeLabel.right, self.playTimeLabel.top, 150, 32)];
        [self.playView addSubview:_speedLabel];
    }
    return _speedLabel;
}

- (UILabel *)milleageLabel
{
    if (!_milleageLabel) {
        _milleageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.playTimeLabel.bottom, 150, 32)];
        [self.playView addSubview:_milleageLabel];
    }
    return _milleageLabel;
}

- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.milleageLabel.bottom, 150, 32)];
        [self.playView addSubview:_addressLabel];
    }
    return _addressLabel;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 64 - 64, self.view.width, 64)];
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}

- (UILabel *)plateNumberLabel
{
    if (!_plateNumberLabel) {
        _plateNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 32)];
        [self.bottomView addSubview:_plateNumberLabel];
    }
    return _plateNumberLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.plateNumberLabel.bottom, 150, 32)];
        [self.bottomView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UIButton *)searchButton
{
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchButton setBackgroundImage:[UIImage imageNamed:@"open_icon.png"] forState:UIControlStateNormal];
        _searchButton.frame = CGRectMake(self.view.width - 100, 12, 40, 40);
        [_searchButton addTarget:self action:@selector(didClickSearchButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:_searchButton];
    }
    return _searchButton;
}

- (UIButton *)playButton
{
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setBackgroundImage:[UIImage imageNamed:@"open_icon.png"] forState:UIControlStateNormal];
        _playButton.frame = CGRectMake(self.view.width - 50, 12, 40, 40);
        [_playButton addTarget:self action:@selector(didClickPlayButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:_playButton];
    }
    return _playButton;
}

@end
