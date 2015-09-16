//
//  ChoiceSegmentedView.h
//  DailyYoga
//
//  Created by zhen on 14-8-20.
//  Copyright (c) 2014年 zhen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^selectSegmentedBlock)(NSInteger clickNumber);

@interface ChoiceSegmentedView : UIView

@property (nonatomic, copy) selectSegmentedBlock forumSegmentedBlock;
@property (nonatomic, strong) NSArray *contentsArray;

- (void)setWithSize2:(CGSize)size
   backImageViewName:(NSString *)imageView
     segmentedNumber:(NSInteger)segmentedNumber
            contents:(NSArray *)contents
              images:(NSArray *)images
              colors:(NSArray *)colors
         selectedNum:(NSInteger)selectedNum;


@end
