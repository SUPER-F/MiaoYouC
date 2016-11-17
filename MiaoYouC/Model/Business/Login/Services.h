//
//  Services.h
//  Miaoyou
//
//  Created by Kiet Thai Thuan on 16/07/20
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelBase.h"


@interface Services : ModelBase

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *title;

//@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *des;

@property (nonatomic, copy) NSString *servicetype;

@property (nonatomic, copy) NSString *servicetime;

@property (nonatomic, copy) NSString *state;

@end