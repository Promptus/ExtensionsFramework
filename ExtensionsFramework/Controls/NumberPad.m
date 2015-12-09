//
//  NumberPad.m
//  KADIS
//
//  Created by Lars Kuhnt on 05.03.14.
//  Copyright (c) 2014 Promptus. All rights reserved.
//

#import "NumberPad.h"

@implementation NumberPad

@synthesize target;
@synthesize value;
@synthesize string;
@synthesize suffix;
@synthesize comma;
@synthesize maxValue;
@synthesize minValue;
@synthesize shouldReset;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self = [[NSBundle mainBundle] loadNibNamed:@"NumberPad" owner:self options:NULL][0];
    self.frame = frame;
    
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    self.target.enabled = NO;
    self.shouldReset = NO;
    string = self.target.text ? self.target.text : @"";
    self.maxScale = 20;
    self.comma = @",";
    UIView * padView = [[NSBundle mainBundle] loadNibNamed:@"NumberPad" owner:self options:NULL][0];
    padView.backgroundColor = self.backgroundColor;
    padView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:padView];
    int buttonWidth = (self.frame.size.width-2)/3;
    int buttonHeight = (self.frame.size.height-3)/4;
    int i = 0;
    for (UIView * subview in padView.subviews) {
      if ([subview isKindOfClass:[UIButton class]]) {
        UIButton * button = (UIButton*)subview;
        int column = i%3;
        int row = i/3;
        button.frame = CGRectMake(column+(column*buttonWidth), row+(row*buttonHeight), buttonWidth, buttonHeight);
        [button ce_setBackgroundColor:self.tintColor forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        i++;
        
      }
    }
  }
  return self;
}

- (void)buttonTapped:(UIButton*)sender {
  if (self.string == nil || self.shouldReset) {
    string = @"";
    self.shouldReset = NO;
  }
  switch (sender.tag) {
    case 10:
      [self appendComma];
      break;
    case 11:
      [self clearLastCharacter];
      break;
    default:
      [self appendCharacter:[[NSNumber numberWithLong:sender.tag] stringValue]];
      break;
  }
}

- (void)setComma:(NSString *)_comma {
  comma = _comma;
  for (UIView * subview in self.subviews) {
    if ([subview isKindOfClass:[UIButton class]]) {
      UIButton * button = (UIButton*)subview;
      if (button.tag == 10) {
        [button setTitle:comma forState:UIControlStateNormal];
        [button setTitle:comma forState:UIControlStateHighlighted];
      }
    }
  }
}

- (void)setValue:(NSDecimalNumber *)_value {
  if (_value == nil) {
    value = nil;
    string = @"";
    [self updateTarget];
  } if (![_value isEqualToNumber:[NSDecimalNumber notANumber]]) {
    NSDecimalNumberHandler * handler = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundBankers scale:self.maxScale raiseOnExactness:NO raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:YES];
    value = [_value decimalNumberByRoundingAccordingToBehavior:handler];
    string = [[value stringValue] stringByReplacingOccurrencesOfString:@"." withString:self.comma];
    [self updateTarget];
  }
}

- (void)updateValue {
  value = [self parseValue:self.string];
}

- (NSDecimalNumber*)parseValue:(NSString*)_string {
  NSString * decimalString = [_string stringByReplacingOccurrencesOfString:self.comma withString:@"."];
  return [NSDecimalNumber decimalNumberWithString:decimalString locale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
}

- (void)updateTarget {
  if (self.suffix && self.string.length > 0) {
    self.target.text = [NSString stringWithFormat:@"%@%@", self.string, self.suffix];
  } else {
    self.target.text = self.string;
  }
}

- (void)appendComma {
  if ([self.string rangeOfString:self.comma].location == NSNotFound) {
    if (self.string.length == 0)
      string = @"0";
    string = [self.string stringByAppendingString:self.comma];
    [self updateValue];
    [self updateTarget];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
  }
}

- (void)appendCharacter:(NSString*)character {
  NSRange range = [self.string rangeOfString:self.comma];
  if (range.location == NSNotFound || (self.string.length - range.location) <= self.maxScale) {
    NSString * tmpString = [self.string isEqualToString:@"0"] ? character : [self.string stringByAppendingString:character];
    NSDecimalNumber * tmpValue = [self parseValue:tmpString];
    if (maxValue && [maxValue compare:tmpValue] == NSOrderedAscending) {
      // do nothing as the value is too big
    } else if (minValue && [minValue compare:tmpValue] == NSOrderedDescending) {
      // do nothing as the value is too small
    } else {
      string = tmpString;
      value = tmpValue;
      [self updateTarget];
      [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
  }
}

- (void)clearLastCharacter {
  if (self.string.length > 0) {
    string = [self.string substringToIndex:self.string.length-1];
    [self updateValue];
    [self updateTarget];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
  }
}

@end
