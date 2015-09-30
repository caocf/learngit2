//
//  WALAreaTableViewCell.m
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALAreaTableViewCell.h"
#import "WALSegmentButton.h"

static CGFloat kGap = 10;

@interface WALAreaTableViewCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) WALSegmentButton *runningButton;
@property (nonatomic, strong) WALSegmentButton *stopButton;
@property (nonatomic, strong) WALSegmentButton *offlineButton;

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
        [self.runningButton setWithText:[NSString stringWithFormat:@"运行 %@", area.runningCount] selected:NO color:RGB(0x70ba0d)];
        [self.stopButton setWithText:[NSString stringWithFormat:@"停车 %@", area.stopCount] selected:NO color:RGB(0x7770a3)];
        [self.offlineButton setWithText:[NSString stringWithFormat:@"异常 %@", area.offlineCount] selected:NO color:RGB(0xacacac)];
        self.lineView.backgroundColor = RGB(0xd7d7d7);
        self.lineView.top = 63.4;
    }
}

#pragma mark - getter

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kGap, 10, self.width, 16)];
        _nameLabel.textColor = RGB(0x222222);
        _nameLabel.font = Font(16);
        [self.contentView addSubview:_nameLabel];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_lg30_arrowEnter.png"]];
        imageView.frame = CGRectMake(self.width - 25, 24.5, 15, 15);
        [self.contentView addSubview:imageView];
    }
    return _nameLabel;
}

- (WALSegmentButton *)runningButton
{
    if (!_runningButton) {
        _runningButton = [WALSegmentButton buttonWithType:UIButtonTypeCustom];
        _runningButton.frame = CGRectMake(kGap, self.nameLabel.bottom + 10, (self.width - 16) / 3.0, 18);
        [self.contentView addSubview:_runningButton];
    }
    return _runningButton;
}

- (WALSegmentButton *)stopButton
{
    if (!_stopButton) {
        _stopButton = [WALSegmentButton buttonWithType:UIButtonTypeCustom];
        _stopButton.frame = CGRectMake(self.runningButton.right, self.runningButton.top, self.runningButton.width, 18);
        [self.contentView addSubview:_stopButton];
    }
    return _stopButton;
}

- (WALSegmentButton *)offlineButton
{
    if (!_offlineButton) {
        _offlineButton = [WALSegmentButton buttonWithType:UIButtonTypeCustom];
        _offlineButton.frame = CGRectMake(self.stopButton.right, self.runningButton.top, self.runningButton.width, 18);
        [self.contentView addSubview:_offlineButton];
    }
    return _offlineButton;
}

@end
