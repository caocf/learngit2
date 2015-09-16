//
//  WALTipsLabel.m
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALTipsLabel.h"

@interface WALTipsLabel ()

@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *valueLabel;

@end

@implementation WALTipsLabel

- (void)setTip:(NSString *)tip
{
    self.tipLabel.text = tip;
}

- (void)setValue:(id)value
{
    self.valueLabel.text = value;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 32)];
        [self addSubview:_tipLabel];
    }
    return _tipLabel;
}

- (UILabel *)valueLabel
{
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.tipLabel.right, 0, 100, 32)];
        [self addSubview:_valueLabel];
    }
    return _valueLabel;
}

@end
