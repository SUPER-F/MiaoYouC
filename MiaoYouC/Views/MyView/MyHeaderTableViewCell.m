//
//  MyHeaderTableViewCell.m
//  MiaoYouC
//
//  Created by drupem on 16/11/15.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import "MyHeaderTableViewCell.h"

@implementation MyHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.my_header_imgView.layer.cornerRadius = 40.0;
    self.my_header_imgView.clipsToBounds = YES;
    self.my_header_imgView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.my_header_imgView.layer.borderWidth = 1;
    
    NSMutableAttributedString *editingBtnstr = [[NSMutableAttributedString alloc] initWithString:_editingBtn.titleLabel.text];
    NSRange editingBtnstrRange = {0,[editingBtnstr length]};
    [editingBtnstr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:editingBtnstrRange];
    [self.editingBtn setAttributedTitle:editingBtnstr forState:UIControlStateNormal];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_memberBtn.titleLabel.text];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [self.memberBtn setAttributedTitle:str forState:UIControlStateNormal];
}

- (IBAction)headerBgButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(myHeaderTableViewCell:headerBackgroundImgViewSender:)]) {
        [self.delegate myHeaderTableViewCell:self headerBackgroundImgViewSender:sender];
    }
}

- (IBAction)headerButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(myHeaderTableViewCell:headerImgViewSender:)]) {
        [self.delegate myHeaderTableViewCell:self headerImgViewSender:sender];
    }
}

- (IBAction)messageButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(myHeaderTableViewCell:messageSender:)]) {
        [self.delegate myHeaderTableViewCell:self messageSender:sender];
    }
}

- (IBAction)editingInformationButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(myHeaderTableViewCell:editingInformationSender:)]) {
        [self.delegate myHeaderTableViewCell:self editingInformationSender:sender];
    }
}

- (IBAction)memberButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(myHeaderTableViewCell:memberSender:)]) {
        [self.delegate myHeaderTableViewCell:self memberSender:sender];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
