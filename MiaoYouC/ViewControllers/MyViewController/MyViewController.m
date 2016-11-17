//
//  MyViewController.m
//  MiaoYouC
//
//  Created by drupem on 16/11/4.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import "MyViewController.h"
#import "MyHeaderTableViewCell.h"
#import "HaveSeenTableViewCell.h"

static NSString *const myHeaderTableCellIdentifier = @"myHeaderTableCellIdentifier";
static NSString *const haveSeenTableCellIdentifier = @"HaveSeenTableViewCell";

@interface MyViewController () <UITableViewDelegate, UITableViewDataSource, MyHeaderTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray     *cellImages;
@property (nonatomic, strong) NSArray     *cellTitles;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
    
    [self createTableView];
    
    self.cellImages = @[@[@"my_allOrder", @"my_wallet", @"my_cardVoucher"], @[@"my_collection", @"my_recommendFriends", @"my_useGuide"], @[@"my_controlCenter", @"my_feedback", @"my_systemSettings"]];
    self.cellTitles = @[@[@"my_allOrder", @"my_wallet", @"my_cardVoucher"], @[@"my_collection", @"my_recommendFriends", @"my_useGuide"], @[@"my_controlCenter", @"my_feedback", @"my_systemSettings"]];
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - kScreenW/6 + 16) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MyHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:myHeaderTableCellIdentifier];
    [_tableView registerNib:[UINib nibWithNibName:@"HaveSeenTableViewCell" bundle:nil] forCellReuseIdentifier:haveSeenTableCellIdentifier];
}

#pragma mark - tableView dataSource and delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    else {
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return 16.0;
    }
    else {
        return 10.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return kScreenW/2 + 66;
        }
        else {
            return kScreenW/8 + 50;
        }
    }
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MyHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myHeaderTableCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            return cell;
        }
        else {
            HaveSeenTableViewCell *haveSeenCell = [tableView dequeueReusableCellWithIdentifier:haveSeenTableCellIdentifier forIndexPath:indexPath];
            return haveSeenCell;
        }
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.imageView.image = [UIImage imageNamed:_cellImages[indexPath.section - 1][indexPath.row]];
    cell.textLabel.text = NSLocalizedString(_cellTitles[indexPath.section - 1][indexPath.row], nil);
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - MyHeaderTableViewCellDelegate
- (void)myHeaderTableViewCell:(MyHeaderTableViewCell *)cell headerBackgroundImgViewSender:(id)sender {
    
}

- (void)myHeaderTableViewCell:(MyHeaderTableViewCell *)cell headerImgViewSender:(id)sender {
    
}

- (void)myHeaderTableViewCell:(MyHeaderTableViewCell *)cell messageSender:(id)sender {
    
}

- (void)myHeaderTableViewCell:(MyHeaderTableViewCell *)cell editingInformationSender:(id)sender {
    
}

- (void)myHeaderTableViewCell:(MyHeaderTableViewCell *)cell memberSender:(id)sender {
    
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
