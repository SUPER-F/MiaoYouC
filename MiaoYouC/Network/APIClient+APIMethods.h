//
//  APIClient+APIMethods.h
//  VolZone
//
//  Created by Kiet Thai Thuan on 6/4/16.
//  Copyright (c) 2016 Kiet Thai Thuan. All rights reserved.
//

#import "APIClient.h"

@interface APIClient (APIMethods)

- (void)login:(NSString*)username password:(NSString*)password onSuccess: (RKObjectLoaderDidLoadObjectsBlock)loadBlock onError:(RKRequestDidFailLoadWithErrorBlock)failBlock;

- (void)registerVerCode:(NSString*)phoneNumber onSuccess: (RKObjectLoaderDidLoadObjectsBlock)loadBlock onError:(RKRequestDidFailLoadWithErrorBlock)failBlock;

- (void)confirmRegistCode:(NSString*)phoneNumber andCode:(NSString*)code onSuccess: (RKObjectLoaderDidLoadObjectsBlock)loadBlock onError:(RKRequestDidFailLoadWithErrorBlock)failBlock;

- (void)lastRegister:(NSString*)nickname password:(NSString*)password code:(NSString*)code number:(NSString*)number onSuccess: (RKObjectLoaderDidLoadObjectsBlock)loadBlock onError:(RKRequestDidFailLoadWithErrorBlock)failBlock;

- (void)findPwdObtainCode:(NSString*)phoneNumber onSuccess: (RKObjectLoaderDidLoadObjectsBlock)loadBlock onError:(RKRequestDidFailLoadWithErrorBlock)failBlock;

- (void)forgetPassword:(NSString*)mobile withCode:(NSString*)code andPassword:(NSString*)pwd onSuccess: (RKObjectLoaderDidLoadObjectsBlock)loadBlock onError:(RKRequestDidFailLoadWithErrorBlock)failBlock;

- (void)getServiceAndComments:(NSString*)userId onSuccess: (RKObjectLoaderDidLoadObjectsBlock)loadBlock onError:(RKRequestDidFailLoadWithErrorBlock)failBlock;

- (void)uploadImage:(UIImage*)image hasKey:(NSString*)key to:(NSString*)userId onSuccess: (RKObjectLoaderDidLoadObjectsBlock)loadBlock onError:(RKRequestDidFailLoadWithErrorBlock)failBlock;

- (void)uploadUserAvatarOrBackground:(UIImage*)image hasKey:(NSString*)key to:(NSString*)userId onSuccess: (RKObjectLoaderDidLoadObjectsBlock)loadBlock onError:(RKRequestDidFailLoadWithErrorBlock)failBlock;

- (void)getMemberInfo:(NSString*)mobile onSuccess: (RKObjectLoaderDidLoadObjectsBlock)loadBlock onError:(RKRequestDidFailLoadWithErrorBlock)failBlock;

@end
