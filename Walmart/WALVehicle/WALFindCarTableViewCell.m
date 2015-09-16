//
//  WALFindCarTableViewCell.m
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALFindCarTableViewCell.h"

@interface WALFindCarTableViewCell ()

@property (nonatomic, strong) UILabel *plateNumberLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *loadLabel;
@property (nonatomic, strong) UILabel *lengthLabel;

@end

@implementation WALFindCarTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setSimpleCar:(WALSimpleCar *)simpleCar
{
    if (_simpleCar != simpleCar) {
        _simpleCar = simpleCar;
        self.plateNumberLabel.text = simpleCar.regName;
        self.typeLabel.text = [NSString stringWithFormat:@"%@ |", simpleCar.TN];
        self.loadLabel.text = [NSString stringWithFormat:@"%@吨 |", simpleCar.load];
        self.lengthLabel.text = [NSString stringWithFormat:@"%@米", simpleCar.length];
        self.lineView.top = 43;
    }
}

#pragma mark - getter

- (UILabel *)plateNumberLabel
{
    if (!_plateNumberLabel) {
        _plateNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
        [self.contentView addSubview:_plateNumberLabel];
    }
    return _plateNumberLabel;
}

- (UILabel *)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.plateNumberLabel.right, 0, 80, 44)];
        [self.contentView addSubview:_typeLabel];
    }
    return _typeLabel;
}

- (UILabel *)loadLabel
{
    if (!_loadLabel) {
        _loadLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.typeLabel.right, 0, 80, 44)];
        [self.contentView addSubview:_loadLabel];
    }
    return _loadLabel;
}

- (UILabel *)lengthLabel
{
    if (!_lengthLabel) {
        _lengthLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.loadLabel.right, 0, 80, 44)];
        [self.contentView addSubview:_lengthLabel];
    }
    return _lengthLabel;
}

@end
