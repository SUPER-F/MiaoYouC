//
//  Destination_guideAndButlerCell.m
//  MiaoYouC
//
//  Created by drupem on 16/12/1.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import "Destination_guideAndButlerCell.h"

@interface Destination_guideAndButlerCell ()

@property (nonatomic, strong) UIButton *imgButton;
@property (nonatomic, strong) UILabel  *lineLabel;

@end

@implementation Destination_guideAndButlerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bounds = CGRectMake(0, 0, kScreenW, kScreenW / 1.5);
        [self initView];
    }
    return self;
}

- (void)initView {

    UIButton *imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    imgBtn.frame = CGRectMake(0, 0, kScreenW, kScreenW / 2.5);
    [imgBtn setBackgroundImage:[UIImage imageNamed:@"header_bg"] forState:UIControlStateNormal];
    [self addSubview:imgBtn];
    _imgButton = imgBtn;
}

#pragma mark - setter
- (void)setTitleString:(NSString *)titleString {
    _titleString = titleString;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:26]};
    CGSize textSize = [titleString boundingRectWithSize:CGSizeMake(kScreenW, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenW - textSize.width) / 2, CGRectGetHeight(_imgButton.bounds) / 2, textSize.width, 1)];
    lineLabel.backgroundColor = [UIColor whiteColor];
    [_imgButton addSubview:lineLabel];
    _lineLabel = lineLabel;
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = titleString;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:26];
    [_imgButton addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.left.equalTo(lineLabel.mas_left);
        make.right.equalTo(lineLabel.mas_right);
        make.bottom.equalTo(lineLabel.mas_top).offset(-5);
    }];
}

- (void)setSubTitleString:(NSString *)subTitleString {
    _subTitleString = subTitleString;
    
    UILabel *subTitleLabel = [UILabel new];
    subTitleLabel.text = subTitleString;
    subTitleLabel.textColor = [UIColor whiteColor];
    subTitleLabel.font = [UIFont systemFontOfSize:14];
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    [_imgButton addSubview:subTitleLabel];
    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.left.equalTo(_lineLabel.mas_left);
        make.right.equalTo(_lineLabel.mas_right);
        make.top.equalTo(_lineLabel.mas_bottom).offset(5);
    }];
}

- (void)setGuidesAndButlers:(NSMutableArray *)guidesAndButlers {
    UIButton *lastBtn = nil;
    __weak typeof(self) weakSelf = self;
    for (NSInteger index = 0; index < (guidesAndButlers.count>7 ? 6 : guidesAndButlers.count); index++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:guidesAndButlers[index]] forState:UIControlStateNormal];
        [self addSubview:btn];
//        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(btn.mas_width);
//            make.top.equalTo(_imgButton.mas_bottom).offset(10.0f);
//            
//            if (index % (guidesAndButlers.count>7 ? 6 : guidesAndButlers.count) == 0) {
//                make.left.mas_equalTo(20);
//            }
//            else {
//                make.width.equalTo(lastBtn.mas_width);
//                make.left.equalTo(lastBtn.mas_right).offset(10.0f);
//            }
//            
//            if (index % (guidesAndButlers.count>7 ? 6 : guidesAndButlers.count) == (guidesAndButlers.count>7 ? 6 : guidesAndButlers.count)-1) {
//                make.right.equalTo(weakSelf.mas_right).offset(-20.0f);
//            }
//        }];
        if (index == 0) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf).offset(20);
                //make.height.equalTo(@(height));
                make.centerY.equalTo(weakSelf);
                make.height.equalTo(btn.mas_width);
            }];
            
        } else if (index == guidesAndButlers.count -1) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastBtn.mas_right).offset(10);
                make.right.equalTo(weakSelf.mas_right).offset(-20);
                make.height.equalTo(lastBtn);
                make.width.equalTo(lastBtn);
                make.centerY.equalTo(lastBtn);
            }];
            
        } else {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastBtn.mas_right).offset(10);
                make.centerY.equalTo(lastBtn);
                //make.height.equalTo(tempView);
                make.width.equalTo(lastBtn);
                make.height.equalTo(lastBtn.mas_width);
                
            }];
            
        }
        lastBtn = btn;
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
