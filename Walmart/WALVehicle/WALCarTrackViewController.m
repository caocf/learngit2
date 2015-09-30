//
//  WALCarTrackViewController.m
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALCarTrackViewController.h"
#import <BaiduMapAPI/BMKPolylineView.h>
#import "WALAnnotationView.h"
#import "WALCarStopPosition.h"
#import "WALAnnotation.h"

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
@property (nonatomic, strong) WALAnnotation *annotation;
@property (nonatomic, assign) BMKCoordinateRegion originRegion;
@property (nonatomic, strong) NSArray *carStopArray;
@property (nonatomic, strong) UIButton *locationButton;
@property (nonatomic, strong) UIView *zoomView;

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
        _annotation = [[WALAnnotation alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"车辆轨迹";
    
    self.mapView.hidden = NO;
    self.locationButton.hidden = self.zoomView.hidden = NO;
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"正在获取数据,请稍候..."];
    NSString *startTime = [NSDate startStringWithType:self.timeType];
    NSString *endTime = [NSDate endStringWithType:self.timeType];
    self.playButton.enabled = NO;
    [self.carService loadCarTrackListWithVehicleID:self.vehicleID startTime:startTime endTime:endTime completion:^(BOOL success, WALCarTrack *carTrack, NSString *message) {
        [DejalBezelActivityView removeView];
        [[TKAlertCenter defaultCenter] postAlertWithMessage:message];
        if (success) {
            self.trackArray = carTrack.positionArray;
            CLLocationCoordinate2D coords[10000] = {0};
            CGFloat minLat = MAXFLOAT;
            CGFloat maxLat = 0;
            CGFloat minLon = MAXFLOAT;
            CGFloat maxLon = 0;
            NSInteger i = 0;
            for (WALCoor *coor in self.trackArray) {
                coords[i].latitude = [coor.lat doubleValue];
                coords[i].longitude = [coor.lon doubleValue];
                minLat = MIN(coords[i].latitude, minLat);
                maxLat = MAX(coords[i].latitude, maxLat);
                minLon = MIN(coords[i].longitude, minLon);
                maxLon = MAX(coords[i].longitude, maxLon);
                i++;
            }
            
            {
                WALCoor *walcoor = [self.trackArray firstObject];
                WALAnnotation *annotation = [[WALAnnotation alloc] init];
                CLLocationCoordinate2D coor;
                coor.latitude = [walcoor.lat doubleValue];
                coor.longitude = [walcoor.lon doubleValue];
                annotation.imageName = @"mapstart.png";
                annotation.coordinate = coor;
                [self.mapView addAnnotation:annotation];
            }
            
            {
                WALCoor *walcoor = [self.trackArray lastObject];
                WALAnnotation *annotation = [[WALAnnotation alloc] init];
                CLLocationCoordinate2D coor;
                coor.latitude = [walcoor.lat doubleValue];
                coor.longitude = [walcoor.lon doubleValue];
                annotation.title = [NSString stringWithFormat:@"%@km", carTrack.totalMilleage];
                annotation.imageName = @"mapend.png";
                annotation.coordinate = coor;
                [self.mapView addAnnotation:annotation];
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
                WALAnnotation *annotation = [[WALAnnotation alloc] init];
                CLLocationCoordinate2D coor;
                coor.latitude = [position.lat doubleValue];
                coor.longitude = [position.lon doubleValue];
                annotation.imageName = @"mapparking.png";
                annotation.coordinate = coor;
                [annotationArray addObject:annotation];
            }
            [self.mapView addAnnotations:annotationArray];
        }
    }];
    self.plateNumberLabel.text = self.plateNumber;
//    self.timeLabel.text = [NSString stringWithFormat:@"%@ 00:00 至 %@ 23:59", [startTime substringWithRange:NSMakeRange(5, 5)], [endTime substringWithRange:NSMakeRange(5, 5)]];
    self.timeLabel.text = [NSString stringWithFormat:@"%@轨迹", _timeArray[self.timeType]];
    self.searchButton.hidden = self.playButton.hidden = NO;
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

- (void)didClickSearchButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didClickPlayButton:(id)sender
{
    _played = !_played;
    if (_played) {
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"icon_locus_pause.png"] forState:UIControlStateNormal];
        self.playView.hidden = NO;
        self.playView.top = self.bottomView.top - 64;
        self.playView.height = 64;
        self.addressLabel.hidden = YES;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerfire) userInfo:nil repeats:YES];
    } else {
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"icon_locus_play.png"] forState:UIControlStateNormal];
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
        CLLocationCoordinate2D coor;
        coor.latitude = [carPlayPosition.lat doubleValue];
        coor.longitude = [carPlayPosition.lon doubleValue];
        self.annotation.coordinate = coor;
        self.annotation.angle = [carPlayPosition.direction integerValue];
        self.annotation.imageName = @"gjo.png";
//        if (![self.mapView viewForAnnotation:self.annotation]) {
//            [self.mapView addAnnotation:self.annotation];
//        }
        [self.mapView removeAnnotation:self.annotation];
        [self.mapView addAnnotation:self.annotation];
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

- (void)didClickLocationButton:(id)sender
{
    [self.mapView setRegion:self.originRegion animated:YES];
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
    if ([annotation isKindOfClass:[WALAnnotation class]]) {
//        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
//        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        WALAnnotationView *newAnnotationView = [[WALAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        WALAnnotation *walAnnotation = annotation;
        newAnnotationView.imageName = walAnnotation.imageName;
        newAnnotationView.angle = walAnnotation.angle;
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
        _mapView.rotateEnabled = NO;
        _mapView.showMapScaleBar = YES;
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

- (UIView *)playView
{
    if (!_playView) {
        _playView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
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
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 64 - 58, self.view.width, 58)];
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}

- (UILabel *)plateNumberLabel
{
    if (!_plateNumberLabel) {
        _plateNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 16)];
        _plateNumberLabel.font = Font(16);
        _plateNumberLabel.textColor = RGB(0x444444);
        [self.bottomView addSubview:_plateNumberLabel];
    }
    return _plateNumberLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.plateNumberLabel.left, self.plateNumberLabel.bottom + 10, 150, 12)];
        _timeLabel.font = Font(12);
        _timeLabel.textColor = RGB(0x888888);
        [self.bottomView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UIButton *)searchButton
{
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchButton setBackgroundImage:[UIImage imageNamed:@"icon_g42_search.png"] forState:UIControlStateNormal];
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
        [_playButton setBackgroundImage:[UIImage imageNamed:@"icon_locus_play.png"] forState:UIControlStateNormal];
        _playButton.frame = CGRectMake(self.view.width - 50, 12, 40, 40);
        [_playButton addTarget:self action:@selector(didClickPlayButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:_playButton];
    }
    return _playButton;
}

@end
