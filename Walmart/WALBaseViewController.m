//
//  WALBaseViewController.m
//  Walmart
//
//  Created by zen on 15/9/11.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALBaseViewController.h"

@interface WALBaseViewController ()

@end

@implementation WALBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"my_center"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickLeftBarButtonItem:)];
    if (self.isAddBackViewGesture) {
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapGesture)];
        [self.view addGestureRecognizer:tapGestureRecognizer];
    }
 }

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (![NetworkCheckUtil canConnectToNetwork]) {
      [[TKAlertCenter defaultCenter] postAlertWithMessage:@"网络不可用,请检查您的网络设置"];
    }

}

#pragma Action

- (void)didTapGesture
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)didClickLeftBarButtonItem:(id)sender{
    [[AppDelegate globalDelegate] toggleLeftDrawer:self animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
