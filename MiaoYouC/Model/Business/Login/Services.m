//
//  Services.m
//  Miaoyou
//
//  Created by Kiet Thai Thuan on 16/07/20
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "Services.h"

@implementation Services

+ (RKObjectMapping *) getMapping {
    RKObjectMapping *mapping = [super getMapping:[BusinessLabel class] exceptionProperties:@[@"description",@"des"]];
    [mapping mapKeyPath:@"description" toAttribute:@"des"];
    return mapping;
}

@end
