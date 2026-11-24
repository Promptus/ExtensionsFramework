//
//  CALayer+InterspaceBorder.m
//  ExtensionsFramework
//
//  Created by Razvan Benga on 26/01/16.
//  Copyright © 2016 Razvan Benga. All rights reserved.
//

#import "CALayer+InterspaceBorder.h"

@implementation CALayer (InterspaceBorder)

- (void)addBorderForFrame:(CGRect)frame withSpacing:(float)spacing andColor:(UIColor *)color {
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(-spacing, frame.size.height + spacing - 1, frame.size.width + (2.0 * spacing), 1.0f);
    bottomBorder.backgroundColor = color.CGColor;
    
    CALayer *leftBorder = [CALayer layer];
    leftBorder.frame = CGRectMake(-spacing, -spacing, 1.0f, frame.size.height + (2.0 * spacing));
    leftBorder.backgroundColor = color.CGColor;
    
    CALayer *rightBorder = [CALayer layer];
    rightBorder.frame = CGRectMake(frame.size.width + spacing, -spacing, 1.0f, frame.size.height + (2.0 * spacing));
    rightBorder.backgroundColor = color.CGColor;
    
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(-spacing, -spacing, frame.size.width + (2.0 * spacing), 1.0f);
    topBorder.backgroundColor = color.CGColor;
    
    [self addSublayer:bottomBorder];
    [self addSublayer:leftBorder];
    [self addSublayer:topBorder];
    [self addSublayer:rightBorder];
}

- (void)removeInterspaceBorder {
    [self.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
}


@end
