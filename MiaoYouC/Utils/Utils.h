//
//  Utils.h
//  MiaoYouC
//
//  Created by drupem on 16/11/14.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (NSString*)autoDescribe:(id)instance;

NSString* localizedString(NSString *string);

//Print log apis to file
+ (void)printLogApisToFile:(id)objectResponse;

+ (BOOL)isEmpty:(NSString*)string;
+ (BOOL)checkEmail:(NSString*)email;
+ (BOOL)checkMobileNumber:(NSString*)number;

+ (BOOL)vaildEmail:(NSString*)email;
+ (BOOL)vaildPassword:(NSString*)password;
+ (BOOL)vaildUsername:(NSString*)username;
+ (BOOL)vaildPin:(NSString*)pin;
+ (BOOL)vaildPhoneNumber:(NSString*)phone;

// DISPATCHERS
void DISPATCH_TO_MAIN_QUEUE(BOOL isAsync, void (^block)());
void DISPATCH_TO_GLOBAL_QUEUE(dispatch_queue_priority_t priority, BOOL isAsync, void (^block)());
void DISPATCH_TO_CURRENT_QUEUE(BOOL isAsync, void (^block)());
void DISPATCH_TO_QUEUE(dispatch_queue_t queue, BOOL isAsync, void (^block)());
void DISPATCH_TO_MAIN_QUEUE_AFTER(NSTimeInterval delay, void (^block)());
void DISPATCH_TO_GLOBAL_QUEUE_AFTER(NSTimeInterval delay, dispatch_queue_priority_t priority, void (^block)());
void DISPATCH_TO_CURRENT_QUEUE_AFTER(NSTimeInterval delay, void (^block)());
void DISPATCH_TO_QUEUE_AFTER(NSTimeInterval delay, dispatch_queue_t queue, void (^block)());



@end


#define IS_IPAD	(UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPhone)

#define IS_RETINA ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0)
