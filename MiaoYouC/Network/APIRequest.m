//
//  APIRequest.m
//  MakeLiving
//
//  Created by Kiet Thai Thuan on 11/9/14.
//  Copyright (c) 2014 ProSoft Co., Ltd. All rights reserved.
//

#import "APIRequest.h"

@implementation APIRequest

- (instancetype)init {
    self = [super init];
    if (self) {
//        _platform = @"android";
        _platform = @"ios";
        _version = @"1.0";
        _key = API_KEY;
    }
    return  self;
}

@end
