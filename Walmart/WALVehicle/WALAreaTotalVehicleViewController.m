//
//  WALTotalVehicleViewController.m
//  Walmart
//
//  Created by wangxu on 15/9/14.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALAreaTotalVehicleViewController.h"
#import "WALChildAreaVehicleViewController.h"
#import "ChoiceSegmentedView.h"
#import "WALCarService.h"

@interface WALAreaTotalVehicleViewController ()

@property (nonatomic, strong) ChoiceSegmentedView *segmentedView;
@property (nonatomic, strong) NSArray *contentsArray;
@property (nonatomic, strong) WALChildAreaVehicleViewController *childVehicleViewControllerRun;
@property (nonatomic, strong) WALChildAreaVehicleViewController *childVehicleViewControllerStop;
@property (nonatomic, strong) WALChildAreaVehicleViewController *childVehicleViewControllerAlarm;
@property (nonatomic, strong) WALChildAreaVehicleViewController *childVehicleViewControllerAbnormal;
@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic, strong) WALCarService *carService;

@end

@implementation WALAreaTotalVehicleViewController

- (id)init
{
    if (self = [super init]) {
        _contentsArray = @[@"运行", @"停车", @"报警", @"异常"];
        _carService = [[WALCarService alloc] init];
        _childVehicleViewControllerRun = [[WALChildAreaVehicleViewController alloc] initWithType:YLYRunStatusRunning];
        _childVehicleViewControllerStop = [[WALChildAreaVehicleViewController alloc] initWithType:YLYRunStatusStop];
        _childVehicleViewControllerAlarm = [[WALChildAreaVehicleViewController alloc] initWithType:YLYRunStatusAlarm];
        _childVehicleViewControllerAbnormal = [[WALChildAreaVehicleViewController alloc] initWithType:YLYRunStatusAbnormal];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.area.name;
    
    self.segmentedView.contentsArray = self.contentsArray;
    
    _childVehicleViewControllerRun.area = _childVehicleViewControllerStop.area = _childVehicleViewControllerAlarm.area = _childVehicleViewControllerAbnormal.area = self.area;
    _childVehicleViewControllerRun.view.frame = CGRectMake(0, self.segmentedView.bottom, self.view.width, self.view.height);
    [self addChildViewController:self.childVehicleViewControllerRun];
    self.currentViewController = self.childVehicleViewControllerRun;
    [self.view addSubview:self.currentViewController.view];
    
    [self.carService loadAreaCarListWithType:YLYRunStatusAbnormal areaID:self.area.ID completion:^(BOOL success, NSArray *carsArray, WALStatusCount *statusCount, NSString *message) {
        self.segmentedView.contentsArray = @[[NSString stringWithFormat:@"运行 %d", statusCount.runningCount], [NSString stringWithFormat:@"停车 %d", statusCount.stopCount], [NSString stringWithFormat:@"报警 %d", statusCount.alarmCount], [NSString stringWithFormat:@"异常 %d", statusCount.abnormalCount]];
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - actions

- (void)didClickChoiceSegmentView:(NSInteger)index
{
    index = index + 1;
    if ((self.currentViewController == self.childVehicleViewControllerRun && index == 1) || (self.currentViewController == self.childVehicleViewControllerStop && index == 2) || (self.currentViewController == self.childVehicleViewControllerAlarm && index == 3) || (self.currentViewController == self.childVehicleViewControllerAbnormal && index == 4)) {
        return;
    }
    switch (index) {
        case 1:
        {
            [self transitionFromViewController:self.currentViewController toViewController:self.childVehicleViewControllerRun duration:0 options:UIViewAnimationOptionCurveEaseInOut animations:nil completion:^(BOOL finished) {
                if (finished) {
                    self.currentViewController = self.childVehicleViewControllerRun;
                }
            }];
        }
            break;
        case 2:
        {if (![self.childVehicleViewControllerStop parentViewController]) {
            self.childVehicleViewControllerStop.view.frame = CGRectMake(0, self.segmentedView.bottom, self.view.width, self.view.height);
            [self addChildViewController:self.childVehicleViewControllerStop];
        }
            [self transitionFromViewController:self.currentViewController toViewController:self.childVehicleViewControllerStop duration:0 options:UIViewAnimationOptionCurveEaseInOut animations:nil completion:^(BOOL finished) {
                if (finished) {
                    self.currentViewController = self.childVehicleViewControllerStop;
                }
            }];
        }
            break;
        case 3:
        {
            if (![self.childVehicleViewControllerAlarm parentViewController]) {
                self.childVehicleViewControllerAlarm.view.frame = CGRectMake(0, self.segmentedView.bottom, self.view.width, self.view.height);
                [self addChildViewController:self.childVehicleViewControllerAlarm];
            }
            [self transitionFromViewController:self.currentViewController toViewController:self.childVehicleViewControllerAlarm duration:0 options:UIViewAnimationOptionCurveEaseInOut animations:nil completion:^(BOOL finished) {
                if (finished) {
                    self.currentViewController = self.childVehicleViewControllerAlarm;
                }
            }];
        }
            break;
        case 4:
        {
            if (![self.childVehicleViewControllerAbnormal parentViewController]) {
                self.childVehicleViewControllerAbnormal.view.frame = CGRectMake(0, self.segmentedView.bottom, self.view.width, self.view.height);
                [self addChildViewController:self.childVehicleViewControllerAbnormal];
            }
            [self transitionFromViewController:self.currentViewController toViewController:self.childVehicleViewControllerAbnormal duration:0 options:UIViewAnimationOptionCurveEaseInOut animations:nil completion:^(BOOL finished) {
                if (finished) {
                    self.currentViewController = self.childVehicleViewControllerAbnormal;
                }
            }];
        }
            break;
    }
}

#pragma mark -- getter

- (ChoiceSegmentedView *)segmentedView
{
    if (!_segmentedView) {
        _segmentedView = [[ChoiceSegmentedView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
        _segmentedView.backgroundColor = [UIColor clearColor];
        [_segmentedView setWithSize2:CGSizeMake(_segmentedView.width, _segmentedView.height)
                   backImageViewName:nil
                     segmentedNumber:[_contentsArray count]
                            contents:_contentsArray
                              images:nil
                              colors:@[[UIColor blueColor], [UIColor blackColor]]
                         selectedNum:0];
        __weak typeof(self) weakSelf = self;
        _segmentedView.forumSegmentedBlock = ^(NSInteger clickNumber){
            [weakSelf didClickChoiceSegmentView:clickNumber];
        };
        [self.view addSubview:_segmentedView];
    }
    return  _segmentedView;
}

@end
