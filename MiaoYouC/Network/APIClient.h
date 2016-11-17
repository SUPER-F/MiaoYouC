//
//  APIClient.h
//  MakeLiving
//
//  Created by Kiet Thai Thuan on 11/9/14.
//  Copyright (c) 2014 ProSoft Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "APIRequest.h"
#import "APIResponseKit.h"
#import "Reachability.h"
#import "DTO.h"

typedef enum {
    AppConnectStateNone,
    AppConnectStateAvailable,
    AppConnectStateUnavailable
} AppConnectState;

@interface APIClient : NSObject

@property (nonatomic, retain) NSString *sessionInfo;
@property (nonatomic, assign) BOOL isLogOn;
@property (assign, nonatomic) BOOL isForceLogout;
@property (nonatomic, assign) AppConnectState connectionState;
@property (nonatomic, retain) NSString *lastUpdateStatus;
@property (nonatomic, retain) NSDate *lastUpdateTime;
@property (nonatomic, retain) NSString *sessionId;

+ (APIClient *)sharedInstance;
+ (NSString *) resolveRetCode: (NSString *) retCode;

- (BOOL) performLogOnIfRequired;
- (BOOL) performLogOn;
- (void) resetLogOnInfo;
- (NSString *)getCurrentCustomerId;
- (NSString *)getCurrentAccountId;

- (NSString*) getBaseUrl;
- (RKObjectManager *) getRKManager;
- (BOOL) isNetworkReachable;
- (id) setupConnector;

- (void)fireErrorBlock:(RKRequestDidFailLoadWithErrorBlock)failBlock onErrorInResponse:(RKResponse *)response;

- (NSDate*)getLastDateTimeRequest;

- (void)loadObjecsAtResourcePath:(NSString*)path withData:(APIRequest*)paras mappingClass:(Class)responseClass onSuccess: (RKObjectLoaderDidLoadObjectsBlock)loadBlock onError:(RKRequestDidFailLoadWithErrorBlock)failBlock;
- (void)uploadImage:(UIImage*)image hasKey:(NSString*)key toResourcePath:(NSString*)path withData:(APIRequest*)paras mappingClass:(Class)responseClass onSuccess: (RKObjectLoaderDidLoadObjectsBlock)loadBlock onError:(RKRequestDidFailLoadWithErrorBlock)failBlock;

- (NSString*)getCurrentUpdateStatus;
- (RKRequestSerialization*)getRequestDictionary:(NSDictionary*)dict;

@end
