//
//  AppDelegate+RootController.m
//  MiaoYouC
//
//  Created by drupem on 16/11/4.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import "AppDelegate+RootController.h"
#import "RDVTabBarItem.h"

@interface AppDelegate () <RDVTabBarControllerDelegate,UIScrollViewDelegate,UITabBarControllerDelegate>

@end

@implementation AppDelegate (RootController)

- (void)setRootViewController
{
    if ([SZUserDefault objectForKey:@"isOne"])
    {//不是第一次安装
//        [self checkBlack];
        [self setRoot];
//        self.window.rootViewController = self.viewController;
    }
    else
    {
        UIViewController *emptyView = [[ UIViewController alloc ]init ];
        self. window .rootViewController = emptyView;
        [self createLoadingScrollView];
    }
}
    
- (void)setRoot {
    
    UINavigationController * navc = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    navc.navigationBar.barTintColor = [UIColor whiteColor];
    
    navc.navigationBar.shadowImage = [[UIImage alloc] init];
    [navc.navigationBar setTranslucent:YES];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [navc.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor blackColor]}];
    navc.navigationBar.tintColor = [UIColor blackColor];
    self.window.rootViewController = navc;
}
    
- (void)setTabbarController {
//    LoginViewController *destinationVC = [[LoginViewController alloc]init];
    DestinationViewController *destinationVC = [[DestinationViewController alloc]init];
    TakeMePlayViewController *takeMePlayVC  = [[TakeMePlayViewController alloc]init];
    DiscoverViewController *discoverVC = [[DiscoverViewController alloc]init];
    FindButlerViewController *findButlerVC = [[FindButlerViewController alloc]init];
    MyViewController *myVC = [[MyViewController alloc]init];
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[destinationVC,takeMePlayVC,discoverVC,findButlerVC,myVC]];
    self.viewController = tabBarController;
    tabBarController.delegate = self;
    
    RDVTabBar *tabBar = tabBarController.tabBar;
    tabBar.translucent = YES;
    tabBar.backgroundView.backgroundColor = [UIColor clearColor];
    [tabBar setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width/6)];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width/6)];
    imgView.image = [UIImage imageNamed:@"tab_destination"];
    [tabBar.backgroundView addSubview:imgView];
    
    [self tabBarController:tabBarController didSelectViewController:destinationVC];
    
//    [self customizeTabBarForController:tabBarController];
}

// tabBarController Delegate
- (void)tabBarController:(RDVTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    UIImageView *imgView = [tabBarController.tabBar.backgroundView.subviews objectAtIndex:0];
    
    if ([viewController isKindOfClass:[DestinationViewController class]])
    {
//        tabBarController.navigationItem.title = @"";
        imgView.image = [UIImage imageNamed:@"table_destination"];
    }
    if ([viewController isKindOfClass:[TakeMePlayViewController class]])
    {
        tabBarController.navigationItem.title = @"本地向导";
        imgView.image = [UIImage imageNamed:@"table_takeMePlay"];
    }
    if ([viewController isKindOfClass:[DiscoverViewController class]])
    {
        tabBarController.navigationItem.title = @"发现";
        imgView.image = [UIImage imageNamed:@"table_discover"];
    }
    if ([viewController isKindOfClass:[FindButlerViewController class]])
    {
        tabBarController.navigationItem.title = @"找管家";
        imgView.image = [UIImage imageNamed:@"table_findButler"];
    }
    if ([viewController isKindOfClass:[MyViewController class]])
    {
        tabBarController.navigationItem.title = @"我的";
        imgView.image = [UIImage imageNamed:@"table_my"];
    }
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    RDVTabBar *tabBar = tabBarController.tabBar;
    tabBar.translucent = YES;
    tabBar.backgroundView.backgroundColor = [UIColor clearColor];
    
    [tabBar setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64)];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64)];
    imgView.image = [UIImage imageNamed:@"Bitmap"];
    [tabBar.backgroundView addSubview:imgView];
    
    NSInteger index = 0;
    NSArray *tabBarItemImages = @[@"目的地", @"目的地", @"发现", @"目的地", @"目的地"];
    for (RDVTabBarItem *tabBarItem in [[tabBarController tabBar] items]) {
        if (index != 2) {
            tabBarItem.titlePositionAdjustment = UIOffsetMake(0, 10);
            tabBarItem.imagePositionAdjustment = UIOffsetMake(0, 8);
        } else {
            tabBarItem.titlePositionAdjustment = UIOffsetMake(0, 4);
        }
        UIImage *selectImg = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [tabBarItemImages objectAtIndex:index]]];
        [tabBarItem setFinishedSelectedImage:selectImg withFinishedUnselectedImage:selectImg];
        NSString *selectTitle = [NSString stringWithFormat:@"%@", [tabBarItemImages objectAtIndex:index]];
        
        NSDictionary *tabBarTitleUnselectedDic = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:11]};
        NSDictionary *tabBarTitleSelectedDic = @{NSForegroundColorAttributeName:[UIColor blueColor],NSFontAttributeName:[UIFont systemFontOfSize:11]};
        //修改tabberItem的title颜色
        tabBarItem.selectedTitleAttributes = tabBarTitleSelectedDic;
        tabBarItem.unselectedTitleAttributes = tabBarTitleUnselectedDic;
        tabBarItem.title = selectTitle;
        index ++;
    }
}
    
- (void)setAppWindows {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
//    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
}
    
    
- (void)createLoadingScrollView {
    //引导页
    UIScrollView *sc = [[UIScrollView alloc]initWithFrame:self.window.bounds];
    sc.pagingEnabled = YES;
    sc.delegate = self;
    sc.showsHorizontalScrollIndicator = NO;
    sc.showsVerticalScrollIndicator = NO;
    [self.window.rootViewController.view addSubview:sc];
    
    NSArray *arr = @[@"引导页1",@"引导页2",@"引导页3"];
    for (NSInteger i = 0; i < arr.count; i++) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenW*i, 0, kScreenW, self.window.frame.size.height)];
        img.image = [UIImage imageNamed:arr[i]];
        [sc addSubview:img];
        img.userInteractionEnabled = YES;
    }
    sc.contentSize = CGSizeMake(kScreenW*arr.count, self.window.frame.size.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x > kScreenW *2+30) {
        [self goToMain];
    }
}

- (void)goToMain {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:@"isOne" forKey:@"isOne"];
    [user synchronize];
    [self setRoot];
}


@end
