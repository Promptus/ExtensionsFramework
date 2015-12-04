//
//  NSDictionary+Extensions.h
//  ExtensionsFramework
//
//  Created by Razvan Benga on 12/4/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extensions)

- (NSString*)ce_stringForKey:(NSString*)key;
- (NSNumber*)ce_numberForKey:(NSString*)key;
- (NSDecimalNumber*)ce_decimalNumberForKey:(NSString*)key;
- (NSDate *)ce_dateForKey:(NSString *)key withFormatter:(NSDateFormatter *)dateFormatter;

@end
