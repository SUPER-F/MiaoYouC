//
//  LoginView.h
//  MiaoYouC
//
//  Created by drupem on 16/11/11.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginView;

@protocol MYLoginViewDelegate <NSObject>

// 忘记密码
- (void)loginView:(LoginView *)loginView gotoForgetPasswordView:(UIButton *)sender;
// 登录
- (void)loginView:(LoginView *)loginView loginMainViewWithUser:(NSString *)user andPassword:(NSString *)password;
// 还未注册
- (void)loginView:(LoginView *)loginView gotoRegistView:(UIButton *)sender;

@end

@interface LoginView : UIView

@property (nonatomic, assign) id <MYLoginViewDelegate> delegate;

@end
