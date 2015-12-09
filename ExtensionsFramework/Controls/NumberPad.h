//
//  NumberPad.h
//  KADIS
//
//  Created by Lars Kuhnt on 05.03.14.
//  Copyright (c) 2014 Promptus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+Extensions.h"
#import "UIColor+Extensions.h"

@interface NumberPad : UIControl

@property (nonatomic, strong, readonly) NSString * string;

@property (nonatomic, assign) IBOutlet UITextField * target;
@property (nonatomic, strong) NSDecimalNumber * value;
@property (nonatomic, strong) NSString * suffix;
@property (nonatomic, strong) NSString * comma;
@property (nonatomic, assign) NSUInteger maxScale;
@property (nonatomic, strong) NSDecimalNumber * maxValue;
@property (nonatomic, strong) NSDecimalNumber * minValue;
@property (nonatomic, assign) BOOL shouldReset;

- (void)buttonTapped:(id)sender;

@end
