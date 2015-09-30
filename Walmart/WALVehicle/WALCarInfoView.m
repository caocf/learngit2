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
        self.plateNumberLabel.width = [self.plateNumberLabel.text sizeWithFont:self.plateNumberLabel.font].width;
        self.speedLabel.left = self.plateNumberLabel.right + 5;
        self.speedLabel.text = [NSString stringWithFormat:@"%@ km/h", car.speed];
        self.timeLabel.text = car.GPSTime;
        self.speedLabel.centerY = self.timeLabel.centerY = self.plateNumberLabel.centerY;
        self.addressLabel.text = car.placeName;
        self.addressLabel.width = MIN([self.addressLabel.text sizeWithFont:self.addressLabel.font].width, self.width - 30);
    }
}

#pragma mark - getter

- (UILabel *)plateNumberLabel
{
    if (!_plateNumberLabel) {
        _plateNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, 100, 16)];
        _plateNumberLabel.font = Font(16);
        _plateNumberLabel.textColor = RGB(0x222222);
        [self addSubview:_plateNumberLabel];
    }
    return _plateNumberLabel;
}

- (UILabel *)speedLabel
{
    if (!_speedLabel) {
        _speedLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.plateNumberLabel.right, 0, 100, 12)];
        _speedLabel.font = Font(12);
        _speedLabel.textColor = RGB(0x888888);
        [self addSubview:_speedLabel];
    }
    return _speedLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 150, 0, 142, 12)];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = Font(12);
        _timeLabel.textColor = RGB(0xbbbbbb);
        [self addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        UIImageView *positionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.plateNumberLabel.left, self.plateNumberLabel.bottom + 10, 15, 15)];
        positionImageView.image = [UIImage imageNamed:@"icon_g30_location.png"];
        [self addSubview:positionImageView];
        
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(positionImageView.right + 5, self.plateNumberLabel.bottom, 100, 15)];
        _addressLabel.font = Font(15);
        _addressLabel.textColor = RGB(0x555555);
        _addressLabel.centerY = positionImageView.centerY;
        [self addSubview:_addressLabel];
    }
    return _addressLabel;
}

@end
