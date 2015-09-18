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

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) WALCarInfoView *carInfoView;
@property (nonatomic, strong) UIView *statusView;
@property (nonatomic, strong) WALCarTapView *carTapView;

@end

@implementation WALCarTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    self.bgView.backgroundColor = highlighted ? RGB(0xf0f0f0) : RGB(0xffffff);
}

- (void)setCar:(WALCar *)car
{
    if (_car != car) {
        _car = car;
        self.carInfoView.car = car;
        self.carTapView.car = car;
        [self setupCarEInfoWithCar:car];
    }
}

- (void)setupCarEInfoWithCar:(WALCar *)car
{
    NSString *info = [NSString stringWithFormat:@"%@;%@", car.eInfo, car.aInfo];
    NSArray *infoArray = [info componentsSeparatedByString:@";"];
    CGFloat outGap = 8;
    CGFloat inGap = 5;
    CGFloat widthLimit = self.width - outGap * 2;
    CGFloat labelHeight = 10 + 2 *inGap;
    CGFloat totalWidth = 0;
    CGFloat totalHeight = 0;
    BOOL hasInfoLabel = NO;
    [self.statusView removeAllSubViews];
    self.statusView.frame = CGRectZero;
    for (NSString *string in infoArray) {
        if (string.length <= 0) {
            continue;
        }
        hasInfoLabel = YES;
        CGFloat labelWidth = [string sizeWithFont:Font(10)].width + inGap * 2;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.statusView addSubview:label];
        if (totalWidth + labelWidth > widthLimit) {
            totalHeight += labelHeight + outGap;
            label.frame = CGRectMake(0, totalHeight, labelWidth, labelHeight);
            totalWidth = labelWidth + outGap;
        } else {
            label.frame = CGRectMake(totalWidth, totalHeight, labelWidth, labelHeight);
            totalWidth += labelWidth + outGap;
        }
        label.text = string;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = RGB(0xffffff);
        label.font = Font(10);
        label.layer.cornerRadius = 5.0;
        label.layer.masksToBounds = YES;
        label.backgroundColor = RGB(0xff7f7f);
    }
    if (hasInfoLabel) {
        totalHeight = totalHeight + labelHeight;
        self.statusView.frame = CGRectMake(outGap, self.carInfoView.bottom + 10, widthLimit, totalHeight);
        self.carTapView.frame = CGRectMake(0, self.statusView.bottom + 10, self.width, 30);
        self.bgView.height = 88 + totalHeight + 10;
    } else {
        self.carTapView.frame = CGRectMake(0, self.carInfoView.bottom + 10, self.width, 30);
        self.bgView.height = 88;
    }
}

#pragma mark - getter

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 8, self.width, 88)];
        _bgView.backgroundColor = RGB(0xffffff);
        self.contentView.backgroundColor = RGB(0xf0f0f0);
        [self.contentView addSubview:_bgView];
        
        UIView *lineVew = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
        lineVew.backgroundColor = RGB(0xe5e5e5);
        [_bgView addSubview:lineVew];
    }
    return _bgView;
}

- (WALCarInfoView *)carInfoView
{
    if (!_carInfoView) {
        _carInfoView = [[WALCarInfoView alloc] initWithFrame:CGRectMake(0, 0, self.width, 48)];
        [self.bgView addSubview:_carInfoView];
    }
    return _carInfoView;
}

- (UIView *)statusView
{
    if (!_statusView) {
        _statusView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.bgView addSubview:_statusView];
    }
    return _statusView;
}

- (WALCarTapView *)carTapView
{
    if (!_carTapView) {
        _carTapView = [[WALCarTapView alloc] initWithFrame:CGRectMake(0, self.carInfoView.bottom, self.width, 30)];
        _carTapView.phoneBlock = self.phoneBlock;
        _carTapView.positionBlock = self.positionBlock;
        _carTapView.trackBlock = self.trackBlock;
        [self.bgView addSubview:_carTapView];
    }
    return _carTapView;
}

@end
