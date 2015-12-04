//
//  NSDictionary+Extensions.m
//  ExtensionsFramework
//
//  Created by Razvan Benga on 12/4/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

#import "NSDictionary+Extensions.h"
#import "NSString+Extensions.h"

@implementation NSDictionary (Extensions)

- (NSString *)ce_stringForKey:(NSString*)key {
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSString class]]) {
        return obj;
    }
    return nil;
}

- (NSDecimalNumber *)ce_decimalNumberForKey:(NSString*)key {
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSDecimalNumber class]]) {
        return obj;
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        NSNumber * number = (NSNumber*)obj;
        return [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
    } else if ([obj isKindOfClass:[NSString class]]) {
        NSString * str = (NSString*)obj;
        return [str isEqualToString:@""] ? nil : [NSDecimalNumber decimalNumberWithString:str];
    }
    return nil;
}

- (NSNumber *)ce_numberForKey:(NSString*)key {
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSNumber class]]) {
        return obj;
    } else if ([obj isKindOfClass:[NSString class]]) {
        NSString * str = (NSString*)obj;
        return [str isEqualToString:@""] ? nil : [NSNumber numberWithInt:[str intValue]];
    }
    return nil;
}

- (NSDate *)ce_dateForKey:(NSString *)key withFormatter:(NSDateFormatter *)dateFormatter {
    NSString * obj = [self objectForKey:key];
    if ([NSString ce_isPresent:obj]) {
        return [dateFormatter dateFromString:obj];
    }
    return nil;
}


@end
