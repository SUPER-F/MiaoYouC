//
//  CarInfo.h
//  Miaoyou
//
//  Created by Kiet Thai Thuan on 16/07/20
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelBase.h"


@interface CarInfo : ModelBase

@property (nonatomic, copy) NSString *BrandName;

@property (nonatomic, copy) NSString *BrandID;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *SeatCount;

@property (nonatomic, copy) NSString *State;

@property (nonatomic, copy) NSString *CarYear;

@property (nonatomic, copy) NSString *License;

@property (nonatomic, copy) NSString *CarModelsName;

@property (nonatomic, copy) NSString *Picture_VehicleLicense;

@property (nonatomic, copy) NSString *Picture_VehicleLicense_Back;

@property (nonatomic, copy) NSString *Picture_BusinessRisks;

@property (nonatomic, copy) NSString *CarModels;

@property (nonatomic, copy) NSString *Picture_Car;

@property (nonatomic, copy) NSString *Picture_CompulsoryRisks;

@end