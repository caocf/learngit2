//
//  YGSettingVolumeView.h
//  DailyYoga
//
//  Created by wangxu on 14-9-12.
//  Copyright (c) 2014年 wangxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WALChooseView : UIView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, copy) void (^selectBlock)(NSInteger selectedIndex);

- (void)showInView:(UIView *)view;

@end
