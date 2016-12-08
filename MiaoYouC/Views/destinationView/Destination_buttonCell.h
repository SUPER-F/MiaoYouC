//
//  Destination_buttonCell.h
//  MiaoYouC
//
//  Created by drupem on 16/11/30.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Destination_buttonCell;

@protocol DestinationButtonCellDelegate <NSObject>

- (void)destinationButtonCell:(Destination_buttonCell *)cell selectedButton:(UIButton *)sender;

@end

@interface Destination_buttonCell : UITableViewCell

@property (nonatomic, weak) id <DestinationButtonCellDelegate> delegate;

@end
