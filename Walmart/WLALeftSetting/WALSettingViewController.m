//
//  WALSettingViewController.m
//  Walmart
//
//  Created by zen on 15/9/11.
//  Copyright (c) 2015年 e6. All rights reserved.
//

#import "WALSettingViewController.h"
#import "WALLoginViewController.h"

@interface WALSettingViewController ()

@property (nonatomic ,strong) UIImageView *walLogoImageView;
@property (nonatomic ,strong) UILabel *walNameLable;
@property (nonatomic ,strong) UIButton *logOutButton;

@end

@implementation WALSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.walLogoImageView setImage:[UIImage imageNamed:@"personalinfo_pic"]];
    [self.walNameLable setText:@"Walmart"];
    [self loadSettinngBtnViews];
    [self.logOutButton setTitle:@"退出当前账号" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Load Action 

- (void) loadSettinngBtnViews {
    NSArray *setViewResourceArray = [NSArray getSettingBtnViewResourceArray];
    for (NSDictionary *resourceDic in setViewResourceArray) {
        WALSettingBtnView *btnView = [[WALSettingBtnView alloc] init];
        NSInteger btnViewIndex = [resourceDic intValue:@"index"];
        if (btnViewIndex == 0) {
            [btnView loadBtnViewWithSize:CGSizeMake(200, 40) resource:resourceDic target:self action:@selector(didClickSetting)];
        } else if (btnViewIndex == 1) {
            [btnView loadBtnViewWithSize:CGSizeMake(200, 40) resource:resourceDic target:self action:@selector(didClickChangePassword)];
        } else if (btnViewIndex == 2) {
            [btnView loadBtnViewWithSize:CGSizeMake(200, 40) resource:resourceDic target:self action:@selector(didClickFeedBack)];
        }
        btnView.top = self.walNameLable.bottom + 20 + btnViewIndex * 40;
        btnView.left = 0;
        [self.view addSubview:btnView];
    }
}

#pragma mark do Action 
- (void) didClickSetting {
    
}

- (void) didClickChangePassword {
    
}

- (void) didClickFeedBack {
    
}

- (void) didClickLogOut {
    [NSUserDefaults userLogout];
    AppDelegate *myDelegate = [AppDelegate globalDelegate];
    myDelegate.window.rootViewController = myDelegate.loginViewController;
    [myDelegate.window makeKeyAndVisible];

}
#pragma mark setter/getter

- (UIImageView *)walLogoImageView {
    if (!_walLogoImageView) {
        _walLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((200.0 - 80) / 2,40, 80, 80)];
        [self.view addSubview:_walLogoImageView];
    }
    return _walLogoImageView;
}

- (UILabel *)walNameLable {
    if (!_walNameLable) {
        _walNameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.walLogoImageView.bottom, 200.0, 25)];
        [_walNameLable setTextColor:[UIColor whiteColor]];
        [_walNameLable setTextAlignment:NSTextAlignmentCenter];
        [self.view addSubview:_walNameLable];
    }
    return _walNameLable;
}

- (UIButton *)logOutButton {
    if (!_logOutButton) {
        _logOutButton = [[UIButton alloc] initWithFrame:CGRectMake(20, self.view.height - 150, 160, 40)];
        [_logOutButton.layer setMasksToBounds:YES];
        [_logOutButton.layer setCornerRadius:8];
        [_logOutButton.layer setBorderWidth:1.5];
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){1,1,1,1});
        [_logOutButton.layer setBorderColor:color];
        [_logOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_logOutButton addTarget:self action:@selector(didClickLogOut) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_logOutButton];
    }
    return _logOutButton;
}
@end
