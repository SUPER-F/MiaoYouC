//
//  UploadPictureResponse.m
//  Miaoyou
//
//  Created by Kiet Thai Thuan on 7/20/16.
//  Copyright (c) 2016 PROSOFT SG. All rights reserved.
//

#import "UploadPictureResponse.h"

@implementation UploadPictureResponse

+ (RKObjectMapping *) getMapping
{
    RKObjectMapping *mapping = [super getMapping];
    [mapping mapKeyPath:@"data.img" toAttribute:@"img"];
    [mapping mapKeyPath:@"data.img_thum" toAttribute:@"img_thum"];
    return mapping;
}

@end
