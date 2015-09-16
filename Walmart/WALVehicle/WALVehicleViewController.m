//
//  WALVehicleViewController.m
//  Walmart
//
//  Created by zen on 15/9/11.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALVehicleViewController.h"
#import "WALTotalVehicleViewController.h"
#import "WALAreaVehicleViewController.h"
#import "ChoiceSegmentedView.h"

@interface WALVehicleViewController ()

@property (nonatomic, strong) WALTotalVehicleViewController *totalVehicleViewController;
@property (nonatomic, strong) WALAreaVehicleViewController *areaVehicleViewController;
@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic, strong) ChoiceSegmentedView *segmentedView;

@end

@implementation WALVehicleViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _totalVehicleViewController = [[WALTotalVehicleViewController alloc] init];
        _areaVehicleViewController = [[WALAreaVehicleViewController alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.titleView = self.segmentedView;
    self.view.height = self.view.height - self.navigationController.navigationBar.height - self.tabBarController.tabBar.height - 20;
    
    _totalVehicleViewController.view.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    [self addChildViewController:self.totalVehicleViewController];
    self.currentViewController = self.totalVehicleViewController;
    [self.view addSubview:self.currentViewController.view];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - actions

- (void)didClickChoiceSegmentView:(NSInteger)index
{
    index = index + 1;
    if ((self.currentViewController == self.totalVehicleViewController && index == 1) ||
        (self.currentViewController == self.areaVehicleViewController && index == 2)) {
        return;
    }
    switch (index) {
        case 1:
        {
            [self transitionFromViewController:self.currentViewController toViewController:self.totalVehicleViewController duration:0 options:UIViewAnimationOptionCurveEaseInOut animations:nil completion:^(BOOL finished) {
                if (finished) {
                    self.currentViewController = self.totalVehicleViewController;
                }
            }];
        }
            break;
        case 2:
        {
            if (![self.areaVehicleViewController parentViewController]) {
                self.areaVehicleViewController.view.frame = CGRectMake(0, 0, self.view.width, self.view.height);
                [self addChildViewController:self.areaVehicleViewController];
            }
            [self transitionFromViewController:self.currentViewController toViewController:self.areaVehicleViewController duration:0 options:UIViewAnimationOptionCurveEaseInOut animations:nil completion:^(BOOL finished) {
                if (finished) {
                    self.currentViewController = self.areaVehicleViewController;
                }
            }];
        }
            break;
    }
}

#pragma mark - getter/setter

- (ChoiceSegmentedView *)segmentedView
{
    if (!_segmentedView) {
        _segmentedView = [[ChoiceSegmentedView alloc] initWithFrame:CGRectMake(0, 0, 180, 44)];
        _segmentedView.backgroundColor = [UIColor clearColor];
        NSArray *contents = @[@"全部车辆", @"区域车辆"];
        [_segmentedView setWithSize2:CGSizeMake(_segmentedView.width, _segmentedView.height)
                   backImageViewName:nil
                     segmentedNumber:[contents count]
                            contents:contents
                              images:nil
                              colors:@[[UIColor whiteColor], [UIColor redColor]]
                         selectedNum:0];
        __weak typeof(self) weakSelf = self;
        _segmentedView.forumSegmentedBlock = ^(NSInteger clickNumber){
            [weakSelf didClickChoiceSegmentView:clickNumber];
        };
    }
    return  _segmentedView;
}


@end
