//
//  WeekPicker.m
//  CocoaExtensions
//
//  Created by Lars Kuhnt on 20.03.14.
//  Copyright (c) 2014 Promptus. All rights reserved.
//

#import "WeekPicker.h"

@implementation WeekPicker

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self setupCarousel];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self setupCarousel];
  }
  return self;
}

- (void)setupCarousel {
  carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width+10, self.frame.size.height)];
  carousel.clipsToBounds = YES;
  carousel.delegate = self;
  carousel.dataSource = self;
  [self addSubview:carousel];
  self.numberOfItems = 80;
  self.numberOfVisibleItems = 7;
}

- (void)load:(NSDate*)date {
  if (self.calendar == nil)
    self.calendar = [NSCalendar currentCalendar];
  if (self.calendarWeekFormatter == nil) {
    self.calendarWeekFormatter = [[NSDateFormatter alloc] init];
    self.calendarWeekFormatter.locale = self.calendar.locale;
    self.calendarWeekFormatter.dateFormat = @"ww";
  }
  if (self.monthAndYearFormatter == nil) {
    self.monthAndYearFormatter = [[NSDateFormatter alloc] init];
    self.monthAndYearFormatter.locale = self.calendar.locale;
    self.monthAndYearFormatter.dateFormat = @"MMM YYYY";
  }
  [self setupWeeks:date];
}

- (void)setupWeeks:(NSDate*)initialDate {
  NSString * initialWeekLabel = initialDate ? [self buildWeekLabel:initialDate] : @"";
  NSInteger initialYear = initialDate ? [initialDate ce_year:self.calendar] : -1;
  weeks = [NSMutableArray arrayWithCapacity:self.numberOfItems];
  int halfNumberOfWeeks = (int)(-7*(self.numberOfItems/2));
  NSNumber * weeksAgo = [NSNumber numberWithInt:halfNumberOfWeeks];
  NSDate * currentWeekDate = [[NSDate date] ce_advance:[weeksAgo ce_days] calendar:self.calendar];
  NSDate * lastWeekDate = currentWeekDate;
  [weeks addObject:[self buildItemDictionary:currentWeekDate lastDate:nil]];
  int initialWeekIndex = -1;
  for (int i = 0; i < self.numberOfItems; i++) {
    currentWeekDate = [currentWeekDate ce_advance:[@7 ce_days] calendar:self.calendar];
    NSDictionary * dict = [self buildItemDictionary:currentWeekDate lastDate:lastWeekDate];
    [weeks addObject:dict];
    if ([[dict objectForKey:@"weekLabel"] isEqualToString:initialWeekLabel] && [currentWeekDate ce_year:self.calendar] == initialYear) {
      initialWeekIndex = i+1;
    }
    lastWeekDate = currentWeekDate;
  }
  [carousel reloadData];
  if (initialWeekIndex > 0)
    [carousel scrollToItemAtIndex:initialWeekIndex animated:NO];
  else
    [self scrollToCurrentWeek:NO];
}

- (NSDictionary*)buildItemDictionary:(NSDate *)currentDate lastDate:(NSDate *)lastDate {
  NSString * monthLabel = @"";
  if (lastDate == nil || [currentDate ce_month:self.calendar] != [lastDate ce_month:self.calendar]) {
    monthLabel = [[self.monthAndYearFormatter stringFromDate:currentDate] uppercaseString];
  }
  NSString * weekLabel = [self buildWeekLabel:currentDate];
  return @{@"date": currentDate, @"monthLabel": monthLabel, @"weekLabel": weekLabel};
}

- (NSString *)buildWeekLabel:(NSDate*)date {
  return [NSString stringWithFormat:@"KW %@", [self.calendarWeekFormatter stringFromDate:date]];
}

- (void)scrollToCurrentWeek:(BOOL)animated {
  [carousel scrollToItemAtIndex:self.numberOfItems/2 animated:animated];
}

- (void)scrollToNextWeek:(BOOL)animated {
  if (carousel.currentItemIndex < weeks.count-1) {
    [carousel scrollToItemAtIndex:carousel.currentItemIndex+1 animated:animated];
  }
}

- (void)scrollToPreviousWeek:(BOOL)animated {
  if (carousel.currentItemIndex > 0) {
    [carousel scrollToItemAtIndex:carousel.currentItemIndex-1 animated:animated];
  }
}

- (void)scrollToDate:(NSDate*)date animated:(BOOL)animated {
  NSString * weekLabel = [self buildWeekLabel:date];
  for (int i = 0; i < weeks.count; i++) {
    NSDictionary * dict = [weeks objectAtIndex:i];
    if ([[dict objectForKey:@"weekLabel"] isEqualToString:weekLabel]) {
      [carousel scrollToItemAtIndex:i animated:animated];
      break;
    }
  }
}

- (NSDate *)getDate {
  return currentWeekPickerItem.date;
}

- (void)reload {
  if (weeks == nil) {
    
  }
}

#pragma mark iCarouselDelegate


- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view {
  if (view == nil) {
    view = [WeekPickerItem loadFromNib:self];
    view.frame = CGRectMake(0, 0, self.frame.size.width/self.numberOfVisibleItems, self.frame.size.height);
  }
  WeekPickerItem * weekPickerItem = (WeekPickerItem *)view;
  NSDictionary * itemDict = [weeks objectAtIndex:index];
  weekPickerItem.date = [itemDict objectForKey:@"date"];
  weekPickerItem.monthLabel.text = [itemDict objectForKey:@"monthLabel"];
  weekPickerItem.weekLabel.text = [itemDict objectForKey:@"weekLabel"];
  return view;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)_carousel {
  if (currentWeekPickerItem) {
    currentWeekPickerItem.selected = NO;
  }
  currentWeekPickerItem = (WeekPickerItem *)[_carousel itemViewAtIndex:_carousel.currentItemIndex];
  currentWeekPickerItem.selected = YES;
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel {
  [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark iCarouselDataSource

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
  return weeks.count;
}

@end
