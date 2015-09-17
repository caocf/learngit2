//
//  YLYTabBarController.m
//  Walmart
//
//  Created by zen on 15/9/11.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "YLYTabBarController.h"
#import "WALHomeViewController.h"
#import "WALWaybillViewController.h"
#import "WALVehicleViewController.h"
#import "RotationAwareNavigationController.h"

@interface YLYTabBarController () <UITabBarDelegate>

@end

@implementation YLYTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.tintColor = RGB(kMainColor);
    self.tabBar.barTintColor = RGB(0xf0f0f0);
    WALHomeViewController *homeViewController = [[WALHomeViewController alloc] init];
    homeViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"nav_index.png"] selectedImage:[UIImage imageNamed:@"nav_index_now.png"]];
    homeViewController.tabBarItem.tag = 0;
    WALWaybillViewController *waybillViewController = [[WALWaybillViewController alloc] init];
    waybillViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"动态" image:[UIImage imageNamed:@"nav_moving.png"] selectedImage:[UIImage imageNamed:@"nav_moving_now.png"]];
    waybillViewController.tabBarItem.tag = 1;
    WALVehicleViewController *vehicleViewController = [[WALVehicleViewController alloc] init];
    vehicleViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"车辆" image:[UIImage imageNamed:@"nav_car.png"] selectedImage:[UIImage imageNamed:@"nav_car_now.png"]];
    vehicleViewController.tabBarItem.tag = 2;
    NSArray *viewControllerArray = @[homeViewController,waybillViewController,vehicleViewController];
    NSMutableArray *navigationControllerArray = [NSMutableArray array];
    for (UIViewController *viewController in viewControllerArray) {
        RotationAwareNavigationController *navigationController = [[RotationAwareNavigationController alloc] initWithRootViewController:viewController];
        navigationController.tabBarItem = viewController.tabBarItem;
        navigationController.navigationBar.barTintColor = RGB(kMainColor);
        navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [navigationControllerArray addObject:navigationController];
    }
    self.viewControllers = navigationControllerArray;
}

@end
