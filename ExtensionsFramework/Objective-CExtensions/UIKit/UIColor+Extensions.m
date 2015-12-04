//
//  UIColor+Extensions.m
//  CocoaExtensions
//
//  Created by Lars Kuhnt on 06.03.14.
//  Copyright (c) 2014 Promptus. All rights reserved.
//

#import "UIColor+Extensions.h"

@implementation UIColor (Extensions)

#pragma mark - Category Methods
// Direct Conversion to hexadecimal (Automatic)
+ (UIColor *)ce_colorWithHex:(UInt32)hexadecimal {
	CGFloat red, green, blue;
  
	// bitwise AND operation
	// hexadecimal's first 2 values
	red = ( hexadecimal >> 16 ) & 0xFF;
	// hexadecimal's 2 middle values
	green = ( hexadecimal >> 8 ) & 0xFF;
	// hexadecimal's last 2 values
	blue = hexadecimal & 0xFF;
  
	UIColor *color = [UIColor colorWithRed: red / 255.0f green: green / 255.0f blue: blue / 255.0f alpha: 1.0f];
	return color;
}

+ (UIColor *)ce_colorWithAlphaHex:(UInt32)hexadecimal {
	CGFloat red, green, blue, alpha;
  
	// bitwise AND operation
	// hexadecimal's first 2 values
	alpha = ( hexadecimal >> 24 ) & 0xFF;
	// hexadecimal's third and fourth values
	red = ( hexadecimal >> 16 ) & 0xFF;
	// hexadecimal's fifth and sixth values
	green = ( hexadecimal >> 8 ) & 0xFF;
	// hexadecimal's seventh and eighth
	blue = hexadecimal & 0xFF;
  
	UIColor *color = [UIColor colorWithRed: red / 255.0f green: green / 255.0f blue: blue / 255.0f alpha: alpha / 255.0f];
  return color;
}

@end
