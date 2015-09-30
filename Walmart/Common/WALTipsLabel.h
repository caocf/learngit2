//
//  WALTipsLabel.h
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WALTipsLabel : UIView

@property (nonatomic, strong) NSString *tip;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, assign) BOOL isAlarm;
@property (nonatomic, assign) NSInteger numberOfLines;

- (void)setAttributedValueWithKey:(NSString *)key unit:(NSString *)unit;

@end
