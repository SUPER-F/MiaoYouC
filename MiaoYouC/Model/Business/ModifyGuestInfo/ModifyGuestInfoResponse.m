//
//  ModifyGuestInfoResponse.m
//  Miaoyou
//
//  Created by Kiet Thai Thuan on 7/21/16.
//  Copyright (c) 2016 PROSOFT SG. All rights reserved.
//

#import "ModifyGuestInfoResponse.h"

@implementation ModifyGuestInfoResponse

+ (RKObjectMapping *) getMapping
{
    RKObjectMapping *mapping = [super getMapping];
    [mapping mapKeyPath:@"data" toRelationship:@"data" withMapping:[UserInfo getMapping]];
    return mapping;
}

@end
