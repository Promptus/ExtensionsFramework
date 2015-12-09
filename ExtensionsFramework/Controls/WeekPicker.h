//
//  WeekPicker.h
//  CocoaExtensions
//
//  Created by Lars Kuhnt on 20.03.14.
//  Copyright (c) 2014 Promptus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "WeekPickerItem.h"
#import "NSNumber+Extensions.h"
#import "NSDate+Extensions.h"

@interface WeekPicker : UIControl <iCarouselDataSource, iCarouselDelegate> {
  iCarousel * carousel;
  WeekPickerItem * currentWeekPickerItem;
  NSMutableArray * weeks;
}

@property (nonatomic, assign) NSUInteger numberOfItems;
@property (nonatomic, assign) NSUInteger numberOfVisibleItems;
@property (nonatomic, strong) NSCalendar * calendar;
@property (nonatomic, strong) NSDateFormatter * calendarWeekFormatter;
@property (nonatomic, strong) NSDateFormatter * monthAndYearFormatter;

- (void)load:(NSDate*)date;
- (NSDate *)getDate;
- (void)scrollToCurrentWeek:(BOOL)animated;
- (void)scrollToNextWeek:(BOOL)animated;
- (void)scrollToPreviousWeek:(BOOL)animated;
- (void)scrollToDate:(NSDate*)date animated:(BOOL)animated;

@end
