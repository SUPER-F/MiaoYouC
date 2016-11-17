//
//  ConfirmRegistCodeRequest.h
//  Miaoyou
//
//  Created by Kiet Thai Thuan on 7/20/16.
//  Copyright (c) 2016 PROSOFT SG. All rights reserved.
//

#import "APIRequest.h"

@interface ConfirmRegistCodeRequest : APIRequest

@property (nonatomic, strong) NSString *Mobile;
@property (nonatomic, strong) NSString *VerificationCode;

@end
