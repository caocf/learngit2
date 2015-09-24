//
//  WALBoardView.m
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALBoardView.h"

@interface WALBoardView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation WALBoardView


- (void)setWithText:(NSString *)text imageName:(NSString *)imageName
{
    self.textLabel.text = text;
    self.imageView.image = [UIImage imageNamed:imageName];
}

#pragma mark - getter

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.height - 36)/2.0, (self.height - 36)/2.0, 36, 36)];
        _imageView.backgroundColor = [UIColor yellowColor];
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imageView.right + 5, 0, self.width - self.imageView.right - 10, self.height)];
        _textLabel.numberOfLines = 2;
        _textLabel.font = Font(11);
        _textLabel.textColor = RGB(0x666666);
        [self addSubview:_textLabel];
    }
    return _textLabel;
}

@end
