//
//  YLYInfoButton.m
//  E6Business
//
//  Created by wangxu on 15/9/3.
//  Copyright (c) 2015年 wangxu. All rights reserved.
//

#import "WALTipsButton.h"

@interface WALTipsButton ()

@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UILabel *valueLabel;

@end

@implementation WALTipsButton

- (void)setTips:(NSString *)tips
{
    self.tipsLabel.text = tips;
}

- (void)setValue:(NSString *)value
{
    self.valueLabel.text = value;
}

#pragma mark - getter

- (UILabel *)tipsLabel
{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, self.height)];
        _tipsLabel.font = Font(14.0);
        _tipsLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_tipsLabel];
        
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - 10, 0, 10, self.height)];
        [self addSubview:arrowImageView];
    }
    return _tipsLabel;
}

- (UILabel *)valueLabel
{
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.tipsLabel.right, 0, 100, self.height)];
        _valueLabel.font = Font(14.0);
        _valueLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_valueLabel];
    }
    return _valueLabel;
}

@end
