//
//  UINavigationController+RotateForMenu.m
//  MTS
//
//  Created by Hoang.Ho on 13.12.13.
//  Copyright (c) 2013 InnoTech. All rights reserved.
//

#import "UINavigationController+RotateForMenu.h"

@implementation UINavigationController (RotateForMenu)

-(BOOL)shouldAutorotate
{
    return [[self.viewControllers lastObject] shouldAutorotate];
}

-(NSUInteger)supportedInterfaceOrientations
{
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

@end
