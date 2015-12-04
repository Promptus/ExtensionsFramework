//
//  NSString+Extensions.h
//  ExtensionsFramework
//
//  Created by Razvan Benga on 05/11/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extensions)

#pragma mark Regular expressions
- (NSArray*)ce_match:(NSString*)pattern;
- (NSArray*)ce_match:(NSString *)pattern options:(NSRegularExpressionOptions)options;
- (NSArray*)ce_scan:(NSString*)pattern;
- (NSArray*)ce_scan:(NSString *)pattern options:(NSRegularExpressionOptions)options;

+ (BOOL)ce_isPresent:(NSString*)string;
+ (BOOL)ce_isBlank:(NSString*)string;
- (BOOL)ce_isPresent;
- (BOOL)ce_isBlank;

+ (NSString*)ce_blankDefault:(id)value;

- (NSString *)ce_urlStringUsingEncoding:(NSStringEncoding)encoding;
- (NSString *)ce_removeAllWhiteSpaces;
- (NSString *)ce_truncateEmptyStringComponentsSeparatedByCharacter:(NSString *)stringSeparator;

- (NSNumber *)numberFromLocalizedString;
- (NSDecimalNumber *)decimalNumberFromString;

@end
