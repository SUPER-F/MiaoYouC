//
//  MyHeaderTableViewCell.h
//  MiaoYouC
//
//  Created by drupem on 16/11/15.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyHeaderTableViewCell;

@protocol MyHeaderTableViewCellDelegate <NSObject>

- (void)myHeaderTableViewCell:(MyHeaderTableViewCell *)cell headerBackgroundImgViewSender:(id)sender;
- (void)myHeaderTableViewCell:(MyHeaderTableViewCell *)cell headerImgViewSender:(id)sender;
- (void)myHeaderTableViewCell:(MyHeaderTableViewCell *)cell messageSender:(id)sender;
- (void)myHeaderTableViewCell:(MyHeaderTableViewCell *)cell editingInformationSender:(id)sender;
- (void)myHeaderTableViewCell:(MyHeaderTableViewCell *)cell memberSender:(id)sender;

@end

@interface MyHeaderTableViewCell : UITableViewCell

@property (nonatomic, weak) id <MyHeaderTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *my_header_bg_imgView;
@property (weak, nonatomic) IBOutlet UIImageView *my_header_imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UIButton *memberBtn;
@property (weak, nonatomic) IBOutlet UIButton *editingBtn;

@end
