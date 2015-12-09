//
//  WeekPickerItem.m
//  KADIS
//
//  Created by Lars Kuhnt on 20.03.14.
//  Copyright (c) 2014 Promptus. All rights reserved.
//

#import "WeekPickerItem.h"

@implementation WeekPickerItem

@synthesize monthLabel;
@synthesize weekLabel;
@synthesize selected;
@synthesize date;

+ (WeekPickerItem*)loadFromNib:(id)owner {
  WeekPickerItem* item = [[NSBundle mainBundle] loadNibNamed:@"WeekPickerItem" owner:owner options:nil][0];
  item.selected = NO;
  return item;
}

- (void)setSelected:(BOOL)_selected {
  selected = _selected;
  if (_selected) {
    weekLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    weekLabel.alpha = 1.0f;
  } else {
    weekLabel.font = [UIFont systemFontOfSize:12.0f];
    weekLabel.alpha = 0.3f;
  }
}

@end