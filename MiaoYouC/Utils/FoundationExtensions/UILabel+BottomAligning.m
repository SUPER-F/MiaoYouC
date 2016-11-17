//
//  UILabel+BottomAligning.m
//  GoldQ
//
//  Created by Kiet Thai Thuan on 10/13/14.
//  Copyright (c) 2014 ProSoft. All rights reserved.
//

#import "UILabel+BottomAligning.h"

@implementation UILabel (BottomAligning)

- (CGFloat)topAfterBottomAligningWithLabel:(UILabel *)label{
    return (label.frame.origin.y - ((label.frame.origin.y + self.frame.size.height) - (label.frame.origin.y + label.frame.size.height)) + (label.font.descender - self.font.descender));
}


- (void)resizeToStretch{
    float width = [self expectedWidth];
    CGRect newFrame = [self frame];
    newFrame.size.width = width;
    [self setFrame:newFrame];
}

- (float)expectedWidth{
    [self setNumberOfLines:1];
    
    CGSize maximumLabelSize = CGSizeMake(CGRectGetWidth(self.bounds), CGFLOAT_MAX);
    
    CGSize expectedLabelSize = [[self text] sizeWithFont:[self font]
                                       constrainedToSize:maximumLabelSize
                                           lineBreakMode:[self lineBreakMode]];
    
//    CGRect tmpRect = [[self text] boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[self font],NSFontAttributeName, nil] context:nil];
    return expectedLabelSize.width;
}

@end