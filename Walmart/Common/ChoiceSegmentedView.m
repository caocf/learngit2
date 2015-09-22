//
//  ChoiceSegmentedView.m
//  DailyYoga
//
//  Created by zhen on 14-8-20.
//  Copyright (c) 2014年 zhen. All rights reserved.
//

#import "ChoiceSegmentedView.h"

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
        _colorView = [[UIView alloc] initWithFrame:CGRectMake(8, 14, 16, 16)];
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

@interface ChoiceSegmentedView()

@property (nonatomic, strong) NSMutableArray *selectedButtonArray;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSArray *backgroundColors;
@property (nonatomic, strong) UIView *blueLineView;
@property (nonatomic, assign) NSInteger seletedIntex;

@end

@implementation ChoiceSegmentedView

- (void)setWithSize2:(CGSize)size
   backImageViewName:(NSString *)imageView
     segmentedNumber:(NSInteger)segmentedNumber
            contents:(NSArray *)contents
              images:(NSArray*)images
    backgroundColors:(NSArray *)backgroundColors
              colors:(NSArray *)colors
         selectedNum:(NSInteger)selectedNum
            fontSize:(CGFloat)fontSize
{
    _colors = colors;
    _backgroundColors = backgroundColors;
    UIImageView *backGroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [backGroundImageView setImage:[[UIImage imageNamed:imageView] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 19, 0, 19) resizingMode:UIImageResizingModeStretch]];
    [self addSubview:backGroundImageView];
    _selectedButtonArray = [NSMutableArray array];
    for (int i = 0; i < segmentedNumber; i++) {
        UIButton *segmentedButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width / segmentedNumber * i, 1, self.width / segmentedNumber, self.height - 2)];
        segmentedButton.titleLabel.font = Font(fontSize);
        [segmentedButton setTitle:[contents objectAtIndex:i] forState:UIControlStateNormal];
        segmentedButton.tag = i;
        [segmentedButton addTarget:self action:@selector(didClickButton1:) forControlEvents:UIControlEventTouchUpInside];
        if (i == selectedNum) {
            [segmentedButton setTitleColor:colors[0] forState:UIControlStateNormal];
            segmentedButton.backgroundColor = backgroundColors[0];
        } else {
            [segmentedButton setTitleColor:colors[1] forState:UIControlStateNormal];
            segmentedButton.backgroundColor = backgroundColors[1];
        }
        [self addSubview:segmentedButton];
        [_selectedButtonArray addObject:segmentedButton];
    }
}

- (void)didClickButton1:(id)sender
{
    UIButton * segmentedButton = (UIButton *)sender;
    for (UIButton * clickedButton in self.selectedButtonArray) {
        if (clickedButton.tag == segmentedButton.tag) {
            [clickedButton setTitleColor:self.colors[0] forState:UIControlStateNormal];
            clickedButton.backgroundColor = self.backgroundColors[0];
        } else {
            [clickedButton setTitleColor:self.colors[1] forState:UIControlStateNormal];
            clickedButton.backgroundColor = self.backgroundColors[1];
        }
    }
    if (self.forumSegmentedBlock) {
        self.forumSegmentedBlock(segmentedButton.tag);
    }
}

- (void)setWithContents:(NSArray *)contents
                 colors:(NSArray *)colors
{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 0.5, self.width, 0.5)];
    lineView.backgroundColor = RGB(0xd7d7d7);
    [self addSubview:lineView];
    
    _selectedButtonArray = [NSMutableArray array];
    self.contents2Array = contents;
    self.colors = colors;
    NSInteger count = [contents count];
    
    self.blueLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 2, self.width/count, 2)];
    self.blueLineView.backgroundColor = RGB(0x0f91db);
    [self addSubview:self.blueLineView];
    
    for (int i = 0; i < count; i++) {
        WALSegmentButton *segmentedButton = [[WALSegmentButton alloc] initWithFrame:CGRectMake(self.width / count * i, 0, self.width / count, self.height - 1)];
        segmentedButton.tag = i;
        [segmentedButton addTarget:self action:@selector(didClickButton2:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:segmentedButton];
        [_selectedButtonArray addObject:segmentedButton];
    }
    self.seletedIntex = 0;
    [self selectButtonWithIndex:self.seletedIntex];
}

- (void)setContents2Array:(NSArray *)contents2Array
{
    _contents2Array = contents2Array;
    [self selectButtonWithIndex:self.seletedIntex];
}

- (void)selectButtonWithIndex:(NSInteger)index
{
    for (WALSegmentButton *button in self.selectedButtonArray) {
        BOOL selected = button.tag == index;
        [button setWithText:self.contents2Array[button.tag] selected:selected color:self.colors[button.tag]];
    }
    self.blueLineView.left = index * self.width / [self.selectedButtonArray count];
}

-(void)didClickButton2:(id)sender
{
    WALSegmentButton *segmentedButton = (WALSegmentButton *)sender;
    self.seletedIntex = segmentedButton.tag;
    [self selectButtonWithIndex:self.seletedIntex];
    if (self.forumSegmentedBlock) {
        self.forumSegmentedBlock(self.seletedIntex);
    }
}

- (void)setContentsArray:(NSArray *)contentsArray
{
    NSInteger count = contentsArray.count;
    for (NSInteger i = 0; i < count; i++) {
        UIButton *button = self.selectedButtonArray[i];
        [button setTitle:contentsArray[i] forState:UIControlStateNormal];
    }
}

@end
