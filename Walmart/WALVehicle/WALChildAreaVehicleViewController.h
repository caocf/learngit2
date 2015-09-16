//
//  WALChildVehicleViewController.h
//  Walmart
//
//  Created by wangxu on 15/9/15.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "BaseViewController.h"
#import "WALArea.h"

@interface WALChildAreaVehicleViewController : BaseViewController

@property (nonatomic, strong) WALArea *area;

- (id)initWithType:(YLYRunStatus)runStatus;

@end
