//
//  UILabel+UnderLineText.m
//  MTS
//
//  Created by Hoang.Ho on 22.01.14.
//  Copyright (c) 2014 InnoTech. All rights reserved.
//

#import "UILabel+UnderLineText.h"
#define  kBottomLayerName @"bottomline"

@implementation UILabel (UnderLineText)

- (void)removeUnderline
{
    for (CALayer *layer in self.layer.sublayers) {
        if ([layer.name isEqualToString:kBottomLayerName]) {
            [layer removeFromSuperlayer];
            break;
        }
    }
    [self setNeedsDisplay];
}

- (void)underLine
{
    [self underLine:2
       marginBottom:1
              color:[UIColor lightGrayColor]];
}

- (void)underLine:(int)heightOfLine
{
    [self underLine:heightOfLine
       marginBottom:1
              color:[UIColor lightGrayColor]];
}

- (void)underLine:(int)heightOfLine
     marginBottom:(int)margin
{
    [self underLine:heightOfLine
       marginBottom:margin
              color:[UIColor lightGrayColor]];
}

- (void)underLine:(int)heightOfLine
     marginBottom:(int)margin
            color:(UIColor*)lineColor
{
    CGSize textSize = [self.text sizeWithFont:self.font];
    CALayer *borderLayer = nil;
    for (CALayer *layer in self.layer.sublayers) {
        if ([layer.name isEqualToString:kBottomLayerName]) {
            borderLayer = layer;
            break;
        }
    }
    
    if (borderLayer == nil) {
        borderLayer = [CALayer layer];
        borderLayer.name = kBottomLayerName;
        [self.layer addSublayer:borderLayer];
    }
    borderLayer.borderColor = lineColor.CGColor;
    borderLayer.borderWidth = 1;
    if (self.textAlignment == UITextAlignmentRight)
        borderLayer.frame = CGRectMake(self.bounds.size.width - textSize.width - 1, self.bounds.size.height - margin, textSize.width, heightOfLine);
    else
        borderLayer.frame = CGRectMake(0, self.bounds.size.height - margin, textSize.width, heightOfLine);
    [self setNeedsDisplay];
}

@end
