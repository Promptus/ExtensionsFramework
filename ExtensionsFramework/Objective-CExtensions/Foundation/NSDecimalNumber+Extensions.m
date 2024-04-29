//
//  NSDecimalNumber+Extensions.m
//  ExtensionsFramework
//
//  Created by Razvan Benga on 12/4/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

#import "NSDecimalNumber+Extensions.h"

@implementation NSDecimalNumber (Extensions)

- (NSDecimalNumber *)ce_roundToScale:(NSUInteger)scale {
    NSDecimalNumberHandler * handler = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundPlain scale:scale raiseOnExactness:NO raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:YES];
    return [self decimalNumberByRoundingAccordingToBehavior:handler];
}

- (NSDecimalNumber*)ce_decimalNumberWithPercentage:(float)percent {
    NSDecimalNumber * percentage = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithFloat:percent] decimalValue]];
    return [self decimalNumberByMultiplyingBy:percentage];
}

- (NSDecimalNumber *)ce_decimalNumberWithDiscountPercentage:(NSDecimalNumber *)discountPercentage {
    NSDecimalNumber * hundred = [NSDecimalNumber decimalNumberWithString:@"100"];
    NSDecimalNumber * percent = [self decimalNumberByMultiplyingBy:[discountPercentage decimalNumberByDividingBy:hundred]];
    return [self decimalNumberBySubtracting:percent];
}

- (NSDecimalNumber *)ce_decimalNumberWithDiscountPercentage:(NSDecimalNumber *)discountPercentage roundToScale:(NSUInteger)scale {
    NSDecimalNumber * value = [self ce_decimalNumberWithDiscountPercentage:discountPercentage];
    return [value ce_roundToScale:scale];
}

- (NSDecimalNumber *)ce_discountPercentageWithBaseValue:(NSDecimalNumber *)baseValue {
    NSDecimalNumber * hundred = [NSDecimalNumber decimalNumberWithString:@"100"];
    NSDecimalNumber * percentage = [[self decimalNumberByDividingBy:baseValue] decimalNumberByMultiplyingBy:hundred];
    return [hundred decimalNumberBySubtracting:percentage];
}

- (NSDecimalNumber *)ce_discountPercentageWithBaseValue:(NSDecimalNumber *)baseValue roundToScale:(NSUInteger)scale {
    NSDecimalNumber * discount = [self ce_discountPercentageWithBaseValue:baseValue];
    return [discount ce_roundToScale:scale];
}

- (NSInteger)ce_integerWithNumberOfDecimalValues:(NSInteger)numberOfDecimals {
    NSDecimalNumberHandler *behaviour = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:numberOfDecimals raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *number = [self decimalNumberByRoundingAccordingToBehavior:behaviour];
    return [number decimalNumberByMultiplyingByPowerOf10: numberOfDecimals].integerValue;
}


@end
