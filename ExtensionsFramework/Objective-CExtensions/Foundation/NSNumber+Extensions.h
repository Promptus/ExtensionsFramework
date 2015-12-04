//
//  NSNumber+Extensions.h
//  ExtensionsFramework
//
//  Created by Razvan Benga on 12/4/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Extensions)

- (NSString *)ce_formattedEuro;
- (NSString *)ce_formattedRoundedEuroWithoutDecimals;
- (NSDecimalNumber*)ce_decimalNumberDividedByFloat:(float)divider;
- (NSInteger)ce_minutes;
- (NSInteger)ce_hours;
- (NSInteger)ce_days;
- (NSString*)ce_formattedString:(NSLocale*)locale;

@end
