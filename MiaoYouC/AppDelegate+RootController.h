//
//  AppDelegate+RootController.h
//  MiaoYouC
//
//  Created by drupem on 16/11/4.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (RootController)

/**
 *  首次启动轮播图
 */
- (void)createLoadingScrollView;

/**
 *  tabbar实例
 */
- (void)setTabbarController;
    
/**
 *  window实例
 */
- (void)setAppWindows;
    
/**
 *  设置根视图
 */
- (void)setRootViewController;
    
@end
