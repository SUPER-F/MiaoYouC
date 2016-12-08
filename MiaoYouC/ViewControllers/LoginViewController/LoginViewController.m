//
//  LoginViewController.m
//  MiaoYouC
//
//  Created by drupem on 16/11/7.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"

@interface LoginViewController () <UINavigationControllerDelegate,UITextFieldDelegate,MYLoginViewDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;

    [self createLoginView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.delegate = self;
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (void)createLoginView {
    LoginView *loginView = [[LoginView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    loginView.delegate = self;
    [self.view addSubview:loginView];
}

#pragma mark - loginView delegate
- (void)loginView:(LoginView *)loginView loginMainViewWithUser:(NSString *)user andPassword:(NSString *)password {
    [UIHelper showHUDForView:self.view message:localizedString(@"requesting")];
    [[APIClient sharedInstance] login:user password:password onSuccess:^(NSArray *objects) {
        [UIHelper hideHUDForView:self.view];
        LoginResponse *response = [objects objectAtIndex:0];
        if ([response isSuccess]) {
            UserInfo *userInfo = response.data;
            userInfo.PassWord = password;
            [appDataInstance saveAccountInfo:userInfo];
            //Back to main view controller and reload data.
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            [UIHelper showMessage:response.message];
        }
    } onError:^(NSError *error) {
        [UIHelper hideHUDForView:self.view];
        [UIHelper showMessage:localizedString(@"request_failed")];
    }];
}

- (void)loginView:(LoginView *)loginView gotoForgetPasswordView:(UIButton *)sender {
    FindPasswordViewController *findPasswordVC = [[FindPasswordViewController alloc] init];
    [self.navigationController pushViewController:findPasswordVC animated:YES];
}

- (void)loginView:(LoginView *)loginView gotoRegistView:(UIButton *)sender {
    RegisterViewController *registVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
