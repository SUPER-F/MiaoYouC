//
//  ModelBase.m
//  MiaoYouC
//
//  Created by drupem on 16/11/14.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import "ModelBase.h"
#import <objc/runtime.h>

@implementation ModelBase

+ (RKObjectMapping *) getMapping {
    RKObjectMapping* mapping = [ModelBase getMapping:[[self self] class] exceptionProperties:nil];
    return mapping;
}

+ (RKObjectMapping *) getMapping:(Class)aClass exceptionProperties:(NSArray*)array
{
    
    int count;
    objc_property_t *propList = class_copyPropertyList(aClass, &count);
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:aClass];
    for ( int i = 0; i < count; i++ )
    {
        objc_property_t property = propList[i];
        
        
        const char *propName = property_getName(property);
        NSString *propNameString =[NSString stringWithCString:propName encoding:NSASCIIStringEncoding];
        BOOL shouldMapping = YES;
        if (array) {
            for (int j = 0; j < array.count; j++) {
                if ([propNameString isEqualToString:[array objectAtIndex:j]]) {
                    shouldMapping = NO;
                    break;
                }
            }
        }
        if (shouldMapping) {
            [mapping mapAttributes:propNameString,nil];
        }
    }
    free(propList);
    return mapping;
}

@end
