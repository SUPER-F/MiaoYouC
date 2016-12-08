//
//  SearchResultTableViewController.h
//  MiaoYouC
//
//  Created by drupem on 16/12/1.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchResultTableViewControllerDelegate <NSObject>

- (void)didSelectRow:(NSInteger)row;

@end

@interface SearchResultTableViewController : UITableViewController

@property (nonatomic, weak) id <SearchResultTableViewControllerDelegate> delegate;

@property (nonatomic ,strong)NSMutableArray *searchArr;
@property (nonatomic, copy) NSString *selectedCity;

@end
