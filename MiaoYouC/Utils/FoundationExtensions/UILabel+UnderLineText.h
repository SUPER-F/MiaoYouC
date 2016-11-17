//
//  UILabel+UnderLineText.h
//  MTS
//
//  Created by Hoang.Ho on 22.01.14.
//  Copyright (c) 2014 InnoTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (UnderLineText)
- (void)removeUnderline;
- (void)underLine;
- (void)underLine:(int)heightOfLine;
- (void)underLine:(int)heightOfLine
     marginBottom:(int)margin;
- (void)underLine:(int)heightOfLine
     marginBottom:(int)margin
            color:(UIColor*)lineColor;

@end
