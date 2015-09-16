//
//  WALCarTrackViewController.m
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALCarTrackViewController.h"

@interface WALCarTrackViewController ()

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
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"车辆轨迹";
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"正在获取数据,请稍候..."];
    NSString *startTime = [NSDate startStringWithType:self.timeType];
    NSString *endTime = [NSDate endStringWithType:self.timeType];
    self.playButton.enabled = NO;
    [self.carService loadCarTrackListWithVehicleID:self.vehicleID startTime:startTime endTime:endTime completion:^(BOOL success, WALCarTrack *carTrack, NSString *message) {
        [DejalBezelActivityView removeView];
        [[TKAlertCenter defaultCenter] postAlertWithMessage:message];
        if (success) {
            [self.carService loadCarPlayTrackListWithVehicleID:self.vehicleID startTime:startTime endTime:endTime completion:^(BOOL success, WALCarPlayTrack *carPlayTrack, NSString *message) {
                if (success) {
                    self.playArray = carPlayTrack.trackArray;
                    self.playButton.enabled = YES;
                }
            }];
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
        _playIndex++;
    } else {
        _playIndex = 0;
        [self didClickPlayButton:nil];
    }
}

#pragma mark - getter

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
