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

- (void)setNumberOfLines:(NSInteger)numberOfLines
{
    self.valueLabel.numberOfLines = 0;
}

- (void)setTip:(NSString *)tip
{
    self.tipLabel.text = tip;
}

- (void)setValue:(NSString *)value
{
    if (value.length > 0) {
        self.valueLabel.text = value;
        if (self.isAlarm) {
            self.valueLabel.textColor = RGB(0xed0000);
        }
    } else {
        self.valueLabel.text = @"无";
        self.valueLabel.textColor = RGB(0xcccccc);
    }
}

- (void)setAttributedValueWithKey:(NSString *)key unit:(NSString *)unit
{
    if (key.length <= 0) {
        self.valueLabel.text = @"无";
        self.valueLabel.textColor = RGB(0xcccccc);
        return;
    }
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@", key, unit]];
    [str addAttribute:NSFontAttributeName value:BoldFont(18) range:NSMakeRange(0, str.length - unit.length - 1)];
    [str addAttribute:NSForegroundColorAttributeName value:RGB(0x444444) range:NSMakeRange(0, str.length - unit.length - 1)];
    [str addAttribute:NSFontAttributeName value:Font(15) range:NSMakeRange(str.length - unit.length, unit.length)];
    [str addAttribute:NSForegroundColorAttributeName value:RGB(0xbbbbbb) range:NSMakeRange(str.length - unit.length, unit.length)];
    self.valueLabel.attributedText = str;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, self.height)];
        _tipLabel.font = Font(15);
        _tipLabel.textColor = RGB(0x888888);
        [self addSubview:_tipLabel];
    }
    return _tipLabel;
}

- (UILabel *)valueLabel
{
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.tipLabel.right, 0, self.width - self.tipLabel.right, self.height)];
        _valueLabel.font = Font(15);
        _valueLabel.textColor = RGB(0x555555);
        [self addSubview:_valueLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 0.5, self.width, 0.5)];
        lineView.backgroundColor = RGB(kLineColor);
        [self addSubview:lineView];
    }
    return _valueLabel;
}

@end
