//
//  WALCarInfoView.m
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALCarInfoView.h"

@interface WALCarInfoView ()

@property (nonatomic, strong) UILabel *plateNumberLabel;
@property (nonatomic, strong) UILabel *speedLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *addressLabel;

@end

@implementation WALCarInfoView

- (void)setCar:(WALCar *)car
{
    if (_car != car) {
        _car = car;
        self.plateNumberLabel.text = car.regName;
        self.speedLabel.text = [NSString stringWithFormat:@"%@ km/h", car.speed];
        self.timeLabel.text = car.GPSTime;
        self.addressLabel.text = car.placeName;
    }
}

#pragma mark - getter

- (UILabel *)plateNumberLabel
{
    if (!_plateNumberLabel) {
        _plateNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 32)];
        [self addSubview:_plateNumberLabel];
    }
    return _plateNumberLabel;
}

- (UILabel *)speedLabel
{
    if (!_speedLabel) {
        _speedLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.plateNumberLabel.right, 0, 100, 32)];
        [self addSubview:_speedLabel];
    }
    return _speedLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.speedLabel.right, 0, 100, 32)];
        [self addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.plateNumberLabel.bottom, 100, 32)];
        [self addSubview:_addressLabel];
    }
    return _addressLabel;
}

@end
