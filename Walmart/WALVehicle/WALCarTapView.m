//
//  WALCarTapView.m
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALCarTapView.h"

@interface WALCarTapView ()

@property (nonatomic, strong) UIButton *phoneButton;
@property (nonatomic, strong) UIButton *positionButton;
@property (nonatomic, strong) UIButton *trackButton;

@end

@implementation WALCarTapView

- (void)setCar:(WALCar *)car
{
    if (_car != car) {
        _car = car;
        [self.phoneButton setTitle:@"电话联系" forState:UIControlStateNormal];
        [self.positionButton setTitle:@"位置跟踪" forState:UIControlStateNormal];
        [self.trackButton setTitle:@"轨迹回放" forState:UIControlStateNormal];
        if (car.telPhone.length <= 0) {
            self.phoneButton.enabled = NO;
        }
    }
}

- (void)didClickPhoneButton:(id)sender
{
    if (_phoneBlock) {
        _phoneBlock(self.car);
    }
}

- (void)didClickPositionButton:(id)sender
{
    if (_positionBlock) {
        _positionBlock(self.car);
    }
}

- (void)didClickTrackButton:(id)sender
{
    if (_trackBlock) {
        _trackBlock(self.car);
    }
}

- (UIButton *)phoneButton
{
    if (!_phoneButton) {
        _phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _phoneButton.frame = CGRectMake(0, 0, self.width/3.0, self.height);
        [_phoneButton addTarget:self action:@selector(didClickPhoneButton:) forControlEvents:UIControlEventTouchUpInside];
        _phoneButton.titleLabel.font = Font(14);
        _phoneButton.backgroundColor = RGB(0xf8f8f8);
        [_phoneButton setTitleColor:RGB(0x929292) forState:UIControlStateNormal];
        [_phoneButton setTitleColor:RGB(0xcccccc) forState:UIControlStateDisabled];
        [_phoneButton setImage:[UIImage imageNamed:@"icon_b30_phone.png"] forState:UIControlStateNormal];
        _phoneButton.layer.borderColor = RGB(kLineColor).CGColor;
        _phoneButton.layer.borderWidth = 0.5;
        [self addSubview:_phoneButton];
    }
    return _phoneButton;
}

- (UIButton *)positionButton
{
    if (!_positionButton) {
        _positionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _positionButton.frame = CGRectMake(self.phoneButton.right, 0, self.phoneButton.width, self.phoneButton.height);
        [_positionButton addTarget:self action:@selector(didClickPositionButton:) forControlEvents:UIControlEventTouchUpInside];
        [_positionButton setTitleColor:RGB(0x929292) forState:UIControlStateNormal];
        [_positionButton setTitleColor:RGB(0xcccccc) forState:UIControlStateDisabled];
        [_positionButton setImage:[UIImage imageNamed:@"icon_b30_locate.png"] forState:UIControlStateNormal];
        _positionButton.backgroundColor = self.phoneButton.backgroundColor;
        _positionButton.titleLabel.font = self.phoneButton.titleLabel.font;
        _positionButton.layer.borderColor = self.phoneButton.layer.borderColor;
        _positionButton.layer.borderWidth = 0.5;
        [self addSubview:_positionButton];
    }
    return _positionButton;
}

- (UIButton *)trackButton
{
    if (!_trackButton) {
        _trackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _trackButton.frame = CGRectMake(self.positionButton.right, 0, self.phoneButton.width, self.positionButton.height);
        [_trackButton addTarget:self action:@selector(didClickTrackButton:) forControlEvents:UIControlEventTouchUpInside];
        [_trackButton setTitleColor:RGB(0x929292) forState:UIControlStateNormal];
        [_trackButton setTitleColor:RGB(0xcccccc) forState:UIControlStateDisabled];
        [_trackButton setImage:[UIImage imageNamed:@"icon_b30_locus.png"] forState:UIControlStateNormal];
        _trackButton.backgroundColor = self.phoneButton.backgroundColor;
        _trackButton.titleLabel.font = self.phoneButton.titleLabel.font;
        _trackButton.layer.borderColor = self.phoneButton.layer.borderColor;
        _trackButton.layer.borderWidth = 0.5;
        [self addSubview:_trackButton];
    }
    return _trackButton;
}

@end
