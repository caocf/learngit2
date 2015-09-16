//
//  WALWaybillViewController.m
//  Walmart
//
//  Created by zen on 15/9/11.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALWaybillViewController.h"
#import "WALWaybillDetaillViewController.h"
@interface WALWaybillViewController ()

@end

@implementation WALWaybillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    [btn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:btn];
}

- (void)test {
    WALWaybillDetaillViewController *b = [[WALWaybillDetaillViewController alloc] init];
    [self.navigationController pushViewController:b animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
