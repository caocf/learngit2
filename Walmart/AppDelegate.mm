//
//  AppDelegate.m
//  Walmart
//
//  Created by zen on 15/9/11.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "AppDelegate.h"
#import "YLYTabBarController.h"
#import "JVFloatingDrawerViewController.h"
#import "JVFloatingDrawerSpringAnimator.h"
#import "WALSettingViewController.h"
#import "YLYTabBarController.h"
#import "WALLoginViewController.h"

@interface AppDelegate () {

 BMKMapManager *mapManager;

}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    if ([NSUserDefaults isLogin]) {
        self.window.rootViewController = self.drawerViewController;
        [self.window setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]];
        [self configureDrawerViewController];
    } else {
        self.window.rootViewController = self.loginViewController;
    }
    [self.window makeKeyAndVisible];
    [self loadMapManager];
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark loadAction

- (void)loadMapManager {
    mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [mapManager start:BaiduMapAK generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}

#pragma mark loadView Action

- (void)configureDrawerViewController {
    self.drawerViewController.leftViewController = self.settingViewController;
    self.drawerViewController.rightViewController = [[UIViewController alloc] init];
    self.drawerViewController.centerViewController = self.tabBarController;
    self.drawerViewController.animator = self.drawerAnimator;
    self.drawerViewController.backgroundImage = [UIImage imageNamed:@"sky"];
}

#pragma mark setter/geter Action

- (JVFloatingDrawerSpringAnimator *)drawerAnimator {
    if (!_drawerAnimator) {
        _drawerAnimator = [[JVFloatingDrawerSpringAnimator alloc] init];
    }
    
    return _drawerAnimator;
}

- (JVFloatingDrawerViewController *)drawerViewController {
    if (!_drawerViewController) {
        _drawerViewController = [[JVFloatingDrawerViewController alloc] init];
    }
    
    return _drawerViewController;
}

- (WALSettingViewController *)settingViewController {
    if (!_settingViewController) {
        _settingViewController = [[WALSettingViewController alloc] init];
    }
    
    return _settingViewController;
}

- (YLYTabBarController *)tabBarController {
    if (!_tabBarController) {
        _tabBarController = [[YLYTabBarController alloc] init];
    }
    
    return _tabBarController;
}

- (WALLoginViewController *)loginViewController {
    if (!_loginViewController) {
        _loginViewController = [[WALLoginViewController alloc] init];
    }
    _loginViewController.isAddBackViewGesture = YES;
    return _loginViewController;
}
- (void)toggleLeftDrawer:(id)sender animated:(BOOL)animated {
    [self.drawerViewController toggleDrawerWithSide:JVFloatingDrawerSideLeft animated:animated completion:nil];
}

- (void)toggleRightDrawer:(id)sender animated:(BOOL)animated {
    [self.drawerViewController toggleDrawerWithSide:JVFloatingDrawerSideRight animated:animated completion:nil];
}

+ (AppDelegate *)globalDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

@end
