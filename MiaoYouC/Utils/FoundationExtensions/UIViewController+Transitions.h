//
//  UIViewController+Transitions.h
//  MTS
//
//  Created by Duc Duong on 9/6/12.
//  Copyright (c) 2012 InnoTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Transitions)

// make a transition that looks like a modal view 
//  is expanding from a subview
- (void)expandView:(UIView *)sourceView 
toModalViewController:(UIViewController *)modalViewController;

// make a transition that looks like the current modal view 
//  is shrinking into a subview
- (void)dismissModalViewControllerToView:(UIView *)view;

/*
- (void)expandViewOld:(UIView *)sourceView 
toModalViewController:(UIViewController *)modalViewController;
- (void)dismissModalViewControllerToViewOld:(UIView *)view;*/

@end
