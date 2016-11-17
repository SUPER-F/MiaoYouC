//
//  LoginView.m
//  MiaoYouC
//
//  Created by drupem on 16/11/11.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import "LoginView.h"

@interface LoginView ()

@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIImageView *userLine;
@property (nonatomic, strong) UIImageView *passwordLine;
@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 背景图
        [self creatBackgroundView];
        // 用户
        [self creatUserView];
        // 密码
        [self creatPasswordView];
        // 忘记密码
        [self creatForgetPasswordButton];
        // 登录按钮
        [self creatLoginButton];
        // 还未注册
        [self creatNotHaveRegistButton];
        // 微信登录
        //[self creatWechatLoginButton];
    }
    
    return self;
}

- (void)creatBackgroundView {
    // 背景图
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    bgImgView.image = [UIImage imageNamed:@"login_bg"];
    [self addSubview:bgImgView];
}

- (void)creatUserView {
    __weak typeof(self) weakSelf = self;
    // 用户
    UIImageView *userImgView = [[UIImageView alloc] init];
    userImgView.image = [UIImage imageNamed:@"user"];
    [self addSubview:userImgView];
    [userImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(40);
        make.top.equalTo(weakSelf).offset(100);
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(29);
    }];
    
    UITextField *usernameTextField = [[UITextField alloc] init];
    usernameTextField.backgroundColor = [UIColor clearColor];
    usernameTextField.textColor = [UIColor whiteColor];
    usernameTextField.font = [UIFont systemFontOfSize:MYLoginAndRegistFont];
    usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    usernameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"please_input_telephone", nil) attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self addSubview:usernameTextField];
    [usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(userImgView.mas_bottom);
        make.left.equalTo(userImgView.mas_right).offset(5);
        make.right.equalTo(weakSelf).offset(-40);
        make.height.mas_equalTo(20);
    }];
    self.usernameTextField = usernameTextField;
    
    UIImageView *userLine = [[UIImageView alloc] init];
    userLine.image = [UIImage imageNamed:@"login_Line"];
    [self addSubview:userLine];
    [userLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userImgView.mas_left);
        make.top.equalTo(usernameTextField.mas_bottom).offset(10);
        make.right.equalTo(usernameTextField.mas_right);
        make.height.mas_equalTo(1);
    }];
    self.userLine = userLine;
}

- (void)creatPasswordView {
    __weak typeof(self) weakSelf = self;
    // 密码
    UIImageView *passwordImgView = [[UIImageView alloc] init];
    passwordImgView.image = [UIImage imageNamed:@"password"];
    [self addSubview:passwordImgView];
    [passwordImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userLine);
        make.top.equalTo(_userLine).offset(10);
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(29);
    }];
    
    UITextField *passwordTextField = [[UITextField alloc] init];
    passwordTextField.backgroundColor = [UIColor clearColor];
    passwordTextField.textColor = [UIColor whiteColor];
    passwordTextField.font = [UIFont systemFontOfSize:MYLoginAndRegistFont];
    passwordTextField.secureTextEntry = YES;
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"please_input_password", nil) attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self addSubview:passwordTextField];
    [passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(passwordImgView.mas_bottom);
        make.left.equalTo(passwordImgView.mas_right).offset(5);
        make.right.equalTo(weakSelf).offset(-40);
        make.height.mas_equalTo(20);
    }];
    self.passwordTextField = passwordTextField;
    
    UIImageView *passwordLine = [[UIImageView alloc] init];
    passwordLine.image = [UIImage imageNamed:@"login_Line"];
    [self addSubview:passwordLine];
    [passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwordImgView.mas_left);
        make.top.equalTo(passwordTextField.mas_bottom).offset(10);
        make.right.equalTo(passwordTextField.mas_right);
        make.height.mas_equalTo(1);
    }];
    self.passwordLine = passwordLine;
}

- (void)creatForgetPasswordButton {
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetBtn setTitle:NSLocalizedString(@"forgetPassword", nil) forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetPasswordBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordLine.mas_bottom).offset(20);
        make.right.equalTo(_passwordLine.mas_right).offset(-20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
}

- (void)creatLoginButton {
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_blue"] forState:UIControlStateNormal];
    [loginBtn setTitle:NSLocalizedString(@"login", nil) forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordLine.mas_bottom).offset(100);
        make.left.equalTo(_passwordLine.mas_left);
        make.right.equalTo(_passwordLine.mas_right);
        make.height.mas_equalTo(50);
    }];
    self.loginBtn = loginBtn;
}

- (void)creatNotHaveRegistButton {
    UIButton *notRegistBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [notRegistBtn setTitle:NSLocalizedString(@"notHaveRegist", nil) forState:UIControlStateNormal];
    [notRegistBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [notRegistBtn addTarget:self action:@selector(notRegistBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:notRegistBtn];
    [notRegistBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginBtn.mas_bottom).offset(20);
        make.right.equalTo(_loginBtn.mas_right).offset(-20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
}

- (void)creatWechatLoginButton {
    __weak typeof(self) weakSelf = self;
    
    UILabel *wechatLabel = [[UILabel alloc] init];
    wechatLabel.text = NSLocalizedString(@"wechatLogin", nil);
    wechatLabel.textColor = [UIColor whiteColor];
    wechatLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:wechatLabel];
    [wechatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-100);
        make.centerX.equalTo(_loginBtn.mas_centerX);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    
    UIImageView *leftLine = [[UIImageView alloc] init];
    leftLine.image = [UIImage imageNamed:@"login_Line"];
    [self addSubview:leftLine];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wechatLabel.mas_centerY);
        make.left.equalTo(_loginBtn.mas_left);
        make.right.equalTo(wechatLabel.mas_left).offset(-20);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *rightLine = [UIImageView new];
    rightLine.image = [UIImage imageNamed:@"login_Line"];
    [self addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wechatLabel.mas_centerY);
        make.left.equalTo(wechatLabel.mas_right).offset(20);
        make.right.equalTo(_loginBtn.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *wechatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [wechatBtn setBackgroundImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
    [self addSubview:wechatBtn];
    [wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wechatLabel.mas_bottom).offset(20);
        make.centerX.equalTo(wechatLabel.mas_centerX);
        make.width.mas_equalTo(62);
        make.height.mas_equalTo(50);
    }];
}

#pragma mark - private
- (void)forgetPasswordBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginView:gotoForgetPasswordView:)]) {
        [self.delegate loginView:self gotoForgetPasswordView:sender];
    }
}

- (void)loginBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginView:loginMainViewWithUser:andPassword:)]) {
        [self.delegate loginView:self loginMainViewWithUser:_usernameTextField.text andPassword:_passwordTextField.text];
    }
}

- (void)notRegistBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginView:gotoRegistView:)]) {
        [self.delegate loginView:self gotoRegistView:sender];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
