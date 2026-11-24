//
//  NSDecimalNumber+Extensions.h
//  ExtensionsFramework
//
//  Created by Razvan Benga on 12/4/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber (Extensions)

- (NSDecimalNumber*)ce_roundToScale:(NSUInteger)scale;
- (NSDecimalNumber*)ce_decimalNumberWithPercentage:(float)percent;
- (NSDecimalNumber*)ce_decimalNumberWithDiscountPercentage:(NSDecimalNumber *)discountPercentage;
- (NSDecimalNumber*)ce_decimalNumberWithDiscountPercentage:(NSDecimalNumber *)discountPercentage roundToScale:(NSUInteger)scale;
- (NSDecimalNumber*)ce_discountPercentageWithBaseValue:(NSDecimalNumber *)baseValue;
- (NSDecimalNumber*)ce_discountPercentageWithBaseValue:(NSDecimalNumber *)baseValue roundToScale:(NSUInteger)scale;
- (NSInteger)ce_integerWithNumberOfDecimalValues:(NSInteger)numberOfDecimals;

@end
