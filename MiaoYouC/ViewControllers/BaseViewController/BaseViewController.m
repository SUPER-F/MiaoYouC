//
//  BaseViewController.m
//  MiaoYouC
//
//  Created by drupem on 16/11/4.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import "BaseViewController.h"
#import "SearchResultTableViewController.h"

@interface BaseViewController () <UITextFieldDelegate, SearchResultTableViewControllerDelegate> {
    UIImageView *_barImage;
    
    UITextField *_searchTextField;
    
    NSTimer * _flashMessageBtnTimer;
}

@property (nonatomic, strong) SearchResultTableViewController *searchResultVC;
/** 记录键盘高度 */
@property (nonatomic, assign) CGFloat keyboardHeight;
/** 城市列表 */
@property (nonatomic, copy) NSMutableArray *cityArray;
// 搜索蒙版
@property (nonatomic, strong) UIView *searchBgView;

@end

@implementation BaseViewController

#pragma mark - viewController.lifeCircle
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // 导航栏消息
    if ([self isKindOfClass:[DestinationViewController class]] || [self isKindOfClass:[TakeMePlayViewController class]] || [self isKindOfClass:[DiscoverViewController class]] || [self isKindOfClass:[FindButlerViewController class]]) {
        
        [self messageBar];
    }
    else {
        [self rdv_tabBarController].navigationItem.rightBarButtonItem = nil;
        [self rdv_tabBarController].navigationItem.rightBarButtonItems = nil;
    }
    
    // 导航栏搜索
    if ([self isKindOfClass:[DestinationViewController class]]) {
        [self searchBar];
    }
    else {
        [self rdv_tabBarController].navigationItem.titleView = nil;
    }
    
    // 导航栏显示/隐藏
    if ([self isKindOfClass:[MyViewController class]]) {
        self.navigationController.navigationBarHidden = YES;
    }
    else {
        self.navigationController.navigationBarHidden = NO;
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
        _barImage.image = [UIImage imageNamed:@"destination_message"];
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
    
    _cityArray = [NSMutableArray arrayWithCapacity:200];
    for (int i = 0; i < 200; i ++) {
        int NUMBER_OF_CHARS = 5;
        char data[NUMBER_OF_CHARS];//生成一个五位数的字符串
        for (int x=0;x<10;data[x++] = (char)('A' + (arc4random_uniform(26))));
        NSString *string = [[NSString alloc] initWithBytes:data length:5 encoding:NSUTF8StringEncoding];//随机给字符串赋值
        [_cityArray addObject:string];
    }//随机生成200个五位数的字符串
    
    _isShowTabbar = YES;
    
    self.hidesBottomBarWhenPushed = YES;
    
    self.navigationController.navigationBar.translucent = YES;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    [self setUpNav];
    
    [self createNavBar];
    
    [SZNotificationCenter addObserver:self selector:@selector(getMessage) name:@"GETNotifation" object:nil];
    
    [SZNotificationCenter addObserver:self selector:@selector(cancelFlash) name:@"cancelMessageButtonFlash" object:nil];
    // 键盘出现通知
    [SZNotificationCenter addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    // UITextfield改变通知
    [SZNotificationCenter addObserver:self selector:@selector(textfieldDidChange) name:UITextFieldTextDidChangeNotification object:nil];
    
}

- (void)viewDidAppear:(BOOL)animated {
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
//    [self searchBar];
}

- (void)searchBar {

    CGRect mainViewBounds = self.navigationController.view.bounds;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(mainViewBounds)/2-((CGRectGetWidth(mainViewBounds)-120)/2), CGRectGetMinY(mainViewBounds)+7, CGRectGetWidth(mainViewBounds)-120, 30)];
    bgView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    bgView.layer.borderWidth = 0.5;
    bgView.layer.cornerRadius = 6;
    bgView.clipsToBounds = YES;
    
    _searchTextField = [[UITextField alloc] init];
//    _searchTextField.frame = CGRectMake(CGRectGetWidth(mainViewBounds)/2-((CGRectGetWidth(mainViewBounds)-120)/2), CGRectGetMinY(mainViewBounds)+7, CGRectGetWidth(mainViewBounds)-120, 30);
    _searchTextField.frame = CGRectMake(0, 0, CGRectGetWidth(bgView.bounds) - 40, CGRectGetHeight(bgView.bounds));
    _searchTextField.borderStyle = UITextBorderStyleNone;
    _searchTextField.layer.borderWidth = 0.5;
    _searchTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _searchTextField.placeholder = @"请输入城市";
    _searchTextField.delegate = self;
    [bgView addSubview:_searchTextField];
    
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(CGRectGetMaxX(_searchTextField.bounds)-0.5, 0, 40+0.5, 30);
    searchBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    searchBtn.layer.borderWidth = 0.5;
    [searchBtn setImage:[UIImage imageNamed:@"destination_search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:searchBtn];
    

    [self rdv_tabBarController].navigationItem.titleView = bgView;
    
}

#pragma mark uitextfield Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    
    if (textField.text != nil && textField.text.length > 0)
    {
        self.searchResultVC.view.hidden = NO;
        // 放在最上层
        [self.view bringSubviewToFront:self.searchResultVC.view];
        
        self.searchResultVC.searchArr = [NSMutableArray array];//这里可以说是清空tableview旧datasouce
        for (NSString *str in _cityArray)
        {
            if ([str rangeOfString:textField.text options:NSCaseInsensitiveSearch].length > 0)
            {
                [self.searchResultVC.searchArr addObject:str];
            }
        }
        [self.searchResultVC.tableView reloadData];
    }else
    {
        self.searchBgView.hidden = NO;
        [self.view bringSubviewToFront:_searchBgView];
    }
}

// 搜索按钮
- (void)searchButtonClick:(UIButton *)sender {
    DLog(@"搜索");
}

// textfield改变
- (void)textfieldDidChange {

    if (_searchTextField.text != nil && _searchTextField.text.length > 0)
    {
        self.searchBgView.hidden = YES;
        self.searchResultVC.view.hidden = NO;
        // 放在最上层
        [self.view bringSubviewToFront:self.searchResultVC.view];
        
        self.searchResultVC.searchArr = [NSMutableArray array];//这里可以说是清空tableview旧datasouce
        for (NSString *str in _cityArray)
        {
            if ([str rangeOfString:_searchTextField.text options:NSCaseInsensitiveSearch].length > 0)
            {
                [self.searchResultVC.searchArr addObject:str];
            }
        }
        [self.searchResultVC.tableView reloadData];
    }else
    {
        self.searchResultVC.view.hidden = YES;                                                                                                                                                                                  
        self.searchBgView.hidden = NO;
        [self.view bringSubviewToFront:_searchBgView];
    }
}

/** 键盘显示完成（弹出） */
- (void)keyboardDidShow:(NSNotification *)noti
{
    // 取出键盘高度
    NSDictionary *info = noti.userInfo;
    self.keyboardHeight = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
}

- (UIView *)searchBgView {
    if (!_searchBgView) {
        UIView *searchBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
        searchBgView.backgroundColor = [UIColor blackColor];
        searchBgView.alpha = 0.5;
        searchBgView.hidden = YES;
        [self.view addSubview:searchBgView];
        _searchBgView = searchBgView;
    }
    
    return _searchBgView;
}

- (SearchResultTableViewController *)searchResultVC {
    if (!_searchResultVC) {
        SearchResultTableViewController *searchResultVC = [[SearchResultTableViewController alloc] initWithStyle:UITableViewStylePlain];
        searchResultVC.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
        searchResultVC.tableView.contentInset = UIEdgeInsetsMake(0, 0, self.keyboardHeight, 0);
        searchResultVC.view.backgroundColor = [UIColor blackColor];
        searchResultVC.view.alpha = 0.5;
        searchResultVC.view.hidden = YES;
        searchResultVC.delegate = self;
        [self.view addSubview:searchResultVC.view];
        [self addChildViewController:searchResultVC];
        
        _searchResultVC = searchResultVC;
    }
    
    
    return _searchResultVC;
}

#pragma mark SearchResultTableViewControllerDelegate
- (void)didSelectRow:(NSInteger)row {
    _searchTextField.text = _searchResultVC.searchArr[row];
}

#pragma mark - message
- (void)messageBar
{
    _barImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"destination_message"] ];
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
        _barImage.image = [UIImage imageNamed:@"destination_message"];
        [self.navigationController pushViewController:mess animated:YES];
    }
}

-(void)cancelFlash{
    [_flashMessageBtnTimer invalidate];
    _barImage.image = [UIImage imageNamed:@"destination_message"];
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

    self.searchResultVC.view.hidden = YES;
    self.searchBgView.hidden = YES;
    [_searchTextField resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
