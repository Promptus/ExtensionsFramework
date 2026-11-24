//
//  NSString+Extensions.m
//  ExtensionsFramework
//
//  Created by Razvan Benga on 05/11/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

#import "NSString+Extensions.h"
#import "UIFont+TilePadFonts.h"

static NSNumberFormatter *floatFormatter;
static NSDateFormatter *dateFormatter;
static NSArray *dateFormatterList = nil;

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
  NSMutableCharacterSet *allowedChars = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
  [allowedChars addCharactersInString:@"#[]{}<>%"]; //those characters are not defined in URLQueryAllowedCharacterSet
  
  return [self stringByAddingPercentEncodingWithAllowedCharacters:allowedChars];
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

- (NSNumber *)ce_numberFromLocalizedString {
    if (!floatFormatter) {
        floatFormatter = [[NSNumberFormatter alloc] init];
        [floatFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [floatFormatter setLocale:[NSLocale currentLocale]];
        [floatFormatter setMaximumFractionDigits:2];
    }
    
    return [floatFormatter numberFromString:self];
}

- (NSDecimalNumber *)ce_decimalNumberFromString {
    return [NSDecimalNumber decimalNumberWithDecimal:[self ce_numberFromLocalizedString].decimalValue];
}

- (CGFloat)ce_stringFontSizeInsideSuperviewMargins:(CGSize)margins withInitialFontSize:(CGFloat)initialFontSize {
    CGSize frameSize = margins;
    BOOL isContained = NO;
    do {
        CGSize neededSize = [self sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontWithSize:initialFontSize andType:Light]}];
        if (neededSize.width > frameSize.width || neededSize.height > frameSize.height) {
            initialFontSize--;
        } else {
            isContained = YES;
        }
    } while (!isContained);
    
    return initialFontSize;
}

- (NSDate *)ce_dateFromStringWithDestinationFormat:(NSString *)destinationFormat {
    if ([self isKindOfClass:[NSNull class]]) {
        return nil;
    } else {
        __block NSDate *convertedDate = nil;
        
        if (!dateFormatterList) {
            dateFormatterList = @[@"yyyy-MM-dd'T'HH:mm:ss'Z'", @"yyyy-MM-dd'T'HH:mm:ssZ",
                                  @"yyyy-MM-dd'T'HH:mm:ss", @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
                                  @"yyyy-MM-dd'T'HH:mm:ss.SSSZ", @"yyyy-MM-dd HH:mm:ss",
                                  @"MM/dd/yyyy HH:mm:ss", @"MM/dd/yyyy'T'HH:mm:ss.SSS'Z'",
                                  @"MM/dd/yyyy'T'HH:mm:ss.SSSZ", @"MM/dd/yyyy'T'HH:mm:ss.SSS",
                                  @"MM/dd/yyyy'T'HH:mm:ssZ", @"MM/dd/yyyy'T'HH:mm:ss",
                                  @"yyyy:MM:dd HH:mm:ss", @"yyyyMMdd", @"dd-MM-yyyy",
                                  @"dd/MM/yyyy", @"yyyy-MM-dd", @"yyyy/MM/dd",
                                  @"dd MMMM yyyy", @"MMddyyyy", @"MM/dd/yyyy",
                                  @"MM-dd-yyyy", @"d'st' MMMM yyyy",
                                  @"d'nd' MMMM yyyy", @"d'rd' MMMM yyyy",
                                  @"d'th' MMMM yyyy", @"d'st' MMM yyyy",
                                  @"d'nd' MMM yyyy", @"d'rd' MMM yyyy",
                                  @"d'th' MMM yyyy", @"d'st' MMMM",
                                  @"d'nd' MMMM", @"d'rd' MMMM",
                                  @"d'th' MMMM", @"d'st' MMM",
                                  @"d'nd' MMM", @"d'rd' MMM",
                                  @"d'th' MMM", @"MMMM, yyyy",
                                  @"MMMM yyyy"];
        }
        
        if (!dateFormatter) {
            dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
        }
        
        [dateFormatterList enumerateObjectsUsingBlock:^(NSString *dateFormat, NSUInteger idx, BOOL * _Nonnull stop) {
            dateFormatter.dateFormat = dateFormat;
            NSDate *date = [dateFormatter dateFromString:self];
            
            if (date) {
                dateFormatter.dateFormat = destinationFormat;
                convertedDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:date]];
                 *stop = YES;
            }
        }];
        
        return convertedDate;

    }
   
}

@end
