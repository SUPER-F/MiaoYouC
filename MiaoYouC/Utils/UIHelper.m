//
//  UIHelper.m
//  MiaoYouC
//
//  Created by drupem on 16/11/10.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import "UIHelper.h"

@implementation UIHelper

#pragma mark - 1. Loading animation


+ (void)showHUDForView:(UIView*)v
{
    [MBProgressHUD showHUDAddedTo:v
                         animated:YES];
}

+ (void)showHUDForView:(UIView*)v
               message:(NSString*)msg
{
    if (!msg)
        [MBProgressHUD showHUDAddedTo:v
                             animated:YES];
    else {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:v
                                                  animated:YES];
        hud.labelText = msg;
    }
}

+ (void)hideHUDForView:(UIView*)v
{
    [MBProgressHUD hideHUDForView:v
                         animated:YES];
}

+ (void)showMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:localizedString(@"dialog_close")
                                          otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - Rounding view

+ (void)roundingViewCorners:(UIView *)v
{
    [UIHelper roundingViewCorners:v borderColor:[UIColor darkGrayColor] radius:8.0];
}

+ (void) roundingViewCorners: (UIView *)v borderColor:(UIColor *)borderClr
{
    [UIHelper roundingViewCorners:v borderColor:borderClr radius:8.0];
}


+ (void) roundingViewCorners: (UIView *)v borderColor:(UIColor *)borderClr radius:(float)r
{
    [v.layer setCornerRadius:r];
    [v.layer setBorderColor:borderClr.CGColor];
    [v.layer setBorderWidth:1.0f];
    //    [v.layer setShadowColor:[UIColor blackColor].CGColor];
    //    [v.layer setShadowOpacity:0.8];
    //    [v.layer setShadowRadius:3.0];
    //    [v.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    v.layer.masksToBounds = YES;
}

+ (void)roundingViewCorners:(UIView*)v borderColor:(UIColor*)borderClr borderSize:(float)borderSiz radius:(float)r {
    [v.layer setCornerRadius:r];
    [v.layer setBorderColor:borderClr.CGColor];
    [v.layer setBorderWidth:borderSiz];
    v.layer.masksToBounds = YES;
}

+ (void) roundingViewBottomCorners: (UIView *)view
{
    // Create the mask image you need calling the previous function
    UIImage *mask = MTDContextCreateRoundedMask( view.bounds, 50.0, 50.0, 0.0, 0.0 );
    // Create a new layer that will work as a mask
    CALayer *layerMask = [CALayer layer];
    layerMask.frame = view.bounds;
    // Put the mask image as content of the layer
    layerMask.contents = (id)mask.CGImage;
    // set the mask layer as mask of the view layer
    view.layer.mask = layerMask;
    view.layer.masksToBounds = YES;
}

+ (void) shadowView:(UIView *)v
{
    [v.layer setShadowColor:[UIColor blackColor].CGColor];
    [v.layer setShadowOpacity:0.8];
    [v.layer setShadowRadius:3.0];
    [v.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
}

#pragma mark - TextField
+ (void)paddingTextField:(UITextField*)textField withLeftSpacing:(CGFloat)leftSpacing andRightSpacing:(CGFloat)rightSpacing {
    if (leftSpacing && leftSpacing>0) {
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftSpacing, 28)];
        textField.leftView = paddingView;
        textField.leftViewMode = UITextFieldViewModeAlways;
    }
    if (rightSpacing && rightSpacing>0) {
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rightSpacing, 28)];
        textField.rightView = paddingView;
        textField.rightViewMode = UITextFieldViewModeAlways;
    }
}
+ (void)paddingTextField:(UITextField*)textField withSpacing:(CGFloat)spacing {
    [UIHelper paddingTextField:textField withLeftSpacing:spacing andRightSpacing:spacing];
}
+ (void)paddingTextField:(UITextField*)textField withLeftSpacing:(CGFloat)leftSpacing {
    [UIHelper paddingTextField:textField withLeftSpacing:leftSpacing andRightSpacing:0.0];
}
+ (void)paddingTextField:(UITextField*)textField withRightSpacing:(CGFloat)rightSpacing {
    [UIHelper paddingTextField:textField withLeftSpacing:0.0 andRightSpacing:rightSpacing];
}


#pragma mark - Private Helpers

static inline UIImage* MTDContextCreateRoundedMask( CGRect rect, CGFloat radius_tl, CGFloat radius_tr, CGFloat radius_bl, CGFloat radius_br ) {
    
    CGContextRef context;
    CGColorSpaceRef colorSpace;
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create a bitmap graphics context the size of the image
    context = CGBitmapContextCreate( NULL, rect.size.width, rect.size.height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast );
    
    // free the rgb colorspace
    CGColorSpaceRelease(colorSpace);
    
    if ( context == NULL ) {
        return NULL;
    }
    
    // cerate mask
    
    CGFloat minx = CGRectGetMinX( rect ), midx = CGRectGetMidX( rect ), maxx = CGRectGetMaxX( rect );
    CGFloat miny = CGRectGetMinY( rect ), midy = CGRectGetMidY( rect ), maxy = CGRectGetMaxY( rect );
    
    CGContextBeginPath( context );
    CGContextSetGrayFillColor( context, 1.0, 0.0 );
    CGContextAddRect( context, rect );
    CGContextClosePath( context );
    CGContextDrawPath( context, kCGPathFill );
    
    CGContextSetGrayFillColor( context, 1.0, 1.0 );
    CGContextBeginPath( context );
    CGContextMoveToPoint( context, minx, midy );
    CGContextAddArcToPoint( context, minx, miny, midx, miny, radius_bl );
    CGContextAddArcToPoint( context, maxx, miny, maxx, midy, radius_br );
    CGContextAddArcToPoint( context, maxx, maxy, midx, maxy, radius_tr );
    CGContextAddArcToPoint( context, minx, maxy, minx, midy, radius_tl );
    CGContextClosePath( context );
    CGContextDrawPath( context, kCGPathFill );
    
    // Create CGImageRef of the main view bitmap content, and then
    // release that bitmap context
    CGImageRef bitmapContext = CGBitmapContextCreateImage( context );
    CGContextRelease( context );
    
    // convert the finished resized image to a UIImage
    UIImage *theImage = [UIImage imageWithCGImage:bitmapContext];
    // image is retained by the property setting above, so we can
    // release the original
    CGImageRelease(bitmapContext);
    
    // return the image
    return theImage;
}

@end
