//
//  UIHelper.h
//  MiaoYouC
//
//  Created by drupem on 16/11/10.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIHelper : NSObject

//alert view + loading animation
+ (void)showHUDForView:(UIView*)v;
+ (void)showHUDForView:(UIView*)v message:(NSString*)msg;
+ (void)hideHUDForView:(UIView*)v;

+ (void)showMessage:(NSString*)message;

//Rounding view
+ (void)roundingViewCorners:(UIView*)v;
+ (void)roundingViewCorners:(UIView*)v borderColor:(UIColor*)borderClr;
+ (void)roundingViewCorners:(UIView*)v borderColor:(UIColor*)borderClr radius:(float)r;
+ (void)roundingViewCorners:(UIView*)v borderColor:(UIColor*)borderClr borderSize:(float)borderSiz radius:(float)r;
+ (void)roundingViewBottomCorners:(UIView*)view;
+ (void)shadowView:(UIView*)view;

//TextField
+ (void)paddingTextField:(UITextField*)textField withLeftSpacing:(CGFloat)leftSpacing andRightSpacing:(CGFloat)rightSpacing;
+ (void)paddingTextField:(UITextField*)textField withSpacing:(CGFloat)spacing;
+ (void)paddingTextField:(UITextField*)textField withLeftSpacing:(CGFloat)leftSpacing;
+ (void)paddingTextField:(UITextField*)textField withRightSpacing:(CGFloat)rightSpacing;

@end
