//
//  ModelBase.h
//  MiaoYouC
//
//  Created by drupem on 16/11/14.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelBase : NSObject

+ (RKObjectMapping *) getMapping;

+ (RKObjectMapping *) getMapping:(Class)aClass exceptionProperties:(NSArray*)array;

@end
