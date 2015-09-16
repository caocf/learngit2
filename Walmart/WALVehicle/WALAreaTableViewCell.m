//
//  WALAreaTableViewCell.m
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALAreaTableViewCell.h"

static CGFloat kSubHeight = 22;
static CGFloat kGap = 5;

@interface WALAreaTableViewCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *runningLabel;
@property (nonatomic, strong) UILabel *stopLabel;
@property (nonatomic, strong) UILabel *offlineLabel;

@end

@implementation WALAreaTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setArea:(WALArea *)area
{
    if (_area != area) {
        _area = area;
        self.nameLabel.text = area.name;
        self.runningLabel.text = [NSString stringWithFormat:@"运行 %@", area.runningCount];
        self.stopLabel.text = [NSString stringWithFormat:@"停车 %@", area.stopCount];
        self.offlineLabel.text = [NSString stringWithFormat:@"掉线 %@", area.offlineCount];
        self.lineView.top = 43;
    }
}

#pragma mark - getter

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kGap, 0, 100, kSubHeight)];
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)runningLabel
{
    if (!_runningLabel) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(kGap, self.nameLabel.bottom, 10, 10)];
        view.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:view];
        
        _runningLabel = [[UILabel alloc] initWithFrame:CGRectMake(view.right + kGap, self.nameLabel.bottom, 100, kSubHeight)];
        [self.contentView addSubview:_runningLabel];
        view.centerY = _runningLabel.centerY;
    }
    return _runningLabel;
}

- (UILabel *)stopLabel
{
    if (!_stopLabel) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.runningLabel.right + kGap, self.nameLabel.bottom, 10, 10)];
        view.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:view];
        
        _stopLabel = [[UILabel alloc] initWithFrame:CGRectMake(view.right + kGap, self.nameLabel.bottom, 100, kSubHeight)];
        [self.contentView addSubview:_stopLabel];
        view.centerY = _stopLabel.centerY;
    }
    return _stopLabel;
}

- (UILabel *)offlineLabel
{
    if (!_offlineLabel) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.stopLabel.right + kGap, self.nameLabel.bottom, 10, 10)];
        view.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:view];
        
        _offlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(view.right + kGap, self.nameLabel.bottom, 100, kSubHeight)];
        [self.contentView addSubview:_offlineLabel];
        view.centerY = _offlineLabel.centerY;
    }
    return _offlineLabel;
}

@end
