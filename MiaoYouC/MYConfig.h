//
//  MYConfig.h
//  MiaoYouC
//
//  Created by drupem on 16/11/7.
//  Copyright © 2016年 drupem. All rights reserved.
//

#ifndef MYConfig_h
#define MYConfig_h

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBColorAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define SZNotificationCenter [NSNotificationCenter defaultCenter]
#define SZUserDefault [NSUserDefaults standardUserDefaults]

#define STR_TRIMALL( object )[object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]

static const CGFloat MYLoginAndRegistFont = 17.0;

#define  API_KEY                    @"123456"

#define  REQUEST_OK                 1
#define  REQUEST_FAILED             0
/////////////////////////////////////////
#define DEFAULT_LATITUDE               @"104.071882"
#define DEFAULT_LONGITUDE              @"30.662958"

////////////////////////////////////////////////
#define kServerDomainName                               @"api.Miaoyou"
#define  SERVER_URL                 @"http://api.7mlzg.com/"
#define  LOGIN_URL                  @"Customer/Login"
#define  GET_REGISTER_VER_CODE      @"Customer/SendRegistCode"
#define  VER_REGISTER_CODE          @"Customer/ConfirmRegistCode"
#define  COMPLETE_REGISTER_URL      @"Customer/Regist"
#define  FIND_PWD_URL               @"Customer/SendVerificationCode"
#define  FORGET_PWD_URL             @"Customer/ForgotPassword"
#define  GET_USER_INFO              @"Customer/GetGuestInfo"
#define  MODIFY_USER_INFO           @"Customer/ModifyGuestInfo"
#define  CUSTOMER_INFO_URL          @"Customer/GetMemberInfo"
#define  UPLOAD_PICTURE             @"Common/UploadPicture"
#define  GET_USER_RATING            @"Customer/GetServiceAndComments"
#define  MODIFY_USERINFO_MSG        @"Customer/ModifyGuestInfo"


#define appDataInstance                               [AppDataManager getInstance]

#endif /* MYConfig_h */
