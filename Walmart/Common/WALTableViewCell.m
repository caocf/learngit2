//
//  WALTableViewCell.m
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALTableViewCell.h"

@implementation WALTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 95, self.width, 1)];
        _lineView.backgroundColor = RGB(0x333333);
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}

@end
