//
//  LoginRequest.h
//  Miaoyou
//
//  Created by Kiet Thai Thuan on 7/20/16.
//  Copyright (c) 2016 PROSOFT SG. All rights reserved.
//

#import "APIRequest.h"

@interface LoginRequest : APIRequest

@property (nonatomic, strong) NSString *Mobile;
@property (nonatomic, strong) NSString *PassWord;
@property (nonatomic, strong) NSString *Latitude;
@property (nonatomic, strong) NSString *Longitude;

@end
