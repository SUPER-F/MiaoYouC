//
//  DestinationViewController.m
//  MiaoYouC
//
//  Created by drupem on 16/11/4.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import "DestinationViewController.h"
#import "Destination_shufflingCell.h"
#import "Destination_buttonCell.h"
#import "Destination_guideAndButlerCell.h"

static NSString *const shufflingCellIdentifier = @"Destination_shufflingCell";
static NSString *const buttonCellIdentifier    = @"Destination_buttonCell";
static NSString *const guideAndButlerCellIdentifier = @"Destination_guideAndButlerCell";

@interface DestinationViewController () <UITableViewDelegate, UITableViewDataSource, DestinationButtonCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *mobileInfo = [appDataInstance getMobileInfo];
    if ([mobileInfo isEqualToString:@""]) {
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:NO];
        return;
    }
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - kScreenW/6 + 16) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];

}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 || indexPath.section == 3) {
        return kScreenW / 1.5;
    }
    return kScreenW / 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return 16.0;
    }
    else {
        return 5.0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
            
            Destination_shufflingCell *shufflcell = [tableView dequeueReusableCellWithIdentifier:shufflingCellIdentifier];
            if (!shufflcell) {
                shufflcell = [[Destination_shufflingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shufflingCellIdentifier];
                NSArray *array = @[@"header_bg", @"header_bg", @"header_bg", @"header_bg", @"header_bg"];
                [shufflcell addImagesArray:array currentImageClick:^(NSInteger index) {
                    
                }];
            }
        
        
            return shufflcell;
    }
    else if (indexPath.section == 1) {
        Destination_buttonCell *buttonCell = [tableView dequeueReusableCellWithIdentifier:buttonCellIdentifier];
        if (!buttonCell) {
            buttonCell = [[Destination_buttonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:buttonCellIdentifier];
            buttonCell.delegate = self;
        }
        
        return buttonCell;
    }
    else {
        Destination_guideAndButlerCell *guideAndButlerCell = [tableView dequeueReusableCellWithIdentifier:guideAndButlerCellIdentifier];
        if (!guideAndButlerCell) {
            guideAndButlerCell = [[Destination_guideAndButlerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:guideAndButlerCellIdentifier];
        }
        
        if (indexPath.section == 2) {
            guideAndButlerCell.titleString = @"找个向导带我玩";
            guideAndButlerCell.subTitleString = @"徒步向导·带车向导·商务接待";
            guideAndButlerCell.guidesAndButlers = [NSMutableArray arrayWithObjects:@"header_bg", @"header_bg", @"header_bg", @"header_bg", @"header_bg",@"header_bg", nil];
        }
        else if (indexPath.section == 3) {
            guideAndButlerCell.titleString = @"有事就问管家";
            guideAndButlerCell.subTitleString = @"美食·娱乐·旅行顾问";
        }
        
        return guideAndButlerCell;
    }
}

#pragma mark DestinationButtonDelegate
- (void)destinationButtonCell:(Destination_buttonCell *)cell selectedButton:(UIButton *)sender {
    DLog(@"%ld", sender.tag);
    
   
}

#pragma mark - 搜索
- (void)searchButtonClick:(UIButton *)sender {
    
}

- (void)didSelectRow:(NSInteger)row {
    [super didSelectRow:row];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
