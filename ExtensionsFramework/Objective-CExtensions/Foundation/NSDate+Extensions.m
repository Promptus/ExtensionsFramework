//
//  NSDate+Extensions.m
//  ExtensionsFramework
//
//  Created by Razvan Benga on 12/4/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

#import "NSDate+Extensions.h"
#import "NSNumber+Extensions.h"

@implementation NSDate (Extensions)

- (NSDate *)ce_advance:(NSInteger)seconds calendar:(NSCalendar *)calendar {
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.second = seconds;
    return [calendar dateByAddingComponents:dayComponent toDate:self options:0];
}

- (NSDate *)ce_tomorrow:(NSCalendar*)calendar {
    return [self ce_advance:[@1 ce_days] calendar:calendar];
}

- (NSDate *)ce_yesterday:(NSCalendar*)calendar {
    return [self ce_advance:[@-1 ce_days] calendar:calendar];
}

- (NSDate *)ce_beginningOfWeek:(NSCalendar*)calendar {
    NSDate *beginningOfWeek;
    NSTimeInterval interval;
    [calendar rangeOfUnit:NSCalendarUnitWeekOfYear startDate:&beginningOfWeek interval:&interval forDate:self];
    return beginningOfWeek;
}

- (NSDate *)ce_endOfWeek:(NSCalendar*)calendar {
    NSDate *beginningOfWeek;
    NSTimeInterval interval;
    [calendar rangeOfUnit:NSCalendarUnitWeekOfYear startDate:&beginningOfWeek interval:&interval forDate:self];
    return [beginningOfWeek dateByAddingTimeInterval:interval-1];
}

- (NSDate *)ce_beginningOfDay:(NSCalendar*)calendar {
    NSDate *beginningOfDay;
    NSTimeInterval interval;
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&beginningOfDay interval:&interval forDate:self];
    return beginningOfDay;
}

- (NSDate *)ce_endOfDay:(NSCalendar*)calendar {
    NSDate *beginningOfDay;
    NSTimeInterval interval;
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&beginningOfDay interval:&interval forDate:self];
    return [beginningOfDay dateByAddingTimeInterval:interval-1];
}

- (NSUInteger)ce_calendarWeek:(NSCalendar *)calendar {
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:self];
    return [comps weekday];
}

- (NSUInteger)ce_second:(NSCalendar *)calendar {
    NSDateComponents *comps = [calendar components:NSCalendarUnitSecond fromDate:self];
    return [comps second];
}

- (NSUInteger)ce_minute:(NSCalendar *)calendar {
    NSDateComponents *comps = [calendar components:NSCalendarUnitMinute fromDate:self];
    return [comps minute];
}

- (NSUInteger)ce_hour:(NSCalendar *)calendar {
    NSDateComponents *comps = [calendar components:NSCalendarUnitHour fromDate:self];
    return [comps hour];
}

- (NSUInteger)ce_day:(NSCalendar *)calendar {
    NSDateComponents *comps = [calendar components:NSCalendarUnitDay fromDate:self];
    return [comps day];
}

- (NSUInteger)ce_month:(NSCalendar *)calendar {
    NSDateComponents *comps = [calendar components:NSCalendarUnitMonth fromDate:self];
    return [comps month];
}

- (NSUInteger)ce_year:(NSCalendar *)calendar {
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear fromDate:self];
    return [comps year];
}

- (BOOL)ce_isToday:(NSCalendar *)calendar {
    int mask = NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:(mask) fromDate:[NSDate date]];
    NSDate *today = [calendar dateFromComponents:components];
    components = [calendar components:(mask) fromDate:self];
    NSDate *otherDate = [calendar dateFromComponents:components];
    return [today isEqualToDate:otherDate];
}

-(BOOL)ce_isTomorrow:(NSCalendar *)calendar {
    int mask = NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:(mask) fromDate:[NSDate date]];
    NSDate *tomorrow = [[calendar dateFromComponents:components] ce_advance:[@1 ce_days] calendar:calendar];
    components = [calendar components:(mask) fromDate:self];
    NSDate *otherDate = [calendar dateFromComponents:components];
    return [tomorrow isEqualToDate:otherDate];
}

- (BOOL)ce_isLaterThan:(NSDate *)date {
    return [self compare:date] == NSOrderedDescending;
}

- (BOOL)ce_isEarlierThan:(NSDate *)date {
    return [self compare:date] == NSOrderedAscending;
}

- (NSString *)ce_formattedString:(NSString *)format {
    static NSDateFormatter * formatter;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [NSLocale currentLocale];
    }
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

- (NSDate *)ce_dateWithHour:(NSUInteger)hour minute:(NSUInteger)min second:(NSUInteger)sec calendar:(NSCalendar*)calendar {
    NSUInteger timeComps = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitTimeZone);
    NSDateComponents *components = [calendar components:timeComps fromDate:self];
    [components setHour:hour];
    [components setMinute:min];
    [components setSecond:sec];
    return [calendar dateFromComponents:components];
}


@end
