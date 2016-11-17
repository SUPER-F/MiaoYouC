//
//  LoginResponse.h
//  Miaoyou
//
//  Created by Kiet Thai Thuan on 7/20/16.
//  Copyright (c) 2016 PROSOFT SG. All rights reserved.
//

#import "APIResponseKit.h"
#import "UserInfo.h"

@interface LoginResponse : APIResponseKit

@property (nonatomic, strong) UserInfo *data;

@end
