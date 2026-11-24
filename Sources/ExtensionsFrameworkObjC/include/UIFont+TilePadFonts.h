//
//  UIFont+TilePadFonts.h
//  ExtensionsFramework
//
//  Created by Razvan Benga on 12/17/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FontType) {
    Default = 0,
    Light   = 1,
    Medium  = 2,
    Bold    = 3,
    Italic  = 4
};

@interface UIFont (TilePadFonts)

+ (UIFont *)systemFontWithSize:(CGFloat)fontSize andType:(FontType)fontType;

//font with size set to 10
+ (UIFont *)smallestSystemFontWithType:(FontType)fontType;

//font with size set to 12
+ (UIFont *)smallSystemFontWithType:(FontType)fontType;

//font with size set to 15
+ (UIFont *)regularSystemFontWithType:(FontType)fontType;

//font with size set to 17
+ (UIFont *)mediumSystemFontWithType:(FontType)fontType;

//font with size set to 20
+ (UIFont *)bigSystemFontWithType:(FontType)fontType;

@end
