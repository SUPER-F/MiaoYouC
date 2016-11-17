//
//  HaveSeenTableViewCell.m
//  MiaoYouC
//
//  Created by drupem on 16/11/15.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import "HaveSeenTableViewCell.h"

@implementation HaveSeenTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imageView1.layer.cornerRadius = kScreenW/8/2;
    self.imageView1.clipsToBounds = YES;
    self.imageView2.layer.cornerRadius = kScreenW/8/2;
    self.imageView2.clipsToBounds = YES;
    self.imageView3.layer.cornerRadius = kScreenW/8/2;
    self.imageView3.clipsToBounds = YES;
    self.imageView4.layer.cornerRadius = kScreenW/8/2;
    self.imageView4.clipsToBounds = YES;
    self.imageView5.layer.cornerRadius = kScreenW/8/2;
    self.imageView5.clipsToBounds = YES;
    self.imageView6.layer.cornerRadius = kScreenW/8/2;
    self.imageView6.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
