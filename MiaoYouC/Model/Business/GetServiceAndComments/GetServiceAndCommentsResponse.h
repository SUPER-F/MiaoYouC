//
//  GetServiceAndCommentsResponse.h
//  Miaoyou
//
//  Created by Kiet Thai Thuan on 7/21/16.
//  Copyright (c) 2016 PROSOFT SG. All rights reserved.
//

#import "APIResponseKit.h"

@interface GetServiceAndCommentsResponse : APIResponseKit

@property (nonatomic, strong) NSString *comments;
@property (nonatomic, strong) NSString *servicecount;

@end
