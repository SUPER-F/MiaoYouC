//
//  BaseViewController.m
//  MiaoYouC
//
//  Created by drupem on 16/11/4.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController () {
    UIImageView *_barImage;
    
    NSTimer * _flashMessageBtnTimer;
}

@end

@implementation BaseViewController

#pragma mark - viewController.lifeCircle
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    [self rdv_tabBarController].navigationItem.titleView = nil;
    if ([self isKindOfClass:[DiscoverViewController class]])
    {
        [self messageBar];
    }
    else
    {
        [self rdv_tabBarController].navigationItem.rightBarButtonItem = nil;
        [self rdv_tabBarController].navigationItem.rightBarButtonItems = nil;
    }
    
    [self rdv_tabBarController].navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    if (self.rdv_tabBarController.isTabBarHidden == _isShowTabbar)
    {//返回正常Tabbar
        [self.rdv_tabBarController setTabBarHidden:!_isShowTabbar];
    }
    
    if ([SZUserDefault boolForKey:@"GETNotifation"])
    {
        [self getMessage];
    }
    else
    {
        _barImage.image = [UIImage imageNamed:@"tixing_xiaoxi"];
    }
    
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _isShowTabbar = YES;
    
    self.hidesBottomBarWhenPushed = YES;
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    [self setUpNav];
    
    [self createNavBar];
    
    [SZNotificationCenter addObserver:self selector:@selector(getMessage) name:@"GETNotifation" object:nil];
    
    [SZNotificationCenter addObserver:self selector:@selector(cancelFlash) name:@"cancelMessageButtonFlash" object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)dealloc{
    [SZNotificationCenter removeObserver:self name:@"GETNotifation" object:nil];
    [SZNotificationCenter removeObserver:self name:@"cancelMessageButtonFlash" object:nil];
}

- (void)initStatusBar
{
    self.statusNotifation = [CWStatusBarNotification new];
    
    self.statusNotifation.notificationLabelBackgroundColor = [UIColor whiteColor];
    self.statusNotifation.notificationLabelTextColor = [UIColor whiteColor];
}

- (void)showStatusBarWithTitle:(NSString *)title
{
    [self.statusNotifation displayNotificationWithMessage:@"正在发送中..." completion:^{
        
    }];
}

- (void)changeStatusBarTitle:(NSString *)title
{
    self.statusNotifation.notificationLabel.text = title;
}

- (void)hiddenStatusBar
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.statusNotifation dismissNotification];
    });
    
}



#pragma mark - NavgationItem.set
- (void)setUpNav
{
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -64) forBarMetrics:UIBarMetricsDefault];
    [self messageBar];
}



- (void)messageBar
{
    _barImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tixing_xiaoxi"] ];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickMessage)];
    [_barImage addGestureRecognizer:tap];
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:_barImage];
    
    [self rdv_tabBarController].navigationItem.rightBarButtonItem = bar;
}

- (void)getMessage
{
    _barImage.image = [UIImage imageNamed:@"tixing_xiaoxi_pre"];
    
    if (!_flashMessageBtnTimer.isValid) {
        _flashMessageBtnTimer = [NSTimer scheduledTimerWithTimeInterval:0.7 target:self selector:@selector(flash) userInfo:nil repeats:YES];
    }
}

-(void)flash{
    _barImage.hidden = !_barImage.isHidden;
}

- (void)clickMessage
{
    [SZUserDefault setBool:NO forKey:@"GETNotifation"];
    [SZUserDefault synchronize];
    
    [SZNotificationCenter postNotificationName:@"cancelMessageButtonFlash" object:nil];
    
    if (/* DISABLES CODE */ (0))
    {
        [self showShouldLoginPoint];
    }
    else
    {
        MessageViewController *mess = [[MessageViewController alloc]init];
        _barImage.image = [UIImage imageNamed:@"tixing_xiaoxi"];
        [self.navigationController pushViewController:mess animated:YES];
    }
}

-(void)cancelFlash{
    [_flashMessageBtnTimer invalidate];
    _barImage.image = [UIImage imageNamed:@"tixing_xiaoxi"];
}


#pragma mark - table.set
-(void)viewDidLayoutSubviews
{
    __block UITableView* table;
    [self.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UITableView class]]) {
            table=obj;
        }
    }];
    if ([table respondsToSelector:@selector(setSeparatorInset:)]) {
        [table setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([table respondsToSelector:@selector(setLayoutMargins:)]) {
        [table setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// 没有数据时候的图片
//-(void)showNoDataImage
//{
//    _noDataView=[[UIImageView alloc] init];
//    [_noDataView setImage:[UIImage imageNamed:@"generl_nodata"]];
//    [self.view.subviews enumerateObjectsUsingBlock:^(UITableView* obj, NSUInteger idx, BOOL *stop) {
//        if ([obj isKindOfClass:[UITableView class]]) {
//            [_noDataView setFrame:CGRectMake(0, 0,obj.frame.size.width, obj.frame.size.height)];
//            [obj addSubview:_noDataView];
//        }
//    }];
//}
//
//-(void)removeNoDataImage{
//    if (_noDataView) {
//        [_noDataView removeFromSuperview];
//    }
//}


#pragma mark - API
//- (void)shareUrl:(NSString *)url andTitle:(NSString *)title
//{
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
//    [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
//    
//    [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
//    [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
//    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
//    
//    [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
//    [UMSocialData defaultData].extConfig.qqData.url = url;
//    [UMSocialData defaultData].extConfig.qqData.title = title;
//    
//    [UMSocialData defaultData].extConfig.qzoneData.url = url;
//    [UMSocialData defaultData].extConfig.qzoneData.title = title;
//    
//    [UMSocialData defaultData].extConfig.alipaySessionData.url = url;
//    [UMSocialData defaultData].extConfig.alipaySessionData.title = title;
//    
//    [UMSocialSnsService presentSnsIconSheetView:self appKey:UmengAppKey shareText:title shareImage:[UIImage imageNamed:@"icon"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline, nil] delegate:self];
//}
//
//- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
//{
//    if(response.responseCode == UMSResponseCodeSuccess)
//    {
//        NSLog(@"分享的平台: %@",[[response.data allKeys] objectAtIndex:0]);
//    }
//}



/**
 *  登录提示窗
 */
- (void)showShouldLoginPoint
{
    if (!self.actionSheet) {
        self.actionSheet = [MSAlertController alertControllerWithTitle:@"温馨提示" message:@"只有登录账户才能做此操作" preferredStyle:MSAlertControllerStyleAlert];
        self.actionSheet.titleFont = [UIFont systemFontOfSize:16];
        self.actionSheet.titleColor = [UIColor blackColor];
        self.actionSheet.messageColor = [UIColor blackColor];
        
        MSAlertAction *action1 = [MSAlertAction actionWithTitle:@"已有账号，立即登录" style:MSAlertActionStyleDefault handler:^(MSAlertAction *action) {
            
            [self goLogin];
        }];
        action1.titleColor = [UIColor blueColor];
        action1.font = [UIFont systemFontOfSize:14];
        [self.actionSheet addAction:action1];
        
        MSAlertAction *action2 = [MSAlertAction actionWithTitle:@"没有账号？立即注册" style:MSAlertActionStyleDefault handler:^(MSAlertAction *action) {
            
            RegisterViewController *reg = [[RegisterViewController alloc]init];
            reg.navigationItem.title = @"注册";
            [[AppDelegate rootNavigationController] pushViewController:reg animated:YES];
            
        }];
        action2.font = [UIFont systemFontOfSize:14];
        action2.titleColor = [UIColor blueColor];
        [self.actionSheet addAction:action2];
        
        MSAlertAction *action = [MSAlertAction actionWithTitle:@"暂不登录" style:MSAlertActionStyleDefault handler:^(MSAlertAction *action) {
            return ;
        }];
        action.font = [UIFont systemFontOfSize:14];
        action.titleColor = [UIColor redColor];
        [self.actionSheet addAction:action];
    }
    
    
    
    [self presentViewController:self.actionSheet animated:YES completion:^{
        
        //        [self.actionSheet dismissViewControllerAnimated:YES completion:^{
        //
        //        }];
    }];
}

- (void)goLogin
{
    LoginViewController *login = [[LoginViewController alloc]init];
    [[AppDelegate rootNavigationController] pushViewController:login animated:NO];
    
}

- (void)createNavBar
{
    self.view.backgroundColor = RGBColor(241, 241, 241);
}

- (void)showLoadingAnimationView:(UIView *)view
{
    
    [MBProgressHUD showHUDAddedTo:view
                         animated:YES];
}

- (void)stopLoadingAnimationView:(UIView *)view
{
    [MBProgressHUD hideHUDForView:view
                         animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
