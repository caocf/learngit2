//
//  ChoiceSegmentedView.m
//  DailyYoga
//
//  Created by zhen on 14-8-20.
//  Copyright (c) 2014年 zhen. All rights reserved.
//

#import "ChoiceSegmentedView.h"

@interface ChoiceSegmentedView()

@property (nonatomic, strong) NSMutableArray *selectedButtonArray;
@property (nonatomic, strong) NSArray *colors;

@end

@implementation ChoiceSegmentedView


- (void)setWithSize2:(CGSize)size
   backImageViewName:(NSString *)imageView
     segmentedNumber:(NSInteger)segmentedNumber
            contents:(NSArray *)contents
              images:(NSArray*)images
              colors:(NSArray *)colors
         selectedNum:(NSInteger)selectedNum
{
    _colors = colors;
    UIImageView *backGroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [backGroundImageView setImage:[[UIImage imageNamed:imageView] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 19, 0, 19) resizingMode:UIImageResizingModeStretch]];
    [self addSubview:backGroundImageView];
    _selectedButtonArray = [NSMutableArray array];
    for (int i = 0; i < segmentedNumber; i++) {
        UIButton *segmentedButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width / segmentedNumber * i, 10, self.width / segmentedNumber, self.height - 20)];
        [segmentedButton setBackgroundColor:[UIColor clearColor]];
        [segmentedButton.titleLabel setFont:Helvetica_Font(15)];
        [segmentedButton setTitle:[contents objectAtIndex:i] forState:UIControlStateNormal];
        segmentedButton.tag = i;
        [segmentedButton addTarget:self action:@selector(didClickButton1:) forControlEvents:UIControlEventTouchUpInside];
        if (i == selectedNum) {
            [segmentedButton setTitleColor:colors[0] forState:UIControlStateNormal];
        } else {
            [segmentedButton setTitleColor:colors[1] forState:UIControlStateNormal];
        }
        [self addSubview:segmentedButton];
        [_selectedButtonArray addObject:segmentedButton];
    }
}

-(void)didClickButton1:(id)sender
{
    UIButton * segmentedButton = (UIButton *)sender;
    for (UIButton * clickedButton in self.selectedButtonArray) {
        if (clickedButton.tag == segmentedButton.tag) {
            [clickedButton setTitleColor:self.colors[0] forState:UIControlStateNormal];
        } else {
            [clickedButton setTitleColor:self.colors[1] forState:UIControlStateNormal];
        }
    }
    if (self.forumSegmentedBlock) {
        self.forumSegmentedBlock(segmentedButton.tag);
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
