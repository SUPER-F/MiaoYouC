//
//  APIRequest.h
//  MakeLiving
//
//  Created by Kiet Thai Thuan on 11/9/14.
//  Copyright (c) 2014 ProSoft Co., Ltd. All rights reserved.
//

#import "Jastor.h"

@interface APIRequest : Jastor

/* delegate use to save the request owner */
@property (nonatomic, retain) id delegate;

@property (nonatomic, strong) NSString *platform;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *key;

@end
