//
//  RegistResponse.h
//  Miaoyou
//
//  Created by Kiet Thai Thuan on 7/20/16.
//  Copyright (c) 2016 PROSOFT SG. All rights reserved.
//

#import "APIResponseKit.h"

@interface RegistResponse : APIResponseKit

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *NickName;
//@property (nonatomic, assign) BOOL *Sex;
@property (nonatomic, strong) NSString *Sex;
@property (nonatomic, strong) NSString *AreaID;
@property (nonatomic, strong) NSString *Birthday;
@property (nonatomic, strong) NSString *Mobile;

@end
