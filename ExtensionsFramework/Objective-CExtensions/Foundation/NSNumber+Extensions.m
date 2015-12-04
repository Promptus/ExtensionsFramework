//
//  NSNumber+Extensions.m
//  ExtensionsFramework
//
//  Created by Razvan Benga on 12/4/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

#import "NSNumber+Extensions.h"

@implementation NSNumber (Extensions)

- (NSString *)ce_formattedEuro {
    static NSNumberFormatter *formatter;
    if (formatter == nil) {
        formatter = [[NSNumberFormatter alloc] init];
        formatter.usesGroupingSeparator = YES;
        formatter.groupingSeparator = @".";
        formatter.decimalSeparator = @",";
        formatter.positiveFormat = @"#,##0.00 €";
    }
    return [formatter stringFromNumber:self];
}

- (NSString *)ce_formattedRoundedEuroWithoutDecimals {
    static NSNumberFormatter *formatter;
    if (formatter == nil) {
        formatter = [[NSNumberFormatter alloc] init];
        formatter.usesGroupingSeparator = YES;
        formatter.groupingSeparator = @".";
        formatter.maximumFractionDigits = 0;
        formatter.minimumFractionDigits = 0;
        formatter.positiveFormat = @"#,##0 €";
    }
    return [formatter stringFromNumber:self];
}

- (NSDecimalNumber*)ce_decimalNumberDividedByFloat:(float)divider {
    NSDecimal decimal = [[NSNumber numberWithFloat:[self integerValue]/divider] decimalValue];
    return [NSDecimalNumber decimalNumberWithDecimal:decimal];
}

- (NSInteger)ce_minutes {
    return [self integerValue] * 60;
}

- (NSInteger)ce_hours {
    return [self ce_minutes] * 60;
}

- (NSInteger)ce_days {
    return [self ce_hours] * 24;
}

- (NSString*)ce_formattedString:(NSLocale *)locale {
    static NSNumberFormatter * formatter;
    if (formatter == nil)
        formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.locale = locale;
    return [formatter stringFromNumber:self];
}


@end
