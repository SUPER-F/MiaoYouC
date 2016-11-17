//
//  UploadPictureResponse.h
//  Miaoyou
//
//  Created by Kiet Thai Thuan on 7/20/16.
//  Copyright (c) 2016 PROSOFT SG. All rights reserved.
//

#import "APIResponseKit.h"

@interface UploadPictureResponse : APIResponseKit

@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *img_thum;

@end
