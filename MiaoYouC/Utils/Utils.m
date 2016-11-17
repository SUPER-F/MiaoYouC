//
//  Utils.m
//  MiaoYouC
//
//  Created by drupem on 16/11/14.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import "Utils.h"
#import <objc/runtime.h>

@implementation Utils

// Finds all properties of an object, and prints each one out as part of a string describing the class.
+ (NSString*)autoDescribe:(id)instance classType:(Class)classType
{
    unsigned int count;
    objc_property_t *propList = class_copyPropertyList(classType, &count);
    NSMutableString *propPrint = [NSMutableString string];
    int numberLine = 3;
    for ( int i = 0; i < count; i++ )
    {
        objc_property_t property = propList[i];
        
        const char *propName = property_getName(property);
        NSString *propNameString =[NSString stringWithCString:propName encoding:NSASCIIStringEncoding];
        
        if(propName)
        {
            id value = [instance valueForKey:propNameString];
            [propPrint appendString:[NSString stringWithFormat:@"%@=%@ ; ", propNameString, value]];
            numberLine --;
            if (numberLine == 0){
                numberLine = 3;
                [propPrint appendString:@"\n"];
            }
        }
    }
    free(propList);
    
    
    // Now see if we need to map any superclasses as well.
    Class superClass = class_getSuperclass( classType );
    if ( superClass != nil && ! [superClass isEqual:[NSObject class]] )
    {
        NSString *superString = [self autoDescribe:instance classType:superClass];
        [propPrint appendString:superString];
    }
    
    return propPrint;
}

+ (NSString*)autoDescribe:(id)instance
{
    @try {
        NSString *headerString = [NSString stringWithFormat:@"%@:%p:: ",[instance class], instance];
        return [headerString stringByAppendingString:[self autoDescribe:instance classType:[instance class]]];
    }
    @catch (NSException *exception){
        return [instance description];
    }
    @finally {
        
    }
}

NSString* localizedString(NSString *string) {

    return NSLocalizedString(string, nil);
}

//Print log apis to file
int count = 1;
+ (void)printLogApisToFile:(id)objectResponse
{
    
}

+ (BOOL)isEmpty:(NSString*)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

+ (BOOL)checkEmail:(NSString*)email {
    return [self vaildEmail:email];
}

+ (BOOL)checkMobileNumber:(NSString*)number {
    return [self vaildPhoneNumber:number];
}

+ (BOOL)vaildEmail:(NSString*)email
{
    if([email length]==0){
        return NO;
    }
    
    NSString *regExPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:email options:0 range:NSMakeRange(0, [email length])];
    
    if (regExMatches == 0) {
        return NO;
    } else {
        return YES;
    }
}

+ (BOOL)vaildPassword:(NSString*)password
{
    if (password.length < 6)
    {
        return NO;
    }
    
    NSString *regExPattern = @"^\\w+$";
    
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:password options:0 range:NSMakeRange(0, [password length])];
    
    if (regExMatches == 0) {
        return NO;
    } else {
        return YES;
    }
}

+ (BOOL)vaildUsername:(NSString*)username
{
    if (username.length < 3  || username.length > 32)
    {
        return NO;
    }
    
    NSString *regExPattern = @"^\\w+$";
    
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:username options:0 range:NSMakeRange(0, [username length])];
    
    if (regExMatches == 0) {
        return NO;
    } else {
        return YES;
    }
}

+ (BOOL)vaildPin:(NSString*)pin
{
    if (pin.length == 0) {
        return NO;
    }
    if (pin.length <= 0  || pin.length > 6)
    {
        return NO;
    }
    
    NSString *regExPattern = @"^\\d+$";
    
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:pin options:0 range:NSMakeRange(0, [pin length])];
    
    if (regExMatches == 0) {
        return NO;
    } else {
        return YES;
    }
}

+ (BOOL)vaildPhoneNumber:(NSString *)phone
{
    if (phone.length == 0) {
        return NO;
    }
    if (phone.length <= 0  || phone.length > 11)
    {
        return NO;
    }
    
    NSString *regExPattern = @"^\\d+$";
    
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:phone options:0 range:NSMakeRange(0, [phone length])];
    
    if (regExMatches == 0) {
        return NO;
    } else {
        return YES;
    }
}


// DISPATCHERS

void DISPATCH_TO_MAIN_QUEUE(BOOL isAsync, void (^block)()) {
    if (isAsync) {
        dispatch_async(dispatch_get_main_queue(), block);
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

void DISPATCH_TO_GLOBAL_QUEUE(dispatch_queue_priority_t priority, BOOL isAsync, void (^block)()) {
    if (isAsync) {
        dispatch_async(dispatch_get_global_queue(priority, 0), block);
    } else {
        dispatch_sync(dispatch_get_global_queue(priority, 0), block);
    }
}

void DISPATCH_TO_CURRENT_QUEUE(BOOL isAsync, void (^block)()) {
    if (isAsync) {
        dispatch_async(dispatch_get_current_queue(), block);
    } else {
        dispatch_sync(dispatch_get_current_queue(), block);
    }
}

void DISPATCH_TO_QUEUE(dispatch_queue_t queue, BOOL isAsync, void (^block)()) {
    if (isAsync) {
        dispatch_async(queue, block);
    } else {
        dispatch_sync(queue, block);
    }
}

void DISPATCH_TO_MAIN_QUEUE_AFTER(NSTimeInterval delay, void (^block)()) {
    dispatch_time_t runTime = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(runTime, dispatch_get_main_queue(), block);
}

void DISPATCH_TO_GLOBAL_QUEUE_AFTER(NSTimeInterval delay, dispatch_queue_priority_t priority, void (^block)()) {
    dispatch_time_t runTime = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(runTime, dispatch_get_global_queue(priority, 0), block);
}

void DISPATCH_TO_CURRENT_QUEUE_AFTER(NSTimeInterval delay, void (^block)()) {
    dispatch_time_t runTime = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(runTime, dispatch_get_current_queue(), block);
}

void DISPATCH_TO_QUEUE_AFTER(NSTimeInterval delay, dispatch_queue_t queue, void (^block)()) {
    dispatch_time_t runTime = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(runTime, queue, block);
}
@end
