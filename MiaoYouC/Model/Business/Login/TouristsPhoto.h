//
//  TouristsPhoto.h
//  Miaoyou
//
//  Created by Kiet Thai Thuan on 16/07/20
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelBase.h"


@interface TouristsPhoto : ModelBase

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *img_thum;

@end