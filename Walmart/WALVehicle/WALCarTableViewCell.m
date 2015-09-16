//
//  WALCarTableViewCell.m
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALCarTableViewCell.h"
#import "WALCarInfoView.h"
#import "WALCarTapView.h"

@interface WALCarTableViewCell ()

@property (nonatomic, strong) WALCarInfoView *carInfoView;
@property (nonatomic, strong) WALCarTapView *carTapView;

@end

@implementation WALCarTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCar:(WALCar *)car
{
    if (_car != car) {
        _car = car;
        self.carInfoView.car = car;
        self.carTapView.car = car;
        self.lineView.top = 95;
    }
}

#pragma mark - actions

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

#pragma mark - getter

- (WALCarInfoView *)carInfoView
{
    if (!_carInfoView) {
        _carInfoView = [[WALCarInfoView alloc] initWithFrame:CGRectMake(0, 0, self.width, 64)];
        [self.contentView addSubview:_carInfoView];
    }
    return _carInfoView;
}

- (WALCarTapView *)carTapView
{
    if (!_carTapView) {
        _carTapView = [[WALCarTapView alloc] initWithFrame:CGRectMake(0, self.carInfoView.bottom, self.width, 32)];
        _carTapView.phoneBlock = self.phoneBlock;
        _carTapView.positionBlock = self.positionBlock;
        _carTapView.trackBlock = self.trackBlock;
        [self.contentView addSubview:_carTapView];
    }
    return _carTapView;
}

@end
