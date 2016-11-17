//
//  UIView+Extension.m
//  MTS
//
//  Created by Hoang.Ho on 05.09.13.
//  Copyright (c) 2013 InnoTech. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView(Extension)

- (void)removeAllSubviews{
    if (self) {
        for (UIView *subView in self.subviews) {
            [subView removeFromSuperview];
        }
    }
}

@end
