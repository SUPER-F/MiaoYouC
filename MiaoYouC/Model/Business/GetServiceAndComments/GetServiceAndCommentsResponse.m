//
//  GetServiceAndCommentsResponse.m
//  Miaoyou
//
//  Created by Kiet Thai Thuan on 7/21/16.
//  Copyright (c) 2016 PROSOFT SG. All rights reserved.
//

#import "GetServiceAndCommentsResponse.h"

@implementation GetServiceAndCommentsResponse

+ (RKObjectMapping *) getMapping
{
    RKObjectMapping *mapping = [super getMapping];
    [mapping mapKeyPath:@"data.servicecount" toAttribute:@"servicecount"];
    [mapping mapKeyPath:@"data.comments" toAttribute:@"comments"];
    return mapping;
}
@end
