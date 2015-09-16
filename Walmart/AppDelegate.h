//
//  AppDelegate.h
//  Walmart
//
//  Created by zen on 15/9/11.
//  Copyright (c) 2015年 e6. All rights reserved.
//

@class JVFloatingDrawerViewController;
@class JVFloatingDrawerSpringAnimator;
@class WALSettingViewController;
@class YLYTabBarController;
@class WALLoginViewController;

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) JVFloatingDrawerViewController *drawerViewController;
@property (nonatomic, strong) JVFloatingDrawerSpringAnimator *drawerAnimator;
@property (nonatomic, strong) WALSettingViewController *settingViewController;
@property (nonatomic, strong) YLYTabBarController *tabBarController;
@property (nonatomic, strong) WALLoginViewController *loginViewController;


+ (AppDelegate *)globalDelegate;
- (void)toggleLeftDrawer:(id)sender animated:(BOOL)animated;
- (void)toggleRightDrawer:(id)sender animated:(BOOL)animated;
- (void)configureDrawerViewController;

@end