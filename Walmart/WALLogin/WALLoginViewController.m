#import "WALLoginViewController.h"
#import "WALTextField.h"
#import "WALLoginService.h"

@interface WALLoginViewController ()

@property (nonatomic ,strong) UIImageView *walLogoImageView;
@property (nonatomic ,strong) WALTextField *accountTextField;
@property (nonatomic ,strong) WALTextField *passwordTextField;
@property (nonatomic ,strong) UIButton *loginButton;
@property (nonatomic ,strong) UILabel *infoLabel;

@end

@implementation WALLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *backGroundImage = [UIImage imageNamed:@"bg"];
    self.view.layer.contents = (id)backGroundImage.CGImage;
    [self.walLogoImageView setImage:[UIImage imageNamed:@"open_icon"]];
    [self loadSubBackView];
     self.accountTextField.placeholder = @"用户名";
    self.passwordTextField.placeholder = @"登录密码";
    [self.accountTextField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [self.passwordTextField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [self.accountTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.loginButton addTarget:self action:@selector(didClickLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.infoLabel setText:@"易流科技©Copyright 2006-2015"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma load View
- (void)loadSubBackView {
    FXBlurView *accountBackView = [[FXBlurView alloc] initWithFrame:CGRectMake(10, self.walLogoImageView.bottom + 50, self.view.width - 20, 40)];
    accountBackView.dynamic = YES;
    accountBackView.blurRadius = 1.0;
    accountBackView.tintColor = [UIColor whiteColor];
    [FXBlurView AddRoundedCorners:accountBackView size:3 type: UIRectCornerTopLeft | UIRectCornerTopRight];
    [self.view addSubview:accountBackView];
    FXBlurView *passwordBackView = [[FXBlurView alloc] initWithFrame:CGRectMake(10, accountBackView.bottom + 1, self.view.width - 20, 40)];
    passwordBackView.dynamic = YES;
    passwordBackView.blurRadius = 1.0;
    passwordBackView.tintColor = [UIColor whiteColor];
    [FXBlurView AddRoundedCorners:passwordBackView size:3 type: UIRectCornerBottomLeft | UIRectCornerBottomRight];
    [self.view addSubview:passwordBackView];
    FXBlurView *loginBackView = [[FXBlurView alloc] initWithFrame:CGRectMake(10, passwordBackView.bottom+ 29, self.view.width - 20, 40)];
    loginBackView.dynamic = YES;
    loginBackView.blurRadius = 1.0;
    loginBackView.tintColor = [UIColor whiteColor];
    [FXBlurView AddRoundedCorners:loginBackView size:3 type:-1];
    [self.view addSubview:loginBackView];
}

#pragma mark do Action

- (void)didClickLogin {
    if ([self.accountTextField.text length] == 0 || [self.passwordTextField.text length] == 0) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"正在验证用户信息,请稍候..."];
    });

    WALLoginService *loginService = [[WALLoginService alloc] init];
    [loginService loginWithName:self.accountTextField.text
                       password:self.passwordTextField.text
                        version:([[NSUserDefaults serivceParametersVersion] length]>0?[NSUserDefaults serivceParametersVersion]:WALVersion)
                     completion:^(BOOL success, NSString *message) {
                          [DejalBezelActivityView removeViewAnimated:YES];
                         if (success) {
                             [[TKAlertCenter defaultCenter] postAlertWithMessage:@"登录成功"];
                             AppDelegate *myDelegate = [AppDelegate globalDelegate];
                             myDelegate.window.rootViewController = (UIViewController *)myDelegate.drawerViewController;
                             [myDelegate.window setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]];
                             [myDelegate configureDrawerViewController];
                             [myDelegate.window makeKeyAndVisible];
                         } else {
                             [[TKAlertCenter defaultCenter] postAlertWithMessage:message];
                         }
                     }];
}

#pragma mark setter/getter

- (UIImageView *)walLogoImageView {
    if (!_walLogoImageView) {
        _walLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.width - 140) / 2, 80, 140, 60)];
        [self.view addSubview:_walLogoImageView];
    }
    return _walLogoImageView;
}

- (WALTextField *)accountTextField {
    if (!_accountTextField) {
        _accountTextField = [[WALTextField alloc] initWithFrame:CGRectMake(20, self.walLogoImageView.bottom + 50, self.view.width - 40, 40)];
        _accountTextField.textColor = [UIColor whiteColor];
        _accountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _accountTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my_center"]];
        _accountTextField.leftViewMode = UITextFieldViewModeAlways;
        [_accountTextField setFont:[UIFont systemFontOfSize:14.f]];
        _accountTextField.tintColor = [UIColor whiteColor];
        [_accountTextField setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:_accountTextField];
    }
    return _accountTextField;
}

- (WALTextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[WALTextField alloc] initWithFrame:CGRectMake(20, self.accountTextField.bottom , self.view.width - 40, 40)];
        _passwordTextField.textColor = [UIColor whiteColor];
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTextField.isSecure = YES;
        _passwordTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_password"]];
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
            _passwordTextField.rightViewMode = UITextFieldViewModeAlways;
        [_passwordTextField setFont:[UIFont systemFontOfSize:14.f]];
        [_passwordTextField setSecureTextEntry:YES];
        _passwordTextField.tintColor = [UIColor whiteColor];
        [_passwordTextField setBackgroundColor:[UIColor clearColor]];
        UIButton *secureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [secureBtn setImage:[UIImage imageNamed:@"icon_password"] forState:UIControlStateNormal];
        _passwordTextField.rightView = secureBtn;
        [secureBtn addTarget:_passwordTextField action:@selector(setSecureTextEntry:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_passwordTextField];
    }
    return _passwordTextField;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(10, self.passwordTextField.bottom + 30, self.view.width - 20, 40)];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:_loginButton];
    }
    return _loginButton;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.height - 20 - 20, self.view.width, 20)];
        _infoLabel.textColor = [UIColor whiteColor];
        _infoLabel.font = Font(10);
        [_infoLabel setTextAlignment:NSTextAlignmentCenter];
        [self.view addSubview:_infoLabel];
    }
    return _infoLabel;
}
@end
