//
//  CALayer+InterspaceBorder.h
//  ExtensionsFramework
//
//  Created by Razvan Benga on 26/01/16.
//  Copyright © 2016 Razvan Benga. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (InterspaceBorder)

- (void)addBorderForFrame:(CGRect)frame withSpacing:(float)spacing andColor:(UIColor *)color;
- (void)removeInterspaceBorder;

@end
