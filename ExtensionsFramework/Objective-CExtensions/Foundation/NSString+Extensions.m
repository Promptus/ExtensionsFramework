//
//  NSString+Extensions.m
//  ExtensionsFramework
//
//  Created by Razvan Benga on 05/11/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

#import "NSString+Extensions.h"

static NSNumberFormatter *floatFormatter;

@implementation NSString (Extensions)

#pragma mark Regular expressions

- (NSArray*)ce_match:(NSString*)pattern {
    return [self ce_match:pattern options:0];
}

- (NSArray*)ce_match:(NSString *)pattern options:(NSRegularExpressionOptions)options {
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:pattern options:options error:nil];
    NSTextCheckingResult * result = [regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
    NSMutableArray * matches = [NSMutableArray arrayWithCapacity:[result numberOfRanges]];
    if (result.range.location != NSNotFound) {
        for (int i = 0; i < [result numberOfRanges]; i++) {
            NSRange range = [result rangeAtIndex:i];
            [matches addObject:[self substringWithRange:range]];
        }
    }
    return matches;
}

- (NSArray*)ce_scan:(NSString*)pattern {
    return [self ce_scan:pattern options:0];
}

- (NSArray*)ce_scan:(NSString *)pattern options:(NSRegularExpressionOptions)options {
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:pattern options:options error:nil];
    NSArray * result = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    NSMutableArray * matches = [NSMutableArray arrayWithCapacity:result.count];
    for (NSTextCheckingResult * match in result) {
        NSRange range = [match range];
        [matches addObject:[self substringWithRange:range]];
    }
    return matches;
}

+ (BOOL)ce_isBlank:(NSString*)string {
    return ![NSString ce_isPresent:string];
}

+ (BOOL)ce_isPresent:(NSString*)string {
    return [string isKindOfClass:[NSString class]] && ![string isEqualToString:@""];
}

- (BOOL)ce_isBlank {
    return [NSString ce_isBlank:self];
}

- (BOOL)ce_isPresent {
    return [NSString ce_isPresent:self];
}

+ (NSString*)ce_blankDefault:(id)value {
    return [value isKindOfClass:[NSString class]] ? value : @"";
}

- (NSString *)ce_urlStringUsingEncoding:(NSStringEncoding)encoding {
    NSString *charactersToLeaveUnescaped = @"!*'\"();:@&=+$,/?%#[]% ";
    return (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                  (CFStringRef) self,
                                                                                  (CFStringRef) charactersToLeaveUnescaped,
                                                                                  NULL,
                                                                                  CFStringConvertNSStringEncodingToEncoding(encoding)));
}

- (NSString *)ce_removeAllWhiteSpaces {
    return [self stringByReplacingOccurrencesOfString:@"\\s" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [self length])];
}

- (NSString *)ce_truncateEmptyStringComponentsSeparatedByCharacter:(NSString *)stringSeparator {
    NSMutableArray *finalStringComponents = [NSMutableArray new];
    
    NSArray *textComponents = [self componentsSeparatedByString:stringSeparator];
    for (NSString *stringComponent in textComponents) {
        if (![[stringComponent ce_removeAllWhiteSpaces] isEqualToString:@""]) {
            [finalStringComponents addObject:stringComponent];
        }
    }
    
    return [finalStringComponents componentsJoinedByString:stringSeparator];
}

- (NSNumber *)numberFromLocalizedString {
    if (!floatFormatter) {
        floatFormatter = [[NSNumberFormatter alloc] init];
        [floatFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [floatFormatter setLocale:[NSLocale currentLocale]];
        [floatFormatter setMaximumFractionDigits:2];
    }
    
    return [floatFormatter numberFromString:self];
}

- (NSDecimalNumber *)decimalNumberFromString {
    return [NSDecimalNumber decimalNumberWithDecimal:[self numberFromLocalizedString].decimalValue];
}


@end
