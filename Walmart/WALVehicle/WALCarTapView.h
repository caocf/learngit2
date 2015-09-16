//
//  WALCarTapView.h
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WALCar.h"

@interface WALCarTapView : UIView

@property (nonatomic, strong) WALCar *car;
@property (nonatomic, copy) void (^phoneBlock)(WALCar *car);
@property (nonatomic, copy) void (^positionBlock)(WALCar *car);
@property (nonatomic, copy) void (^trackBlock)(WALCar *car);

@end
