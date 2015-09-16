//
//  WALCarPositionViewController.m
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALCarPositionViewController.h"
#import "WALCarInfoView.h"
#import "WALCarService.h"

@interface WALCarPositionViewController ()

@property (nonatomic, strong) WALCarInfoView *carInfoView;
@property (nonatomic, strong) WALCarService *carService;

@end

@implementation WALCarPositionViewController

- (id)init
{
    if (self = [super init]) {
        _carService = [[WALCarService alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"位置跟踪";
    
    self.carInfoView.car = self.car;
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"正在获取数据,请稍候..."];
    [self.carService loadMapMonitWithVehicleID:self.car.vehicleID completion:^(BOOL success,  WALCar *car, NSString *message) {
        self.carInfoView.car = car;
        [DejalBezelActivityView removeView];
        [[TKAlertCenter defaultCenter] postAlertWithMessage:message];
        if (success) {
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter

- (WALCarInfoView *)carInfoView
{
    if (!_carInfoView) {
        _carInfoView = [[WALCarInfoView alloc] initWithFrame:CGRectMake(0, self.view.height - 64 - 72, self.view.width, 72)];
        [self.view addSubview:_carInfoView];
    }
    return _carInfoView;
}

@end
