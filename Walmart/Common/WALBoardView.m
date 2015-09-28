//
//  WALBoardView.m
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALBoardView.h"

@interface WALBoardView ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation WALBoardView

- (void)setWithText:(NSString *)text
{
    self.textLabel.text = text;
}

#pragma mark - getter

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake((self.height - 36)/2.0, (self.height - 36)/2.0, 36, 36)];
        _bgView.backgroundColor = [UIColor yellowColor];
        [self addSubview:_bgView];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, 28, 28)];
        _imageView.image = [UIImage imageNamed:@"icon_w40_notice.png"];
        [_bgView addSubview:_imageView];
    }
    return _bgView;
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bgView.right + 5, 0, self.width - self.bgView.right - 10, self.height)];
        _textLabel.numberOfLines = 2;
        _textLabel.font = Font(11);
        _textLabel.textColor = RGB(0x666666);
        [self addSubview:_textLabel];
    }
    return _textLabel;
}

@end
