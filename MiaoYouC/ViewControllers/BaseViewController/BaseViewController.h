//
//  BaseViewController.h
//  MiaoYouC
//
//  Created by drupem on 16/11/4.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic,strong)CWStatusBarNotification *statusNotifation;
- (void)messageBar;
/**
 *  是否显示tabbar
 */
@property (nonatomic,assign)Boolean isShowTabbar;

/**
 *  需要登录的提示窗口
 */
@property (nonatomic,strong)MSAlertController *actionSheet;

- (void)createNavBar;

/**
 *  显示没有数据页面
 */
//-(void)showNoDataImage;

/**
 *  移除无数据页面
 */
//-(void)removeNoDataImage;

/**
 *  需要登录
 */
- (void)showShouldLoginPoint;

/**
 *  加载视图
 */
- (void)showLoadingAnimationView:(UIView *)view;


/**
 *  停止加载
 */
- (void)stopLoadingAnimationView:(UIView *)view;

/**
 *  分享页面
 *
 *  @param url   url
 *  @param title 标题
 */
//- (void)shareUrl:(NSString *)url andTitle:(NSString *)title;

- (void)goLogin;

/**
 *  状态栏
 */
- (void)initStatusBar;

- (void)showStatusBarWithTitle:(NSString *)title;

- (void)changeStatusBarTitle:(NSString *)title;
- (void)hiddenStatusBar;

// 搜索框
- (void)searchButtonClick:(UIButton *)sender;
- (void)didSelectRow:(NSInteger)row;

@end
