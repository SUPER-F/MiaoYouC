//
//  BusinessLabel.h
//  Miaoyou
//
//  Created by Kiet Thai Thuan on 16/07/20
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "ModelBase.h"


@interface BusinessLabel : ModelBase

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *picture;

//@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *des;

@property (nonatomic, copy) NSString *codename;

@end