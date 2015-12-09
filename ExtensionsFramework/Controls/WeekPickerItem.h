//
//  WeekPickerItem.h
//  CocoaExtensions
//
//  Created by Lars Kuhnt on 20.03.14.
//  Copyright (c) 2014 Promptus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeekPickerItem : UIView

@property (nonatomic, weak) IBOutlet UILabel * monthLabel;
@property (nonatomic, weak) IBOutlet UILabel * weekLabel;

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) NSDate * date;

+ (WeekPickerItem *)loadFromNib:(id)owner;

@end
