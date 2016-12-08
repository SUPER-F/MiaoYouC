//
//  Destination_buttonCell.m
//  MiaoYouC
//
//  Created by drupem on 16/11/30.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import "Destination_buttonCell.h"

@implementation Destination_buttonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bounds = CGRectMake(0, 0, kScreenW, kScreenW / 2);
        [self initView];
    }
    return self;
}

- (void)initView {
    NSArray *images = @[@[@"destination_ticket", @"destination_cate", @"destination_stay"], @[@"destination_recreation", @"destination_shopping", @"destination_route"]];
    NSArray *titles = @[@[@"美景/门票", @"人气美食", @"好评住宿"], @[@"娱乐休闲", @"特产购物", @"周边线路"]];
    NSArray *tags = @[@[@1000, @1001, @1002], @[@1003, @1004, @1005]];
    // 用for循环创建六个按钮
    for (NSInteger i = 0; i < 2; i++) {
        for (NSInteger index = 0; index < 3; index++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(kScreenW / 3 * index, kScreenW / 4 * i, kScreenW / 3, kScreenW / 4);
            [button setTitle:titles[i][index] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:images[i][index]] forState:UIControlStateNormal];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(kScreenW / 4 - 20, -kScreenW/8, 10, 0)];
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, [UIImage imageNamed:images[i][index]].size.width/2, 20, 0)];
            button.tag = [tags[i][index] integerValue];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
            if (index == 1 || index == 2) {
                UILabel *lineLabel = [[UILabel alloc] init];
                lineLabel.frame = CGRectMake(kScreenW / 3 * index, kScreenW / 4 * i + 10, 0.5, kScreenW / 4 - 20);
                lineLabel.backgroundColor = [UIColor lightGrayColor];
                [self addSubview:lineLabel];
            }
        }
    }
}

- (void)buttonClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(destinationButtonCell:selectedButton:)]) {
        [self.delegate destinationButtonCell:self selectedButton:sender];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
