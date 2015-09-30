//
//  WALSegmentButton.m
//  Walmart
//
//  Created by wangxu on 15/9/30.
//  Copyright © 2015年 e6. All rights reserved.
//

#import "WALSegmentButton.h"

@interface WALSegmentButton ()

@property (nonatomic, strong) UIView *colorView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *numberLabel;

@end

@implementation WALSegmentButton

- (void)setWithText:(NSString *)text selected:(BOOL)selected color:(UIColor *)color
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    [str addAttribute:NSFontAttributeName value:Font(14) range:NSMakeRange(0, str.length)];
    if (selected) {
        [str addAttribute:NSForegroundColorAttributeName value:RGB(0x0f91db) range:NSMakeRange(0, str.length)];
        if (str.length >= 3) {
            [str addAttribute:NSFontAttributeName value:Font(12) range:NSMakeRange(3, str.length - 3)];
        }
    } else {
        if (str.length >= 2) {
            [str addAttribute:NSForegroundColorAttributeName value:RGB(0x666666) range:NSMakeRange(0, 2)];
            if (str.length >= 3) {
                [str addAttribute:NSForegroundColorAttributeName value:RGB(0x999999) range:NSMakeRange(3, str.length - 3)];
                [str addAttribute:NSFontAttributeName value:Font(12) range:NSMakeRange(3, str.length - 3)];
            }
        }
    }
    self.textLabel.attributedText = str;
    self.colorView.backgroundColor = color;
}

#pragma mark - getter

- (UIView *)colorView
{
    if (!_colorView) {
        _colorView = [[UIView alloc] initWithFrame:CGRectMake(8, (self.height - 16)/2.0, 16, 16)];
        _colorView.layer.cornerRadius = 2.0;
        [self addSubview:_colorView];
    }
    return _colorView;
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.colorView.right + 5, 0, self.width - self.colorView.right - 5, self.height)];
        [self addSubview:_textLabel];
    }
    return _textLabel;
}

@end
