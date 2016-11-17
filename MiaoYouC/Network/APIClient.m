//
//  APIClient.m
//  MakeLiving
//
//  Created by Kiet Thai Thuan on 11/9/14.
//  Copyright (c) 2014 ProSoft Co., Ltd. All rights reserved.
//

#import "APIClient.h"

@implementation APIClient

@synthesize lastUpdateTime, lastUpdateStatus, isForceLogout, isLogOn,sessionId;

+ (APIClient *)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}

+ (NSString *) resolveRetCode: (NSString *) retCode
{
    return retCode;
}

- (id) init
{
    [self resetLogOnInfo];
    
    [self setupConnector];
    [self setupObjectsMapping];
    
    return self;
}

- (NSDate*)getLastDateTimeRequest
{
    //[APIClient sharedInstance].lastUpdateTime = [NSDate date];
    return [APIClient sharedInstance].lastUpdateTime;
}

- (NSString*)getCurrentUpdateStatus
{
    if (_connectionState == AppConnectStateAvailable)
        lastUpdateStatus = localizedString(@"Available");
    else if (_connectionState == AppConnectStateUnavailable)
        lastUpdateStatus = localizedString(@"Unavailable");
    else
        lastUpdateStatus = @"?";
    return lastUpdateStatus;
}

- (void)setConnectionState:(AppConnectState)cs {
    if (_connectionState == cs)
        return;
    AppConnectState oldState = _connectionState;
    _connectionState = cs;
    if (cs == AppConnectStateAvailable)
        lastUpdateStatus = localizedString(@"Available");
    else if (cs == AppConnectStateUnavailable)
        lastUpdateStatus = localizedString(@"Unavailable");
    else
        lastUpdateStatus = @"?";
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithKeysAndObjects:
                              @"newState", [NSNumber numberWithInt:_connectionState],
                              @"oldState", [NSNumber numberWithInt:oldState],
                              nil ];
//    [[NSNotificationCenter defaultCenter] postNotificationName:APP_NOTIF_CONNECTIONSTATE object:nil userInfo:userInfo];
}

- (void) resetLogOnInfo
{
    self.isLogOn = NO;
    self.sessionId = @"";
}

/*
 - (NSString *)getCurrentCustomerId
 {
 return ValueOrEmpty(accDataManagerInstance.customerId);
 }
 
 - (NSString *)getCurrentAccountId
 {
 return ValueOrEmpty(accDataManagerInstance.defaultAccountId);
 }
 */
- (NSString*) getBaseUrl
{
    return SERVER_URL;
}

// Get RestKit sharedManager instance for making requests
- (RKObjectManager *) getRKManager
{
    return [RKObjectManager sharedManager];
}

- (id) setupConnector
{
    // Config RestKit
    //RKLogConfigureByName("RestKit/Network*", RKLogLevelTrace);
    //RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    
    RKClient *client = [RKClient sharedClient];
    if (!client) {
        client = [RKClient clientWithBaseURLString: self.getBaseUrl];
    }
    client.baseURL = [RKURL URLWithString:self.getBaseUrl];
    
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    if (!objectManager) {
        objectManager = [RKObjectManager objectManagerWithBaseURL:[RKURL URLWithString:self.getBaseUrl]];
        objectManager.client.serviceUnavailableAlertEnabled = NO;
        objectManager.requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;
        //NOTE: Bypass invalid cer, should set to NO when have valid cer
        objectManager.client.disableCertificateValidation = YES;
    }
    objectManager.client.baseURL = [RKURL URLWithString:self.getBaseUrl];
    
    client.requestQueue.requestTimeout = 10;
    
    // Set authentication mode
    
    /* client.cachePolicy = RKRequestCachePolicyNone;
     client.authenticationType = RKRequestAuthenticationTypeHTTPBasic;
     client.username = @"rssuser";
     client.password = @"rsspwd";
     */
    
    // Set default date format for parser
    //[RKObjectMapping addDefaultDateFormatterForString:@"E MMM d HH:mm:ss Z y" inTimeZone:nil];
    //[RKObjectMapping addDefaultDateFormatter: [RKDotNetDateFormatter dotNetDateFormatterWithTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]]];
    //[RKObjectMapping addDefaultDateFormatter: [RKDotNetDateFormatter dotNetDateFormatter]];
    
    // Globally use JSON as the wire format for POST/PUT operations
    objectManager.serializationMIMEType = RKMIMETypeJSON;
    
    RKLogInfo(@"Configured API (Client=%@, Manager=%@)", client.baseURL, objectManager.baseURL);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ntfRequestFailedWithError:) name:RKRequestDidFailWithErrorNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ntfMapObjectFailed:) name:RKServiceDidMappingObjectFailedNotification object:nil];
    
    return self;
}

- (void) ntfRequestFailedWithError: (NSNotification *) notif
{
    NSDictionary *userInfo = [notif userInfo];
    NSError *err = [userInfo objectForKey:RKRequestDidFailWithErrorNotificationUserInfoErrorKey];
    [self handleRequestsError:err];
}

- (void) ntfMapObjectFailed: (NSNotification *) notif
{
    NSLog(@"ntfMapObjectFailed");
    //[UIHelper showErrorDialogWithMessage:@"Error"];
    //[[NSNotificationCenter defaultCenter] postNotificationName:APP_NOTIF_NEEDLOGOUT object:nil];
}


- (BOOL) handleRequestsError: (NSError *) err
{
    if (!err)
        return NO;
    if ([self isNeedLogoutStatusCode:err.code]) {
        DLog(@"Send force logout for err: %@", err);
        //[accDataManagerInstance handleForceLogoutRetCode:@"Plus2"];
        return YES;
    }
    return NO;
}

- (BOOL) isNetworkReachable {
    if ([[[RKClient sharedClient] reachabilityObserver] isReachabilityDetermined] && [[RKClient sharedClient] isNetworkReachable]) {
        return YES;
    }
    return NO;
}

- (void) setupObjectsMapping
{
    RKObjectMappingProvider *mappingProvider = [RKObjectManager sharedManager].mappingProvider;
    
    // https://github.com/RestKit/RestKit/wiki/Object-mapping
    
    // Register object mappings -----------------------------------------
    [mappingProvider addObjectMapping:[APIResponseKit getMapping]];
    [APIResponseKit registerAllMappings:mappingProvider];
    
    /*RKObjectMapping *getUserDTOMapping = [UserDTO getMapping];
    [mappingProvider addObjectMapping:getUserDTOMapping];
    
    [mappingProvider addObjectMapping:[UserDTO getMapping]];
    [mappingProvider addObjectMapping:[MessageDto getMapping]];
    [mappingProvider addObjectMapping:[FriendsDto getMapping]];
    [mappingProvider addObjectMapping:[EventDto getMapping]];
    [mappingProvider addObjectMapping:[Videoinfo getMapping]];
    [mappingProvider addObjectMapping:[CommentDto getMapping]];
    [mappingProvider addObjectMapping:[EventInfoDto getMapping]];
    [mappingProvider addObjectMapping:[EventTemple getMapping]];
    [mappingProvider addObjectMapping:[FollowDto getMapping]];
    [mappingProvider addObjectMapping:[Likes getMapping]];
    [mappingProvider addObjectMapping:[MyFeedInfoDto getMapping]];
    [mappingProvider addObjectMapping:[Personalinfo getMapping]];
    [mappingProvider addObjectMapping:[VideoInfoDetail getMapping]];
    [mappingProvider addObjectMapping:[VideoInfoDto getMapping]];
    [mappingProvider addObjectMapping:[VideoDto getMapping]];
    [mappingProvider addObjectMapping:[OnTvUserDto getMapping]];
    [mappingProvider addObjectMapping:[SpreadUserDTO getMapping]];
    [mappingProvider addObjectMapping:[VoteInfoDto getMapping]];
    [mappingProvider addObjectMapping:[MklEmblem getMapping]];
	[mappingProvider addObjectMapping:[FeedInfoDto getMapping]];*/
    
    /*RKObjectMapping *loginResponseMapping = [UM_LoginResponse getMapping];
    [loginResponseMapping mapKeyPath:@"Userinfo" toRelationship:@"Userinfo" withMapping:getUserDTOMapping];
    [mappingProvider addObjectMapping:loginResponseMapping];*/

    /*[mappingProvider addObjectMapping:[UM_LoginResponse getMapping]];
    
    [mappingProvider addObjectMapping:[UM_EditProfileResponse getMapping]];
    [mappingProvider addObjectMapping:[UM_AddRemoveFriendResponse getMapping]];
    [mappingProvider addObjectMapping:[UM_MyMovementResponse getMapping]];
    [mappingProvider addObjectMapping:[UM_FriendsMovementResponse getMapping]];
    [mappingProvider addObjectMapping:[UM_FriendsListResponse getMapping]];
    
    [mappingProvider addObjectMapping:[EV_DiscoveryEventResponse getMapping]];
    [mappingProvider addObjectMapping:[EV_AddNewEventResponse getMapping]];
    [mappingProvider addObjectMapping:[EV_GetMyEventResponse getMapping]];
    [mappingProvider addObjectMapping:[EV_FollowEventResponse getMapping]];
    [mappingProvider addObjectMapping:[EV_EventInfoResponse getMapping]];
    [mappingProvider addObjectMapping:[EV_TVTimeResponse getMapping]];
    [mappingProvider addObjectMapping:[EV_GetMyCreatedEventResponse getMapping]];
	[mappingProvider addObjectMapping:[EV_UploadEventResponse getMapping]];
	[mappingProvider addObjectMapping:[EV_VoteEventResponse getMapping]];
	[mappingProvider addObjectMapping:[EV_CloudServiceResponse getMapping]];
    [mappingProvider addObjectMapping:[EV_HotBoardResponse getMapping]];
    
    [mappingProvider addObjectMapping:[VI_GetUpTokenResponse getMapping]];
    [mappingProvider addObjectMapping:[VI_SaveVideoInfoResponse getMapping]];
    [mappingProvider addObjectMapping:[VI_LikeVideoResponse getMapping]];
    [mappingProvider addObjectMapping:[VI_VoteVideoResponse getMapping]];
    [mappingProvider addObjectMapping:[VI_CommentVideoResponse getMapping]];
    [mappingProvider addObjectMapping:[VI_GetVideoLikeResponse getMapping]];
    [mappingProvider addObjectMapping:[VI_BrowseVideoResponse getMapping]];
    [mappingProvider addObjectMapping:[VI_GetVideoCommentsResponse getMapping]];
    [mappingProvider addObjectMapping:[VI_GetVideoFeedsResponse getMapping]];
	[mappingProvider addObjectMapping:[VI_GetHotVideoResponse getMapping]];
    [mappingProvider addObjectMapping:[VI_GetVoteFriendVideoResponse getMapping]];
    
	[mappingProvider addObjectMapping:[ActivityDetailsMsgS2C getMapping]];
    [mappingProvider addObjectMapping:[AddEventMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[AddFriendMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[AddnewgameMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[DiscoveryeventMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[EditProfileS2C getMapping]];
	[mappingProvider addObjectMapping:[FollowMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[FollowOrUnfollowEventMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[GetAllCommentsMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[GetAllLikeMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[GetHotVideoMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[GetmycreatedMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[GetmyeventMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[GetTvTimeSpendingMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[GetVoteFriendVideoMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[JpushP2PS2C getMapping]];
	[mappingProvider addObjectMapping:[LogOutMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[MyfriendsMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[MymovementMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[MyTVTimeMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[MyTvTimeResualtMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[ProsecuteFeedsMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[RecommendedUsersMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[RegisterUserMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[ThirdLoginMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[UpdateLoadTokenS2C getMapping]];
	[mappingProvider addObjectMapping:[UploadeventMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[UserOutlineFeedsMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[VideoBrowsesMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[VideoCommentMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[VideoLikeMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[VideoLikeS2C getMapping]];
	[mappingProvider addObjectMapping:[VideoSharedVoteS2C getMapping]];
	[mappingProvider addObjectMapping:[VideoShareMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[VideoUserFeedsMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[VideoVoteMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[VideoVoteS2C getMapping]];
	[mappingProvider addObjectMapping:[VoteeventMsgS2C getMapping]];
    [mappingProvider addObjectMapping:[CheckEventNameS2C getMapping]];
    [mappingProvider addObjectMapping:[CreatAccountMsgS2C getMapping]];
    [mappingProvider addObjectMapping:[GetNewVersionMsgS2C getMapping]];
    [mappingProvider addObjectMapping:[NewUserFollowEventMsgS2C getMapping]];
    [mappingProvider addObjectMapping:[NewUserFollowUsersMsgS2C getMapping]];
    [mappingProvider addObjectMapping:[SpreadUserS2C getMapping]];
    [mappingProvider addObjectMapping:[UserOpinionMsgS2C getMapping]];
    [mappingProvider addObjectMapping:[WebGetSpreadActivityMsgS2C getMapping]];
     
    [mappingProvider addObjectMapping:[AllVoteInfoMsgS2C getMapping]];
    [mappingProvider addObjectMapping:[NewLoginMsgS2C getMapping]];
    [mappingProvider addObjectMapping:[SendPin2UserS2C getMapping]];
    [mappingProvider addObjectMapping:[ShareVideoInfoMsgS2C getMapping]];
	 
	[mappingProvider addObjectMapping:[MobileFirstPageMsgS2C getMapping]];
	[mappingProvider addObjectMapping:[SubscribeFeedMsgS2C getMapping]];*/
     
	
    /*
     GoldQ
    [mappingProvider addObjectMapping:[AM_TokenResponse getMapping]];
    [AM_TokenResponse registerAllMappings:mappingProvider];
    
    [mappingProvider addObjectMapping:[APIResponse getMapping]];
    [APIResponse registerAllMappings:mappingProvider];
    
    RKObjectMapping *getMemberInfoDTOMapping = [MemberInfoDTO getMapping];
    [mappingProvider addObjectMapping:getMemberInfoDTOMapping];
    RKObjectMapping *getTransInfoDTOMapping = [TransInfoDTO getMapping];
    [mappingProvider addObjectMapping:getTransInfoDTOMapping];
    RKObjectMapping *getLinkManDTOMapping = [LinkManDTO getMapping];
    [mappingProvider addObjectMapping:getLinkManDTOMapping];
    
    RKObjectMapping *loginResponseMapping = [AM_LoginResponse getMapping];
    [loginResponseMapping mapKeyPath:@"memberInfo" toRelationship:@"memberInfo" withMapping:getMemberInfoDTOMapping];
    [mappingProvider addObjectMapping:loginResponseMapping];
    [AM_LoginResponse registerAllMappings:mappingProvider];
    
    [mappingProvider addObjectMapping:[AM_RequestPINResponse getMapping]];
    [AM_RequestPINResponse registerAllMappings:mappingProvider];
    
    RKObjectMapping *registerResponseMapping = [AM_RegisterResponse getMapping];
    [registerResponseMapping mapKeyPath:@"memberInfo" toRelationship:@"memberInfo" withMapping:getMemberInfoDTOMapping];
    [mappingProvider addObjectMapping:registerResponseMapping];
    
    //[mappingProvider addObjectMapping:[TM_TransactionListResponse getMapping]];
    [TM_TransactionListResponse registerAllMappings:mappingProvider];
    
    RKObjectMapping *preTransferResponseMapping = [TM_PreTranferResponse getMapping];
    [preTransferResponseMapping mapKeyPath:@"transInfo" toRelationship:@"transInfo" withMapping:getTransInfoDTOMapping];
    [mappingProvider addObjectMapping:preTransferResponseMapping];
    
    RKObjectMapping *confirmTransactionResponseMapping = [TM_ConfirmTransferResponse getMapping];
    [confirmTransactionResponseMapping mapKeyPath:@"transInfo" toRelationship:@"transInfo" withMapping:getTransInfoDTOMapping];
    [mappingProvider addObjectMapping:confirmTransactionResponseMapping];
    
    RKObjectMapping *linkManListResponseMapping = [TM_LinkManListResponse getMapping];
    [linkManListResponseMapping mapKeyPath:@"linkmanDTOs" toRelationship:@"linkmanDTOs" withMapping:getLinkManDTOMapping];
    [mappingProvider addObjectMapping:linkManListResponseMapping];
    */
    // -------------------------------------------------
    
    // Define date parser
    /*NSDateFormatter *dateFormatter = [NSDateFormatter new];
     [dateFormatter setDateFormat:@"yyyy-MM-dd"];
     dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
     dtoMapping.dateFormatters = [NSArray arrayWithObject:dateFormatter];
     */
    
    // Define mapping by resource key path
    //[mappingProvider setObjectMapping: dynamicMapping forResourcePathPattern:@"/...."
    
    
    // Dynamic mapping -------------------------------------------------
    
    //RKDynamicObjectMapping* dynamicMapping = [RKDynamicObjectMapping dynamicMapping];
    
    // Dynamic mapping using matchers
    //[dynamicMapping setObjectMapping:miResultMapping whenValueOfKeyPath:@"responseType" isEqualTo:@"FO_TF_MI_Get_MarketInformationResponse"];
    //[dynamicMapping setObjectMapping:stockInfoMapping whenValueOfKeyPath:@"responseType" isEqualTo:@"FO_TF_OE_StockInformationRespone"];
    
    // Use dynamic for all response
    
    //DLog(@"USE_DYNAMIC_MAPPING");
    //[mappingProvider setMapping:dynamicMapping forKeyPath:@""];
    
    // Configure the dynamic mapping via a block
    /*
     dynamicMapping.objectMappingForDataBlock = ^ RKObjectMapping* (id mappableData) {
     RKObjectMappingProvider *tmpProvider = [RKObjectManager sharedManager].mappingProvider;
     
     //NOTE: Can config explicit in request function
     
     NSString *resType = [mappableData valueForKey:@"responseType"];
     if ([resType isEqualToString:@"FO_TF_MI_Get_MarketInformationResponse"]) {
     return [tmpProvider objectMappingForClass:[TF_MI_MarketInfoResponse class]];
     } else if ([resType isEqualToString:@"FO_TF_OE_StockInformationRespone"]) {
     return [tmpProvider objectMappingForClass:[TF_OE_StockInfoResponse class]];
     }
     
     // Default mapping is GeneralAPIResponse
     return [tmpProvider objectMappingForClass:[GeneralAPIResponse class]];
     };
     */
    // Register serialize
    //[mappingProvider setSerializationMapping:dtoMapping forClass:[TF_MI_MarketInfo class] ];
    
    // Object routing for POST ------------------------------------------------
    
    /*
     // Grab the reference to the router from the manager
     RKObjectRouter *router = [RKObjectManager sharedManager].router;
     
     // Define a default resource path for all unspecified HTTP verbs
     // routing ALL VERBS /FO_TF_MI_Get_MarketInformation/XXXX to TF_MI_MarketInfo
     [router routeClass:[TF_MI_MarketInfoRequest class] toResourcePath:@"/FO_TF_MI_Get_MarketInformation/:market"];
     [router routeClass:[TF_MI_MarketInfoRequest class] toResourcePath:@"/FO_TF_MI_Get_MarketInformation" forMethod:RKRequestMethodPOST];
     */
}

#pragma mark - Helpers

- (NSError *)errorWithMessage:(NSString *)errorText code:(NSInteger)code {
    return  [NSError errorWithDomain:kServerDomainName code:code userInfo:[NSDictionary dictionaryWithObject:errorText forKey:NSLocalizedDescriptionKey]];
}

- (NSError *)errorWithMessage:(NSString *)errorText {
    return  [self errorWithMessage:errorText code:0];
}

- (BOOL) isNeedLogoutStatusCode:(NSInteger) httpErr
{
    if (httpErr == 503)
        return YES;
    //if (httpErr == 1001)  // kCFURLErrorTimedOut
    //    return @"338";
    //markpham: will check in detail
    //if (httpErr == -1003)    // kCFURLErrorCannotFindHost
    //    return YES;
    if (httpErr == -1004)    // kCFURLErrorCannotConnectToHost
        return YES;
    
    return NO;
}

- (void)fireErrorBlock:(RKRequestDidFailLoadWithErrorBlock)failBlock onErrorInResponse:(RKResponse *)response
{
    if (!response) {
        failBlock([self errorWithMessage:localizedString(@"connect_error")]);
        //[UIHelper showMessage:localizedString(@"connect_error")];
        return;
    }
    if (![response isOK]) {
        // Custom parse error from our msg
        id parsedResponse = [response parsedBody:NULL];
        NSString *errorText = nil;
        if ([parsedResponse isKindOfClass:[NSDictionary class]]) {
            errorText = [parsedResponse objectForKey:@"error"];
        }
        NSInteger statusCode = [response statusCode];
        if (errorText)
            failBlock([self errorWithMessage:errorText code:statusCode]);
        else{
            //The system is temporarily unavailable
            //            failBlock([self errorWithMessage:[Utils GetMessageByErrorCode:338]]);
            failBlock([self errorWithMessage:localizedString(@"Transfer_Alert_1")]);
            
        }
        // Auto display common HTTP Errors
        
        // service unavailable, update status
        if (statusCode == 500 ||
            statusCode == 503 ||
            [self isNeedLogoutStatusCode:statusCode])
            self.connectionState = AppConnectStateUnavailable;
        /*
         // Try to logout if server unavailable
         if ([self isNeedLogoutStatusCode:statusCode]) {
         //DLog(@"Send force logout when statusCode=%d", statusCode);
         [accDataManagerInstance handleForceLogoutRetCode:@"Plus2"];
         }
         */
        if (!errorText) {
            errorText = [[NSMutableString alloc] initWithData:response.body encoding:NSUTF8StringEncoding];
            [((NSMutableString*)errorText) insertString:[NSString stringWithFormat:@"%@ \nParams: %@\n",response.request.URL.description,response.request.params.description] atIndex:0];
        }
        DISPATCH_TO_CURRENT_QUEUE(YES, ^{
            [Utils printLogApisToFile:(NSString*)errorText];
        });
        /*
         NSString *remappedError = [Utils remapHttpErrorToRetCode:statusCode];
         if (remappedError)
         [UIHelper showErrorDialogWithMessage:[Utils getErrorString:remappedError]];
         */
    } else {
        // SUCCESS, print body for debug
        //id parsedResponse = [response parsedBody:NULL];
        //RKLogTrace(@"response: [%@] %@\n%@", [parsedResponse class], parsedResponse, [response bodyAsString]);
    }
}

/*
- (void)getToken
{
    NSString *url = @"/member/getToken";
    
    RKObjectManager *manager = [RKObjectManager sharedManager];
    
    [manager loadObjectsAtResourcePath:url usingBlock:^(RKObjectLoader *loader) {
        
        // Specify method (POST/GET)
        loader.method = RKRequestMethodPOST;
        // Reassign mappings
        RKObjectMappingProvider *mappingProvider = [RKObjectManager sharedManager].mappingProvider;
        //loader.objectMapping = [mappingProvider objectMappingForClass:[AM_TokenResponse class]];
        
        // Set blocks/delegate for callbacks
        loader.onDidLoadObjects = ^(NSArray *objects) {
        };
        loader.onDidLoadResponse = ^(RKResponse *response) {
            NSError *error;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response.body options:kNilOptions error:&error];
            self.token = [dict objectForKey:@"token"];
            NSLog(@"Token=%@", self.token);
            
        };
    }];
}
*/

- (void) loadObjecsAtResourcePath:(NSString*)path withData:(APIRequest*)paras mappingClass:(Class)responseClass onSuccess: (RKObjectLoaderDidLoadObjectsBlock)loadBlock onError:(RKRequestDidFailLoadWithErrorBlock)failBlock
{
    //Check connection
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if (myStatus == NotReachable) {
        [self fireErrorBlock:failBlock onErrorInResponse:nil];
        return;
    }
    
    RKObjectManager *manager = [RKObjectManager sharedManager];
    
    
    
    [manager loadObjectsAtResourcePath:path usingBlock:^(RKObjectLoader *loader) {
        
        // Specify method (POST/GET)
        loader.method = RKRequestMethodPOST;
        
        
        // Reassign params
        //NSError *error = nil;
        //NSData* postData = [NSJSONSerialization dataWithJSONObject:[paras toDictionary] options:kNilOptions error:&error];
        //loader.HTTPBody = postData;
        loader.params = [paras toDictionary];
        // Reassign mappings
        RKObjectMappingProvider *mappingProvider = [RKObjectManager sharedManager].mappingProvider;
        loader.objectMapping = [mappingProvider objectMappingForClass:responseClass];
        
        // Set blocks/delegate for callbacks
        loader.onDidLoadObjects = loadBlock;
        loader.onDidFailWithError = failBlock;
        loader.onDidFailLoadWithError = failBlock;
        loader.onDidLoadResponse = ^(RKResponse *response) {
            NSLog(@"responseBody: %@", response.bodyAsString);
        };
    }];
    
}

- (void)uploadImage:(UIImage*)image hasKey:(NSString*)key toResourcePath:(NSString*)path withData:(APIRequest*)paras mappingClass:(Class)responseClass onSuccess: (RKObjectLoaderDidLoadObjectsBlock)loadBlock onError:(RKRequestDidFailLoadWithErrorBlock)failBlock {
    //Check connection
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if (myStatus == NotReachable) {
        [self fireErrorBlock:failBlock onErrorInResponse:nil];
        return;
    }
    
    RKObjectManager *manager = [RKObjectManager sharedManager];
    [manager loadObjectsAtResourcePath:path usingBlock:^(RKObjectLoader *loader) {
        loader.method = RKRequestMethodPOST;
        
        RKParams* params = [RKParams paramsWithDictionary:[paras toDictionary]];
        NSData* imageData =  UIImagePNGRepresentation(image);
        [params setData:imageData MIMEType:@"image/png" fileName:[NSString stringWithFormat:@"%@.png", key] forParam:key];
        //[params setData:imageData MIMEType:@"image/png" forParam:key];
        loader.params = params;
        // Reassign mappings
        RKObjectMappingProvider *mappingProvider = [RKObjectManager sharedManager].mappingProvider;
        loader.objectMapping = [mappingProvider objectMappingForClass:responseClass];
        
        // Set blocks/delegate for callbacks
        loader.onDidLoadObjects = loadBlock;
        loader.onDidFailWithError = failBlock;
        loader.onDidFailLoadWithError = failBlock;
        loader.onDidLoadResponse = ^(RKResponse *response) {
            NSLog(@"image_responseBody: %@", response.bodyAsString);
        };
    }];
}


- (RKRequestSerialization*)getRequestDictionary:(NSDictionary*)dict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] init];
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
        return nil;
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return [RKRequestSerialization serializationWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] MIMEType:RKMIMETypeJSON];
}

@end
