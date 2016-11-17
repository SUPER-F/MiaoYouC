//
//  DestinationViewController.m
//  MiaoYouC
//
//  Created by drupem on 16/11/4.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import "DestinationViewController.h"

@interface DestinationViewController ()

@end

@implementation DestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *mobileInfo = [appDataInstance getMobileInfo];
    if ([mobileInfo isEqualToString:@""]) {
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
