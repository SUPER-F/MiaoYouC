//
//  GetMemberInfoResponse.m
//  Miaoyou
//
//  Created by Kiet Thai Thuan on 7/20/16.
//  Copyright (c) 2016 PROSOFT SG. All rights reserved.
//

#import "GetMemberInfoResponse.h"

@implementation GetMemberInfoResponse

+ (RKObjectMapping *) getMapping
{
    RKObjectMapping *mapping = [super getMapping];
    [mapping mapKeyPath:@"data.names" toAttribute:@"names"];
    return mapping;
}

@end
