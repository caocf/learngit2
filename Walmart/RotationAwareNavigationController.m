//
//  RotationAwareNavigationController.m
//  DailyYoga
//
//  Created by wangxu on 14-9-30.
//  Copyright (c) 2014年 wangxu. All rights reserved.
//

#import "RotationAwareNavigationController.h"


@interface RotationAwareNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>
{
    BOOL _currentlyAnimating;
}
@end

@implementation RotationAwareNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor = [UIColor blueColor];
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationBar.tintColor = [UIColor whiteColor];
//    UIImage *imageBack = [UIImage imageNamed:@"YG_NavBack_color"];
//    [self.navigationBar setBackgroundImage:imageBack forBarMetrics:UIBarMetricsDefault];
    
//    [self.navigationBar setShadowImage:imageBack];
    self.navigationBar.shadowImage = [[UIImage alloc] init];
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = self;
        self.delegate = self;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

// Hijack the push method to disable the gesture

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(_currentlyAnimating)
    {
        return;
    }
    else if(animated)
    {
        _currentlyAnimating = YES;
    }
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if(_currentlyAnimating)
    {
        return nil;
    }
    else if(animated)
    {
        _currentlyAnimating = YES;
    }
    
    return [super popViewControllerAnimated:animated];
}
#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    _currentlyAnimating = NO;
    // Enable the gesture again once the new controller is shown
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    // Enable the gesture again once the new controller is shown
}

@end
