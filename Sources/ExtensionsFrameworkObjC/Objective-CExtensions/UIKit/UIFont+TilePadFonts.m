//
//  UIFont+TilePadFonts.m
//  ExtensionsFramework
//
//  Created by Razvan Benga on 12/17/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

#import "UIFont+TilePadFonts.h"

static NSMutableDictionary *defaultFonts;
static NSMutableDictionary *lightFonts;
static NSMutableDictionary *mediumFonts;
static NSMutableDictionary *boldFonts;
static NSMutableDictionary *italicFonts;

@implementation UIFont (TilePadFonts)

+ (UIFont *)systemFontWithSize:(CGFloat)fontSize andType:(FontType)fontType {
    NSString *fontKey = @(fontSize).stringValue;
    
    switch (fontType) {
        case Default:
            return [self getDefaultFontWithKey:fontKey];
            break;
        case Light:
            return [self getLightFontWithKey:fontKey];
            break;
        case Medium:
            return [self getMediumFontWithKey:fontKey];
            break;
        case Bold:
            return [self getBoldFontWithKey:fontKey];
            break;
        case Italic:{
            return [self getItalicFontWithKey:fontKey];
            break;
        }
        default:
            break;
    }
}

+ (UIFont *)smallestSystemFontWithType:(FontType)fontType {
    return [self systemFontWithSize:10.0f andType:fontType];
}

+ (UIFont *)smallSystemFontWithType:(FontType)fontType {
    return [self systemFontWithSize:12.0f andType:fontType];
}

+ (UIFont *)regularSystemFontWithType:(FontType)fontType {
    return [self systemFontWithSize:15.0f andType:fontType];
}

+ (UIFont *)mediumSystemFontWithType:(FontType)fontType {
    return [self systemFontWithSize:17.0f andType:fontType];
}

+ (UIFont *)bigSystemFontWithType:(FontType)fontType {
    return [self systemFontWithSize:20.0f andType:fontType];
}


#pragma mark Helper methods

+ (UIFont *)getDefaultFontWithKey:(NSString *)fontKey {
    if (!defaultFonts) {
        defaultFonts = [NSMutableDictionary new];
    }
    
    if (!defaultFonts[fontKey]) {
        defaultFonts[fontKey] = [UIFont systemFontOfSize:fontKey.floatValue];
    }
    return defaultFonts[fontKey];
}

+ (UIFont *)getBoldFontWithKey:(NSString *)fontKey {
    if (!boldFonts) {
        boldFonts = [NSMutableDictionary new];
    }
    
    if (!boldFonts[fontKey]) {
        boldFonts[fontKey] = [UIFont boldSystemFontOfSize:fontKey.floatValue];
    }
    return boldFonts[fontKey];
}

+ (UIFont *)getItalicFontWithKey:(NSString *)fontKey {
    if (!italicFonts) {
        italicFonts = [NSMutableDictionary new];
    }
    
    if (!italicFonts[fontKey]) {
        italicFonts[fontKey] = [UIFont italicSystemFontOfSize:fontKey.floatValue];
    }
    return italicFonts[fontKey];
}

+ (UIFont *)getLightFontWithKey:(NSString *)fontKey {
    if (!lightFonts) {
        lightFonts = [NSMutableDictionary new];
    }
    
    if (!lightFonts[fontKey]) {
        lightFonts[fontKey] = [UIFont systemFontOfSize:fontKey.floatValue weight:UIFontWeightLight];
    }
    return lightFonts[fontKey];
}

+ (UIFont *)getMediumFontWithKey:(NSString *)fontKey {
    if (!mediumFonts) {
        mediumFonts = [NSMutableDictionary new];
    }
    
    if (!mediumFonts[fontKey]) {
        mediumFonts[fontKey] = [UIFont systemFontOfSize:fontKey.floatValue weight:UIFontWeightMedium];
    }
    return mediumFonts[fontKey];
}


@end
