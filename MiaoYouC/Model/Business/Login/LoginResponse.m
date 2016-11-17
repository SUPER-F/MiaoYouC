//
//  LoginResponse.m
//  Miaoyou
//
//  Created by Kiet Thai Thuan on 7/20/16.
//  Copyright (c) 2016 PROSOFT SG. All rights reserved.
//

#import "LoginResponse.h"

@implementation LoginResponse

+ (RKObjectMapping *) getMapping
{
    RKObjectMapping *mapping = [super getMapping];
    [mapping mapKeyPath:@"data" toRelationship:@"data" withMapping:[UserInfo getMapping]];
    return mapping;
}

@end


