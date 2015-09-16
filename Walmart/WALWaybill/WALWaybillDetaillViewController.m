//
//  WALWaybillDetaillViewController.m
//  Walmart
//
//  Created by zen on 15/9/15.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALWaybillDetaillViewController.h"

@interface WALWaybillDetaillViewController () {
}

@property (nonatomic ,strong) BMKMapView* mapView;

@end

@implementation WALWaybillDetaillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [self.mapView viewWillAppear];
     self.mapView.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark loadViewAction

- (void)loadViewMapView {
    BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
    [self.view addSubview:mapView];
}

#pragma mark setter/getter

- (BMKMapView *)mapView {
    if (!_mapView) {
       _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
        [self.view addSubview:_mapView];
    }
    return _mapView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
