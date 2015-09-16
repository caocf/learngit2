//
//  WALFindCarViewController.h
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "BaseViewController.h"
#import "WALSimpleCar.h"

@interface WALFindCarViewController : BaseViewController

@property (nonatomic, copy) void (^selectedBlock)(WALSimpleCar *simpleCar);

@end
