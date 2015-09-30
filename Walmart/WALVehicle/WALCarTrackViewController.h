//
//  WALCarTrackViewController.h
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WALCarService.h"

@interface WALCarTrackViewController : BaseViewController

@property (nonatomic, assign) WALSearchTimeType timeType;
@property (nonatomic, strong) NSArray *timeArray;
@property (nonatomic, strong) NSString *vehicleID;
@property (nonatomic, strong) NSString *plateNumber;

@end
