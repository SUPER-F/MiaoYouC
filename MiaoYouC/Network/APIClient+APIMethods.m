//
//  APIClient+APIMethods.m
//  VolZone
//
//  Created by Kiet Thai Thuan on 6/4/16.
//  Copyright (c) 2016 Kiet Thai Thuan. All rights reserved.
//

#import "APIClient+APIMethods.h"

@implementation APIClient (APIMethods)

- (void)login:(NSString*)username password:(NSString*)password onSuccess: (RKObjectLoaderDidLoadObjectsBlock)loadBlock onError:(RKRequestDidFailLoadWithErrorBlock)failBlock {
    LoginRequest *params = [[LoginRequest alloc]init];
    params.Mobile = username;
    params.PassWord = password;
    if (appDataInstance.latitude && ![Utils isEmpty:appDataInstance.latitude]) {
        params.Latitude = appDataInstance.latitude;
    }
    else {
        params.Latitude = DEFAULT_LATITUDE;
    }
    if (appDataInstance.longitude && ![Utils isEmpty:appDataInstance.longitude]) {
        params.Longitude = appDataInstance.longitude;
    }
    else {
        params.Longitude = DEFAULT_LONGITUDE;
    }
    
    [self loadObjecsAtResourcePath:LOGIN_URL withData:params mappingClass:[LoginResponse class] onSuccess:loadBlock onError:failBlock];
}

- (void)registerVerCode:(NSString*)phoneNumber onSuccess: (RKObjectLoaderDidLoadObjectsBlock)loadBlock onError:(RKRequestDidFailLoadWithErrorBlock)failBlock {
    SendRegistCodeRequest *params = [[SendRegistCodeRequest alloc] init];
    params.Mobile = phoneNumber;
    [self loadObjecsAtResourcePath:GET_REGISTER_VER_CODE withData:params mappingClass:[SendRegistCodeResponse class] onSuccess:loadBlock onError:failBlock];
}

- (void)confirmRegistCode:(NSString*)phoneNumber andCode:(NSString*)code onSuccess: (RKObjectLoaderDidLoadObjectsBlock)loadBlock onError:(RKRequestDidFailLoadWithErrorBlock)failBlock {
    ConfirmRegistCodeRequest *params = [[ConfirmRegistCodeRequest alloc] init];
    params.Mobile = phoneNumber;
    params.VerificationCode = code;
    [self loadObjecsAtResourcePath:VER_REGISTER_CODE withData:params mappingClass:[ConfirmRegistCodeResponse class] onSuccess:loadBlock onError:failBlock];
}

- (void)lastRegister:(NSString*)nickname password:(NSString*)password code:(NSString*)code number:(NSString*)number onSuccess: (RKObjectLoaderDidLoadObjectsBlock)loadBlock onError:(RKRequestDidFailLoadWithErrorBlock)failBlock {
    RegistRequest *params = [[RegistRequest alloc] init];
    params.NickName = nickname;
    params.PassWord = password;
    params.Mobile = number;
    params.RecommendedCode = code;
    [self loadObjecsAtResourcePath:COMPLETE_REGISTER_URL withData:params mappingClass:[RegistResponse class] onSuccess:loadBlock onError:failBlock];
}

- (void)findPwdObtainCode:(NSString*)phoneNumber onSuccess: (RKObjectLoaderDidLoadObjectsBlock)loadBlock onError:(RKRequestDidFailLoadWithErrorBlock)failBlock {
    SendVerificationCodeRequest *params = [[SendVerificationCodeRequest alloc] init];
    params.Mobile = phoneNumber;
    [self loadObjecsAtResourcePath:FIND_PWD_URL withData:params mappingClass:[SendVerificationCodeResponse class] onSuccess:loadBlock onError:failBlock];
}

- (void)forgetPassword:(NSString*)mobile withCode:(NSString*)code andPassword:(NSString*)pwd onSuccess: (RKObjectLoaderDidLoadObjectsBlock)loadBlock onError:(RKRequestDidFailLoadWithErrorBlock)failBlock {
    ForgotPasswordRequest *params = [[ForgotPasswordRequest alloc] init];
    params.Mobile = mobile;
    params.VerificationCode = code;
    params.PassWord = pwd;
    [self loadObjecsAtResourcePath:FORGET_PWD_URL withData:params mappingClass:[ForgotPasswordResponse class] onSuccess:loadBlock onError:failBlock];
}

- (void)getServiceAndComments:(NSString*)userId onSuccess: (RKObjectLoaderDidLoadObjectsBlock)loadBlock onError:(RKRequestDidFailLoadWithErrorBlock)failBlock {
    GetServiceAndCommentsRequest *params = [[GetServiceAndCommentsRequest alloc] init];
    params.MemberId = userId;
    [self loadObjecsAtResourcePath:GET_USER_RATING withData:params mappingClass:[GetServiceAndCommentsResponse class] onSuccess:loadBlock onError:failBlock];
}

- (void)uploadImage:(UIImage*)image hasKey:(NSString*)key to:(NSString*)userId onSuccess: (RKObjectLoaderDidLoadObjectsBlock)loadBlock onError:(RKRequestDidFailLoadWithErrorBlock)failBlock {
    UploadPictureRequest *params = [[UploadPictureRequest alloc] init];
    params.ID = userId;
    //[self uploadImage:image hasKey:key toResourcePath:UPLOAD_PICTURE withData:params mappingClass:[UploadPictureResponse class] onSuccess:loadBlock onError:failBlock];
    [self uploadImage:image hasKey:key toResourcePath:UPLOAD_PICTURE withData:params mappingClass:[UploadPictureResponse class] onSuccess:loadBlock onError:failBlock];
}

- (void)uploadUserAvatarOrBackground:(UIImage*)image hasKey:(NSString*)key to:(NSString*)userId onSuccess: (RKObjectLoaderDidLoadObjectsBlock)loadBlock onError:(RKRequestDidFailLoadWithErrorBlock)failBlock {
    ModifyGuestInfoRequest *params = [[ModifyGuestInfoRequest alloc] init];
    params.ID = userId;
    
    [self uploadImage:image hasKey:key toResourcePath: MODIFY_USERINFO_MSG withData:params mappingClass:[ModifyGuestInfoResponse class] onSuccess:loadBlock onError:failBlock];
}

- (void)getMemberInfo:(NSString*)mobile onSuccess: (RKObjectLoaderDidLoadObjectsBlock)loadBlock onError:(RKRequestDidFailLoadWithErrorBlock)failBlock {
    GetMemberInfoRequest *params = [[GetMemberInfoRequest alloc] init];
    params.Mobile = mobile;
    [self loadObjecsAtResourcePath:CUSTOMER_INFO_URL withData:params mappingClass:[GetMemberInfoResponse class] onSuccess:loadBlock onError:failBlock];
}

@end
