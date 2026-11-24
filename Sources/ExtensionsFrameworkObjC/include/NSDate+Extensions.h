//
//  NSDate+Extensions.h
//  ExtensionsFramework
//
//  Created by Razvan Benga on 12/4/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extensions)

- (NSDate *)ce_advance:(NSInteger)seconds calendar:(NSCalendar*)calendar;
- (NSDate *)ce_yesterday:(NSCalendar*)calendar;
- (NSDate *)ce_tomorrow:(NSCalendar*)calendar;
- (NSDate *)ce_beginningOfWeek:(NSCalendar*)calendar;
- (NSDate *)ce_endOfWeek:(NSCalendar*)calendar;
- (NSDate *)ce_beginningOfDay:(NSCalendar*)calendar;
- (NSDate *)ce_endOfDay:(NSCalendar*)calendar;
- (NSUInteger)ce_calendarWeek:(NSCalendar *)calendar;
- (NSUInteger)ce_second:(NSCalendar *)calendar;
- (NSUInteger)ce_minute:(NSCalendar *)calendar;
- (NSUInteger)ce_hour:(NSCalendar *)calendar;
- (NSUInteger)ce_day:(NSCalendar *)calendar;
- (NSUInteger)ce_month:(NSCalendar *)calendar;
- (NSUInteger)ce_year:(NSCalendar *)calendar;
- (BOOL)ce_isToday:(NSCalendar *)calendar;
- (BOOL)ce_isTomorrow:(NSCalendar *)calendar;
- (BOOL)ce_isLaterThan:(NSDate*)date;
- (BOOL)ce_isEarlierThan:(NSDate *)date;

- (NSString*)ce_formattedString:(NSString*)format;
- (NSDate *)ce_dateWithHour:(NSUInteger)hour minute:(NSUInteger)min second:(NSUInteger)sec calendar:(NSCalendar*)calendar;

@end
