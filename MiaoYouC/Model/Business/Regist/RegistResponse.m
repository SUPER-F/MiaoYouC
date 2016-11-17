//
//  RegistResponse.m
//  Miaoyou
//
//  Created by Kiet Thai Thuan on 7/20/16.
//  Copyright (c) 2016 PROSOFT SG. All rights reserved.
//

#import "RegistResponse.h"

@implementation RegistResponse

+ (RKObjectMapping *) getMapping
{
    RKObjectMapping *mapping = [super getMapping];
    [mapping mapKeyPath:@"data.ID" toAttribute:@"ID"];
    [mapping mapKeyPath:@"data.NickName" toAttribute:@"NickName"];
    [mapping mapKeyPath:@"data.Sex" toAttribute:@"Sex"];
    [mapping mapKeyPath:@"data.AreaID" toAttribute:@"AreaID"];
    [mapping mapKeyPath:@"data.Birthday" toAttribute:@"Birthday"];
    [mapping mapKeyPath:@"data.Mobile" toAttribute:@"Mobile"];
    return mapping;
}

@end
