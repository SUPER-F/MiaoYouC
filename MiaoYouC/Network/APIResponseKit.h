//
//  APIResponse.h
//  MakeLiving
//
//  Created by Kiet Thai Thuan on 11/9/14.
//  Copyright (c) 2014 ProSoft Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIResponseKit : NSObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *message;


- (BOOL) hasError;
- (BOOL) hasForceLogoutRetCode;

- (NSString *) getErrorString;
- (BOOL) isSuccess;

+ (RKObjectMapping *) getMapping;
+ (RKObjectMapping *) registerAllMappings:(RKObjectMappingProvider *)mappingProvider;

@end
