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
        self.phoneButton.width = self.width/3.0;
        self.positionButton.left = self.phoneButton.right;
        self.positionButton.width = self.width/3.0;
        self.trackButton.left = self.positionButton.right;
        self.trackButton.width = self.width/3.0;
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
        _phoneButton.frame = CGRectMake(0, 0, 100, 32);
        [_phoneButton addTarget:self action:@selector(didClickPhoneButton:) forControlEvents:UIControlEventTouchUpInside];
        [_phoneButton setTitleColor:RGB(0x333333) forState:UIControlStateNormal];
        _phoneButton.layer.borderColor = RGB(0x666666).CGColor;
        _phoneButton.layer.borderWidth = 0.5;
        [self addSubview:_phoneButton];
    }
    return _phoneButton;
}

- (UIButton *)positionButton
{
    if (!_positionButton) {
        _positionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _positionButton.frame = CGRectMake(self.phoneButton.right, 0, 100, 32);
        [_positionButton addTarget:self action:@selector(didClickPositionButton:) forControlEvents:UIControlEventTouchUpInside];
        [_positionButton setTitleColor:RGB(0x333333) forState:UIControlStateNormal];
        _positionButton.layer.borderColor = RGB(0x666666).CGColor;
        _positionButton.layer.borderWidth = 0.5;
        [self addSubview:_positionButton];
    }
    return _positionButton;
}

- (UIButton *)trackButton
{
    if (!_trackButton) {
        _trackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _trackButton.frame = CGRectMake(self.positionButton.right, 0, 100, 32);
        [_trackButton addTarget:self action:@selector(didClickTrackButton:) forControlEvents:UIControlEventTouchUpInside];
        [_trackButton setTitleColor:RGB(0x333333) forState:UIControlStateNormal];
        _trackButton.layer.borderColor = RGB(0x666666).CGColor;
        _trackButton.layer.borderWidth = 0.5;
        [self addSubview:_trackButton];
    }
    return _trackButton;
}

@end
