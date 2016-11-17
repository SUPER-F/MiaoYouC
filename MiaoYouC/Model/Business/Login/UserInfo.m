//
//  LoginInfo.m
//  Miaoyou
//
//  Created by Kiet Thai Thuan on 16/07/20
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "UserInfo.h"
#import "TouristsPhoto.h"
#import "Services.h"
#import "BusinessLabel.h"
#import "CarInfo.h"
#import "MorePicture.h"
#import "MyLable.h"

@implementation UserInfo

+ (RKObjectMapping *) getMapping {
    RKObjectMapping *mapping = [super getMapping:[UserInfo class] exceptionProperties:@[@"TouristsPhoto",@"Services", @"BusinessLabel",@"CarInfo",@"morepicture",@"MyLable"]];
    [mapping mapKeyPath:@"BusinessLabel" toRelationship:@"BusinessLabel" withMapping:[BusinessLabel getMapping]];
    [mapping mapKeyPath:@"MyLable" toRelationship:@"MyLable" withMapping:[MyLable getMapping]];
    [mapping mapKeyPath:@"morepicture" toRelationship:@"morepicture" withMapping:[MorePicture getMapping]];
    [mapping mapKeyPath:@"TouristsPhoto" toRelationship:@"TouristsPhoto" withMapping:[TouristsPhoto getMapping]];
    [mapping mapKeyPath:@"Services" toRelationship:@"Services" withMapping:[Services getMapping]];
    [mapping mapKeyPath:@"CarInfo" toRelationship:@"CarInfo" withMapping:[CarInfo getMapping]];
    return mapping;
}


+ (NSDictionary *)objectClassInArray{
    return @{@"TouristsPhoto" : [TouristsPhoto class], @"Services" : [Services class], @"BusinessLabel" : [BusinessLabel class], @"CarInfo" : [CarInfo class], @"morepicture" : [MorePicture class]};
}

@end
