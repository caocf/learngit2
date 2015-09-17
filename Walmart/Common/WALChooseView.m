//
//  YGSettingVolumeView.m
//  DailyYoga
//
//  Created by wangxu on 14-9-12.
//  Copyright (c) 2014年 wangxu. All rights reserved.
//

#import "WALChooseView.h"

static float kAnimationDuration = 0.25;
static float kButtonWidth = 55;
static float kButtonHeight = 44;
static NSInteger kColumnNumber = 5;

@interface WALChooseView ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UISlider *voiceVolumeSlider;
@property (nonatomic, strong) UISlider *musicVolumeSlider;
@property (nonatomic, strong) UIButton *doneButton;

@end

@implementation WALChooseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark -- actions

- (void)showInView:(UIView *)view
{
    self.backgroundView.frame = view.bounds;
    self.left = (view.width - kButtonWidth * kColumnNumber)/2.0;
    self.top = (view.height - self.height)/2.0;
    [UIView animateWithDuration:kAnimationDuration animations:^{
        [view addSubview:self.backgroundView];
        [view addSubview:self];
    }];
}

- (void)setDataArray:(NSArray *)dataArray
{
    if (_dataArray != dataArray) {
        _dataArray = dataArray;
        NSInteger rowNumber = (self.dataArray.count + kColumnNumber - 1) / kColumnNumber;
        CGFloat height = (rowNumber + 1)*kButtonHeight;
        self.frame = CGRectMake(0, 0, kButtonWidth * kColumnNumber, height);
        [self setupUI];
    }
}

- (void)setupUI
{
    [self removeAllSubViews];
    self.titleLabel.text = self.title;
    [self addSubview:self.titleLabel];
    NSInteger rowNumber = (self.dataArray.count + kColumnNumber - 1) / kColumnNumber;
    CGFloat top = self.titleLabel.bottom;
    for (int i = 0; i < rowNumber; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, top, self.width, kButtonHeight)];
        [self addSubview:view];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5, self.width, 0.5)];
        lineView.backgroundColor = RGB(kLineColor);
        [view addSubview:lineView];
        
        CGFloat left = 0;
        for (int j = 0; j < kColumnNumber; j++) {
            NSInteger index = i * kColumnNumber + j;
            if (index >= self.dataArray.count) {
                continue;
            }
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitleColor:RGB(0x333333) forState:UIControlStateNormal];
            button.frame = CGRectMake(left, 0, kButtonWidth, kButtonHeight - 1);
            [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:self.dataArray[index] forState:UIControlStateNormal];
            button.tag = index;
            [view addSubview:button];
            
            left = left + kButtonWidth;
        }
        
        top = top + kButtonHeight;
    }
}

- (void)didClickButton:(UIButton *)sender
{
    if (_selectBlock) {
        _selectBlock(sender.tag);
    }
    [self didTapGestureRecogniser:nil];
}

- (void)didTapGestureRecogniser:(id)sender
{
    [UIView animateWithDuration:kAnimationDuration animations:^{
        [self removeFromSuperview];
        [self.backgroundView removeFromSuperview];
    }];
}

#pragma mark -- getter

- (UIView *)backgroundView
{
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        _backgroundView.backgroundColor = [UIColor lightGrayColor];
        _backgroundView.alpha = 0.3;
        [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapGestureRecogniser:)]];
    }
    return _backgroundView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 44)];
        _titleLabel.backgroundColor = RGB(0xffffff);
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = Font(17);
    }
    return _titleLabel;
}

@end
