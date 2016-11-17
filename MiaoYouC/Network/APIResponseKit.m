//
//  APIResponse.m
//  MakeLiving
//
//  Created by Kiet Thai Thuan on 11/9/14.
//  Copyright (c) 2014 ProSoft Co., Ltd. All rights reserved.
//

#import "APIResponseKit.h"
#import "DTO.h"

@implementation APIResponseKit

@synthesize status;
@synthesize message;

- (NSString *)description
{
    return [Utils autoDescribe:self];
}

- (BOOL) hasError
{
    BOOL tmpHasErr = status!=REQUEST_OK;  // SUCCESS
    return tmpHasErr;
}

- (BOOL) isSuccess {
    return status==REQUEST_OK;
}

- (NSString *) getErrorString
{
    if (status != REQUEST_OK) {
        return NSLocalizedString(@"response_has_errors", nil);
    }
    return @"unknow";
}

- (BOOL) hasForceLogoutRetCode {
    return FALSE;
}

+ (RKObjectMapping *) getMapping
{
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[self class] ];
    [mapping mapAttributes:@"status",@"message", nil];
    return mapping;
}

+ (RKObjectMapping *)registerAllMappings: (RKObjectMappingProvider *)mappingProvider
{
    // Register DTO...
    [mappingProvider addObjectMapping:[UserInfo getMapping]];
    [mappingProvider addObjectMapping:[BusinessLabel getMapping]];
    [mappingProvider addObjectMapping:[CarInfo getMapping]];
    [mappingProvider addObjectMapping:[MorePicture getMapping]];
    [mappingProvider addObjectMapping:[Services getMapping]];
    [mappingProvider addObjectMapping:[TouristsPhoto getMapping]];
    [mappingProvider addObjectMapping:[MyLable getMapping]];
//    // Register Result (if available)...
    // Register Response
    [mappingProvider addObjectMapping:[LoginResponse getMapping]];
    [mappingProvider addObjectMapping:[SendRegistCodeResponse getMapping]];
    [mappingProvider addObjectMapping:[ConfirmRegistCodeResponse getMapping]];
    [mappingProvider addObjectMapping:[RegistResponse getMapping]];
    [mappingProvider addObjectMapping:[SendVerificationCodeResponse getMapping]];
    [mappingProvider addObjectMapping:[ForgotPasswordResponse getMapping]];
    [mappingProvider addObjectMapping:[GetGuestInfoResponse getMapping]];
    [mappingProvider addObjectMapping:[ModifyGuestInfoResponse getMapping]];
    [mappingProvider addObjectMapping:[GetMemberInfoResponse getMapping]];
    [mappingProvider addObjectMapping:[UploadPictureResponse getMapping]];
    [mappingProvider addObjectMapping:[GetServiceAndCommentsResponse getMapping]];
    [mappingProvider addObjectMapping:[ModifyGuestInfoResponse getMapping]];
    
    
    return nil;
}

@end
